package bj.member.controller;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.social.google.api.plus.moments.ReviewActivity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bj.member.bean.ChattingDTO;
import bj.member.bean.ChattingRoomDTO;
import bj.member.bean.MemberDTO;
import bj.member.service.MemberService;
import rich.notify.Email;

@Controller
public class MemberController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private Email email;
	
	//=========================================== 로그인
	
	@GetMapping("/loginForm")
	public String loginForm() {
		return "/kh/all/loginForm";
	}
	
	// =========================================== 소셜 로그인 관련
	
	@PostMapping("/all/addInfoForm")
	public String addInfoForm(@RequestParam String email, Model model) {
		model.addAttribute("username", email);
		return "/bj/all/addInfoForm";
	}

	@PostMapping("all/addInfo")
	public String addInfo(@RequestParam Map<String, String> map) {
		map.put("password", "bitcamp159");
		memberService.join(map);

		return "redirect:/";
	}

	@PostMapping("/checkMember")
	@ResponseBody
	public String checkMember(@RequestParam String username) {
		MemberDTO memberDTO = memberService.checkMember(username);
		
		if (memberDTO != null) {
			return "bitcamp159";

		} else {
			return "none";
		}

	}
	
	//============================================================== 비밀번호 찾기
	
	@PostMapping("/findPwd")
	@ResponseBody
	public String findPwd(@RequestParam String username) {
		String reUsername = username.substring(1, username.length() -1); //json은 앞뒤로 "가 붙어서 오므로 빼준당.
		MemberDTO memberDTO = memberService.checkMember(reUsername);
		
		if(memberDTO == null) {
			return "none";
		
		}else {
			String newPwd = UUID.randomUUID().toString().substring(0, 10);
			email.send(reUsername, "withIT 변경된 새로운 비밀번호입니다.", "변경된 새로운 비밀번호는\n" + newPwd + " 입니다.");
			Map<String, String> map = new HashedMap<String, String>();
			map.put("username", reUsername);
			map.put("password", newPwd);
			
			memberService.newPwd(map);
			
			return "ok";
		}
	}
	
	//============================================================== 채팅방
		
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
