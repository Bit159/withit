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
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.paging.Pagination;
import sj.board.paging.Search;

@Controller
public class MemberController{
	@Autowired
	private MemberService memberService;
	
	//=========================================== 로그인
	
	@GetMapping("/loginForm")
	public String loginForm() {
		return "/kh/all/loginForm";
	}
	
	@PostMapping("/loginCheck")
	@ResponseBody
	public String loginCheck(@RequestParam Map<String, String> map) {
		System.out.println(map.get("username"));
		String result = memberService.loginCheck(map);
		return result;
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
		String reUsername = username.substring(1, username.length() -1); //json 으로 받기아서 쌍따옴표가 추가된 채로 받기때문에 처음과 끝을 빼준다.
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
		
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		int page =  pg;
		
		//검색, 페이징 적용된 전체 게시글 수
		int listCntN = memberService.getNoticeListCnt(search);
		
		//검색
		search.pageInfo(page, range, listCntN);
		
		//페이지네이션
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCntN); 
		System.out.println("paging: "+paging);
		
		//검색, 페이징 적용된 보드리스트
		List<BBoardDTO> list = memberService.getNoticeList(search);
		
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("search",search);
		mav.addObject("paging",search);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.setViewName("/bj/all/notice");
		return mav;

	}
	
	//====================================================== 고지사항 보드뷰
	
	@GetMapping("/notice/{bno}")
	public ModelAndView freeBoardView(@PathVariable("bno") int bno
								  	  ,@RequestParam(required=false, defaultValue = "1") int pg
								  	  ,@RequestParam(required=false, defaultValue = "1") int range
								  	  ,@RequestParam(required = false, defaultValue = "title") String searchType
								  	  ,@RequestParam(required = false) String keyword
								  	  ,HttpServletRequest request
								  	  ,Principal principal) throws Exception {
		
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		int page =  pg;
		
		int listCnt = memberService.getNoticeListCnt(search); 
		
		search.pageInfo(page, range, listCnt);
		
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 
		System.out.println("paging: "+paging);	
		
		BBoardDTO bBoardDTO = memberService.getNotice(bno);
		
		List<BBoardDTO> list = memberService.getNoticeList(search);
		System.out.println(bBoardDTO.getTitle());
		
		List<BBoardReplyDTO> replyList = memberService.getNoticeReplyList(bno);
		
		memberService.noticeHipUpdate(bno);
		
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("paging",search);
		mav.addObject("bBoardDTO", bBoardDTO);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("replyList", replyList);
		
		boolean isAuthor = false;
		if(principal != null) {
			if(bBoardDTO.getUsername().equals(principal.getName())) {
				isAuthor = true;
			}
		}
		System.out.println(isAuthor);
		mav.addObject("isAuthor", isAuthor);
		mav.setViewName("/bj/all/noticeView");
		return mav;
	}
	
	//================================================== 공지사항 댓글달기
	
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
	
	//======================================================= 골지사항 댓글 삭제
	
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
	
	//======================================================= QnA
	
	@GetMapping("/qna")
	public ModelAndView qna(@RequestParam(required=false, defaultValue = "1") int pg
		   	 ,@RequestParam(required=false, defaultValue = "1") int range
		   	 , @RequestParam(required = false, defaultValue = "title") String searchType
			 , @RequestParam(required = false) String keyword
			 , @ModelAttribute("search") Search search) throws Exception {
		
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		int page =  pg;
		
		int listCnt = memberService.getQnaListCnt(search);
		
		search.pageInfo(page, range, listCnt);
		
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 
		System.out.println("paging: "+paging);
		
		List<BBoardDTO> list = memberService.getQnaList(search);
		
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("search",search);
		mav.addObject("paging",search);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.setViewName("/bj/all/qna");
		
		return mav;
	}
	
	//================================================== QnA 보드뷰
	 
	@GetMapping("/qna/{bno}")
	public ModelAndView qnaView(@PathVariable("bno") int bno
						  	  ,@RequestParam(required=false, defaultValue = "1") int pg
						  	  ,@RequestParam(required=false, defaultValue = "1") int range
						  	  ,@RequestParam(required = false, defaultValue = "title") String searchType
						  	  ,@RequestParam(required = false) String keyword
						  	  ,HttpServletRequest request
						  	  ,Principal principal) throws Exception {
		
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		int page =  pg;
		
		int listCnt = memberService.getQnaListCnt(search); 
		
		search.pageInfo(page, range, listCnt);
		
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 

		BBoardDTO bBoardDTO = memberService.getQna(bno);
		
		List<BBoardDTO> list = memberService.getQnaList(search);
		
		List<BBoardReplyDTO> replyList = memberService.getQnaReplyList(bno);
		
		memberService.qnaHipUpdate(bno);
		
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("paging",search);
		mav.addObject("bBoardDTO", bBoardDTO);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("replyList", replyList);
		
		boolean isAuthor = false;
		if(principal != null) {
			if(bBoardDTO.getUsername().equals(principal.getName())) {
				isAuthor = true;
			}
		}
		mav.addObject("isAuthor", isAuthor);
		mav.setViewName("/bj/all/qnaView");
		return mav;
	}
	
	//================================================== QnA 댓글
	
		@PostMapping("/qna/qnaReply")
		public ModelAndView qnaReply(@RequestParam String reply, int bno, Principal principal) {
			String username = principal.getName();
			String nickname = memberService.getNickname(username);
			List<BBoardReplyDTO> replyList = memberService.getQnaReplyList(bno);
			Date now = new Date();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bno",bno);
			map.put("reply", reply);
			map.put("username", username);
			map.put("nickname", nickname);
			map.put("now", now);
			memberService.qnaReply(map);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("replyList", replyList);
			mav.setViewName("jsonView");
			
			return mav;
		}
		
		//======================================================= QnA 댓글 삭제
		
		@PostMapping("/qna/replyDelete")
		@ResponseBody
		public void qnaDelete(@RequestParam int rno, int bno) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("rno", rno);
			map.put("bno", bno);
			memberService.qnaReplyDelete(map);
		}
		
		//======================================================= QnA 댓글 수정
		
		@PostMapping("/qna/replyModify")
		@ResponseBody
		public void qnaReply(@RequestParam String reply, int rno) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("rno",rno);
			map.put("reply", reply);
			
			memberService.qnaReplyModify(map);
		}
		
		//======================================================= QnA 삭제
		
		@PostMapping("/qna/qnaDelete")
		@ResponseBody
		public void qnaDelete(@RequestParam int bno) {
			System.out.println(bno);
			memberService.qnaDelete(bno);
		}
		
		//======================================================= QnA 폼
		
		@GetMapping("/qna/qnaWriteForm")
		public String qnaWriteForm() {
			return "/bj/member/qnaWriteForm";
		}
		
		@GetMapping("/qna/qnaModifyForm")
		public ModelAndView qnaModifyForm(@RequestParam int bno) {
			BBoardDTO bBoardDTO = memberService.getQna(bno);
			ModelAndView mav = new ModelAndView();
			mav.addObject("bBoardDTO", bBoardDTO);
			
			mav.setViewName("/bj/member/qnaModifyForm");
			
			return mav;
		}
		
		//======================================================= QnA 작성, 수정
		
		@PostMapping("/qna/qnaWrite")
		@ResponseBody
		public String qnaWrite(@RequestParam String title, String content, Principal principal, HttpServletRequest request) {
			Date now = new Date();
			
			String username = principal.getName();
			String nickname = memberService.getNickname(username);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("title",title);
			map.put("content",content);
			map.put("username", username);
			map.put("nickname", nickname);
			map.put("now", now);
			
			memberService.qnaWrite(map); 
			
			return "success";
		}
		
		@PostMapping("/qna/qnaModify")
		@ResponseBody
		public String qnaModify(@RequestParam String title, String content, Principal principal, HttpServletRequest request, int bno) {
			Date now = new Date();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("title",title);
			map.put("content",content);
			map.put("now", now);
			map.put("bno", bno);
			memberService.qnaModify(map);
			
			return "success";
		}
		
		
}
