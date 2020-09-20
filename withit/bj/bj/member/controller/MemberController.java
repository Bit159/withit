package bj.member.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bj.member.bean.ChattingDTO;
import bj.member.bean.ChattingRoomDTO;
import bj.member.bean.MemberDTO;
import bj.member.service.MemberService;
import rich.notify.Email;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.paging.Pagination;
import sj.board.paging.Search;
import sj.board.service.BoardService;

@Controller
public class MemberController{
	@Autowired
	private MemberService memberService;
	@Autowired
	private Email email;
	@Autowired
	private BoardService boardService;
	
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
		
		String result = "";
		if(memberDTO == null) result = "none";
		else result = reUsername;
		
		return result;
	}
	
	//============================================================== 채팅방
	
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
	
	//=========================================================== 공지사항
	
	@GetMapping("/notice")
	public ModelAndView notice(@RequestParam(required=false, defaultValue = "1") int pg
						   	 ,@RequestParam(required=false, defaultValue = "1") int range
						   	 , @RequestParam(required = false, defaultValue = "title") String searchType
							 , @RequestParam(required = false) String keyword
							 , @ModelAttribute("search") Search search) throws Exception {
		
		/* Search search = new Search(); */
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		// 페이지
		int page =  pg;
		System.out.println("페이지"+page+"범위"+range);
		
		// 검색, 페이징 적용된 전체 게시글 수
		int listCnt = boardService.getBBoardListCnt(search); 
		int listCntN = memberService.getNoticeListCnt(search);
		
		// 검색
		search.pageInfo(page, range, listCntN);
		
		// 페이지네이션
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCntN); 
		System.out.println("paging: "+paging);
		
		// 검색, 페이징 적용된 보드리스트
		//List<BBoardDTO> list = boardService.getBBoardList(search); 
		List<BBoardDTO> list = memberService.getNoticeList(search);
		
		// 작성시간 표시 위한 현재 Date 객체
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		// 검색
		mav.addObject("search",search);
		// 페이징(검색 적용)
		mav.addObject("paging",search);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.setViewName("/bj/all/notice");
		return mav;

	}
	
}
