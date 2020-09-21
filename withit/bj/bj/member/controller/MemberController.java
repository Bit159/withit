package bj.member.controller;

import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
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
	
	@GetMapping("/notice/noticeWriteForm")
	public String noticeForm() {
		return "/bj/admin/noticeWrite";
	}
	
	@GetMapping("/notice/noticeModifyForm")
	public ModelAndView noticeModifyForm(@RequestParam int bno) {
		BBoardDTO bBoardDTO = memberService.getNotice(bno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("bBoardDTO", bBoardDTO);
		
		mav.setViewName("/bj/admin/noticeModify");
		
		return mav;
	}
	
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
	
	//====================================================== 공지사항 보드뷰
	
	@GetMapping("/notice/{bno}")
	public ModelAndView freeBoardView(@PathVariable("bno") int bno
								  	  ,@RequestParam(required=false, defaultValue = "1") int pg
								  	  ,@RequestParam(required=false, defaultValue = "1") int range
								  	  ,@RequestParam(required = false, defaultValue = "title") String searchType
								  	  ,@RequestParam(required = false) String keyword
								  	  ,HttpServletRequest request
								  	  ,Principal principal) throws Exception {
		
		// 검색
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		// 페이지
		int page =  pg;
		System.out.println("페이지"+page+"범위"+range);
		
		// 검색, 페이징 적용된 전체 게시글 수
		int listCnt = boardService.getBBoardListCnt(search); 
		
		// 검색
		search.pageInfo(page, range, listCnt);
		
		// 페이지네이션
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 
		System.out.println("paging: "+paging);	
		
		// 원글 불러오기
		BBoardDTO bBoardDTO = memberService.getNotice(bno);
		
		// 보드뷰 하단부 검색, 페이징 적용된 보드리스트
		List<BBoardDTO> list = memberService.getNoticeList(search);
		System.out.println(bBoardDTO.getTitle());
		
		// 보드뷰 해당 리플 리스트
		List<BBoardReplyDTO> replyList = memberService.getNoticeReplyList(bno);
		
		// 조회수 1증가
		memberService.noticeHipUpdate(bno);
		
		// 작성시간 표시 위한 현재 Date 객체
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("paging",search);
		mav.addObject("bBoardDTO", bBoardDTO);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("replyList", replyList);
		
		//bj.member.controller.LoginSuccessHandler 에서 로그인 성공 시 session에 nickname 담아둠.
		//세션에 담긴 nickname과 선택한 글의 nickname값을 검증하여 mav 객체에 boolean 결과값을 담아서 view로 보냄
		boolean isAuthor = false;
		if(principal != null) {
			if(bBoardDTO.getUsername().equals(principal.getName())) {
				isAuthor = true;
			}
		}
		/*
		 * if(bBoardDTO.getUsername().equals(request.getSession().getAttribute(
		 * "nickname"))) { isAuthor = true; }
		 */
		System.out.println(isAuthor);
		mav.addObject("isAuthor", isAuthor);
		mav.setViewName("/bj/all/noticeView");
		return mav;
	}
	
	//================================================== 공지사항 댓글 추가
	
	@PostMapping("/notice/noticeReply")
	public ModelAndView noticeReply(@RequestParam String reply, int bno, Principal principal) {
		String username = principal.getName();
		String nickname = memberService.getNickname(username);
		List<BBoardReplyDTO> replyList = memberService.getNoticeReplyList(bno);
		Date now = new Date();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno",bno);
		map.put("reply", reply);
		map.put("username", username);
		map.put("nickname", nickname);
		map.put("now", now);
		memberService.noticeReply(map);
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("replyList", replyList);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	//======================================================= 공지사항 댓글 삭제
	
	@PostMapping("/notice/replyDelete")
	@ResponseBody
	public void replyDelete(@RequestParam int rno, int bno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("rno", rno);
		map.put("bno", bno);
		memberService.noticeReplyDelete(map);
	}
	
	//======================================================= 공지사항 댓글 수정
	
	@PostMapping("/notice/replyModify")
	@ResponseBody
	public void noticeReply(@RequestParam String reply, int rno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rno",rno);
		map.put("reply", reply);
		
		memberService.noticeReplyModify(map);
	}
	
	//======================================================= 공지사항 삭제
	
	@PostMapping("/notice/noticeDelete")
	@ResponseBody
	public void noticeDelete(@RequestParam int bno) {
		System.out.println(bno);
		memberService.noticeDelete(bno);
	}
	
	//======================================================= 공지사항 작성
	
	
	@PostMapping("/notice/noticeWrite")
	@ResponseBody
	public String noticeWrite(@RequestParam String title, String content, Principal principal, HttpServletRequest request) {
		Date now = new Date();
		
		String username = principal.getName();
		String nickname = memberService.getNickname(username);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("title",title);
		map.put("content",content);
		map.put("username", username);
		map.put("nickname", nickname);
		map.put("now", now);
		
		memberService.noticeWrite(map); 
		
		return "success";
	}
	
	@PostMapping("/notice/noticeModify")
	@ResponseBody
	public String noticeModify(@RequestParam String title, String content, Principal principal, HttpServletRequest request, int bno) {
		Date now = new Date();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("title",title);
		map.put("content",content);
		map.put("now", now);
		map.put("bno", bno);
		memberService.noticeModify(map);
		
		return "success";
	}
	
	
}
