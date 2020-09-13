package bj.member.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.connect.GoogleConnectionFactory;
import org.springframework.social.oauth2.GrantType;
import org.springframework.social.oauth2.OAuth2Operations;
import org.springframework.social.oauth2.OAuth2Parameters;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import bj.member.bean.ChattingDTO;
import bj.member.bean.ChattingRoomDTO;
import bj.member.bean.MemberDTO;
import bj.member.service.MemberService;

@Controller
public class MemberController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private GoogleConnectionFactory googleConnectionFactory;
	@Autowired
	private OAuth2Parameters googleOAuth2Parameter;
	
	//=========================================== 로그인
	
	@GetMapping("/loginForm")
	public String loginForm(Model model) {
		OAuth2Operations oauth2Operations = googleConnectionFactory.getOAuthOperations();
		String url = oauth2Operations.buildAuthenticateUrl(GrantType.AUTHORIZATION_CODE, googleOAuth2Parameter);
		model.addAttribute("google_url", url);
		return "/kh/all/loginForm";
	}
	
	@PostMapping("/socialLogin")
	@ResponseBody
	public void socialLogin(@RequestParam String username1) throws Exception{
		HttpPost httpPost = new HttpPost("http://localhost:8080/login");
		
		System.out.println(username1);
		
		HttpClient httpClient = HttpClientBuilder.create().build();
		
		List<NameValuePair> param = new ArrayList<NameValuePair>();
		param.add(new BasicNameValuePair("username", username1));
		param.add(new BasicNameValuePair("password", "bitcamp159"));
		
		httpPost.setEntity(new UrlEncodedFormEntity(param));
		
		HttpResponse response = httpClient.execute(httpPost);

		HttpEntity entity =  response.getEntity();
		String content = EntityUtils.toString(entity);
		System.out.println(content + 1);
		
		//return "/all/socialLogin";
	}

	//==========================================구글 로그인 콜백메소드
	@RequestMapping(value="/googleLogin", method= {RequestMethod.GET, RequestMethod.POST})
	public String googleCallBack(@RequestParam String code, RedirectAttributes attr) {
		//여기서 이메일 값을 받아올 수 없어서 따로 처리를 한다.
		attr.addAttribute("password", "bitcamp159");
		System.out.println("콜백메서드");
		return "redirect:/all/loginForm";

	}
	
	  
	//============================================================== 채팅방
		
	@GetMapping("/member/chatting")
	public String chatting() {
		return "/member/chatting";
	}

	@GetMapping("/member/chattingList")
	public String chattingList() {
		return "/member/chattingList";
	}
	
	@PostMapping("/member/getChattingRoom")
	@ResponseBody
	public ModelAndView getChattingRoom(@RequestParam String username, HttpSession session) {
		ModelAndView mav = new ModelAndView();
		List<ChattingRoomDTO> list = memberService.getChattingRoom(username);
		
		session.setAttribute("chattingCheck", "create");	
		System.out.println(session.getAttribute("SPRING_SECURITY_CONTEXT"));
		
		for(ChattingRoomDTO dto : list) {
			ChattingDTO chattingDTO = memberService.getLastChatting(dto.getChattingRoom());
			dto.setChat(chattingDTO.getChat());
			dto.setChat_date(chattingDTO.getChat_date());
			dto.setNickname(chattingDTO.getNickname());
			dto.setUsername(username);
		}
		
		mav.addObject("list", list);
		mav.setViewName("jsonView");
		
		return mav;
	}
	@GetMapping("/member/getAllChatting")
	@ResponseBody
	public ModelAndView getAllChatting() {
		ModelAndView mav = new ModelAndView();
		ChattingRoomDTO chattingRoomDTO = memberService.getAllChatting();
		mav.addObject("chattingRoomDTO", chattingRoomDTO);
		mav.setViewName("jsonView");
		
		return mav;
	}
	  
	@PostMapping("/member/getChatting")
	@ResponseBody
	public ModelAndView getChatting(@RequestParam String chattingRoom) {
		ModelAndView mav = new ModelAndView();
		System.out.println(chattingRoom);
		List<ChattingDTO> list = memberService.getChatting(chattingRoom);
		mav.addObject("list", list);
		mav.setViewName("jsonView");
		  
		return mav;
	}
	  
	@GetMapping("/member/createChat")
	@ResponseBody
	public void createChat() {
		memberService.createChat();
	}
	
}
