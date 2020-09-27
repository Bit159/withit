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
	
	//=========================================== 濡쒓렇�씤
	
	@GetMapping("/loginForm")
	public String loginForm() {
		return "/kh/all/loginForm";
	}
	
	// =========================================== �냼�뀥 濡쒓렇�씤 愿��젴
	
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
	
	//============================================================== 鍮꾨�踰덊샇 李얘린
	
	@PostMapping("/findPwd")
	@ResponseBody
	public String findPwd(@RequestParam String username) {
		String reUsername = username.substring(1, username.length() -1); //json�� �븵�뮘濡� "媛� 遺숈뼱�꽌 �삤誘�濡� 鍮쇱��떦.
		MemberDTO memberDTO = memberService.checkMember(reUsername);
		
		String result = "";
		if(memberDTO == null) result = "none";
		else result = reUsername;
		
		return result;
	}
	
	//============================================================== 梨꾪똿諛�
	
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
	
	//=========================================================== 怨듭��궗�빆
	
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
		
		// �럹�씠吏�
		int page =  pg;
		System.out.println("�럹�씠吏�"+page+"踰붿쐞"+range);
		
		// 寃��깋, �럹�씠吏� �쟻�슜�맂 �쟾泥� 寃뚯떆湲� �닔
		int listCntN = memberService.getNoticeListCnt(search);
		
		// 寃��깋
		search.pageInfo(page, range, listCntN);
		
		// �럹�씠吏��꽕�씠�뀡
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCntN); 
		System.out.println("paging: "+paging);
		
		// 寃��깋, �럹�씠吏� �쟻�슜�맂 蹂대뱶由ъ뒪�듃
		//List<BBoardDTO> list = boardService.getBBoardList(search); 
		List<BBoardDTO> list = memberService.getNoticeList(search);
		
		// �옉�꽦�떆媛� �몴�떆 �쐞�븳 �쁽�옱 Date 媛앹껜
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		// 寃��깋
		mav.addObject("search",search);
		// �럹�씠吏�(寃��깋 �쟻�슜)
		mav.addObject("paging",search);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.setViewName("/bj/all/notice");
		return mav;

	}
	
	//====================================================== 怨듭��궗�빆 蹂대뱶酉�
	
	@GetMapping("/notice/{bno}")
	public ModelAndView freeBoardView(@PathVariable("bno") int bno
								  	  ,@RequestParam(required=false, defaultValue = "1") int pg
								  	  ,@RequestParam(required=false, defaultValue = "1") int range
								  	  ,@RequestParam(required = false, defaultValue = "title") String searchType
								  	  ,@RequestParam(required = false) String keyword
								  	  ,HttpServletRequest request
								  	  ,Principal principal) throws Exception {
		
		// 寃��깋
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		// �럹�씠吏�
		int page =  pg;
		System.out.println("�럹�씠吏�"+page+"踰붿쐞"+range);
		
		// 寃��깋, �럹�씠吏� �쟻�슜�맂 �쟾泥� 寃뚯떆湲� �닔
		int listCnt = memberService.getNoticeListCnt(search); 
		
		// 寃��깋
		search.pageInfo(page, range, listCnt);
		
		// �럹�씠吏��꽕�씠�뀡
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 
		System.out.println("paging: "+paging);	
		
		// �썝湲� 遺덈윭�삤湲�
		BBoardDTO bBoardDTO = memberService.getNotice(bno);
		
		// 蹂대뱶酉� �븯�떒遺� 寃��깋, �럹�씠吏� �쟻�슜�맂 蹂대뱶由ъ뒪�듃
		List<BBoardDTO> list = memberService.getNoticeList(search);
		System.out.println(bBoardDTO.getTitle());
		
		// 蹂대뱶酉� �빐�떦 由ы뵆 由ъ뒪�듃
		List<BBoardReplyDTO> replyList = memberService.getNoticeReplyList(bno);
		
		// 議고쉶�닔 1利앷�
		memberService.noticeHipUpdate(bno);
		
		// �옉�꽦�떆媛� �몴�떆 �쐞�븳 �쁽�옱 Date 媛앹껜
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("paging",search);
		mav.addObject("bBoardDTO", bBoardDTO);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("replyList", replyList);
		
		//bj.member.controller.LoginSuccessHandler �뿉�꽌 濡쒓렇�씤 �꽦怨� �떆 session�뿉 nickname �떞�븘�몺.
		//�꽭�뀡�뿉 �떞湲� nickname怨� �꽑�깮�븳 湲��쓽 nickname媛믪쓣 寃�利앺븯�뿬 mav 媛앹껜�뿉 boolean 寃곌낵媛믪쓣 �떞�븘�꽌 view濡� 蹂대깂
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
	
	//================================================== 怨듭��궗�빆 �뙎湲� 異붽�
	
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
	
	//======================================================= 怨듭��궗�빆 �뙎湲� �궘�젣
	
	@PostMapping("/notice/replyDelete")
	@ResponseBody
	public void replyDelete(@RequestParam int rno, int bno) {
		Map<String, Integer> map = new HashMap<String, Integer>();
		map.put("rno", rno);
		map.put("bno", bno);
		memberService.noticeReplyDelete(map);
	}
	
	//======================================================= 怨듭��궗�빆 �뙎湲� �닔�젙
	
	@PostMapping("/notice/replyModify")
	@ResponseBody
	public void noticeReply(@RequestParam String reply, int rno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rno",rno);
		map.put("reply", reply);
		
		memberService.noticeReplyModify(map);
	}
	
	//======================================================= 怨듭��궗�빆 �궘�젣
	
	@PostMapping("/notice/noticeDelete")
	@ResponseBody
	public void noticeDelete(@RequestParam int bno) {
		System.out.println(bno);
		memberService.noticeDelete(bno);
	}
	
	//======================================================= 怨듭��궗�빆 �옉�꽦
	
	
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
		
		/* Search search = new Search(); */
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		// �럹�씠吏�
		int page =  pg;
		System.out.println("�럹�씠吏�"+page+"踰붿쐞"+range);
		
		// 寃��깋, �럹�씠吏� �쟻�슜�맂 �쟾泥� 寃뚯떆湲� �닔
		int listCnt = memberService.getQnaListCnt(search);
		
		// 寃��깋
		search.pageInfo(page, range, listCnt);
		
		// �럹�씠吏��꽕�씠�뀡
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 
		System.out.println("paging: "+paging);
		
		// 寃��깋, �럹�씠吏� �쟻�슜�맂 蹂대뱶由ъ뒪�듃
		//List<BBoardDTO> list = boardService.getBBoardList(search); 
		List<BBoardDTO> list = memberService.getQnaList(search);
		
		// �옉�꽦�떆媛� �몴�떆 �쐞�븳 �쁽�옱 Date 媛앹껜
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		// 寃��깋
		mav.addObject("search",search);
		// �럹�씠吏�(寃��깋 �쟻�슜)
		mav.addObject("paging",search);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.setViewName("/bj/all/qna");
		
		return mav;
	}
	
	//================================================== QnA 酉�
	 
	@GetMapping("/qna/{bno}")
	public ModelAndView qnaView(@PathVariable("bno") int bno
						  	  ,@RequestParam(required=false, defaultValue = "1") int pg
						  	  ,@RequestParam(required=false, defaultValue = "1") int range
						  	  ,@RequestParam(required = false, defaultValue = "title") String searchType
						  	  ,@RequestParam(required = false) String keyword
						  	  ,HttpServletRequest request
						  	  ,Principal principal) throws Exception {
		
		// 寃��깋
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		// �럹�씠吏�
		int page =  pg;
		
		// 寃��깋, �럹�씠吏� �쟻�슜�맂 �쟾泥� 寃뚯떆湲� �닔
		int listCnt = memberService.getQnaListCnt(search); 
		
		// 寃��깋
		search.pageInfo(page, range, listCnt);
		
		// �럹�씠吏��꽕�씠�뀡
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 
		
		// �썝湲� 遺덈윭�삤湲�
		BBoardDTO bBoardDTO = memberService.getQna(bno);
		
		// 蹂대뱶酉� �븯�떒遺� 寃��깋, �럹�씠吏� �쟻�슜�맂 蹂대뱶由ъ뒪�듃
		List<BBoardDTO> list = memberService.getQnaList(search);
		
		// 蹂대뱶酉� �빐�떦 由ы뵆 由ъ뒪�듃
		List<BBoardReplyDTO> replyList = memberService.getQnaReplyList(bno);
		
		// 議고쉶�닔 1利앷�
		memberService.qnaHipUpdate(bno);
		
		// �옉�꽦�떆媛� �몴�떆 �쐞�븳 �쁽�옱 Date 媛앹껜
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("paging",search);
		mav.addObject("bBoardDTO", bBoardDTO);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("replyList", replyList);
		
		//bj.member.controller.LoginSuccessHandler �뿉�꽌 濡쒓렇�씤 �꽦怨� �떆 session�뿉 nickname �떞�븘�몺.
		//�꽭�뀡�뿉 �떞湲� nickname怨� �꽑�깮�븳 湲��쓽 nickname媛믪쓣 寃�利앺븯�뿬 mav 媛앹껜�뿉 boolean 寃곌낵媛믪쓣 �떞�븘�꽌 view濡� 蹂대깂
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
		mav.addObject("isAuthor", isAuthor);
		mav.setViewName("/bj/all/qnaView");
		return mav;
	}
	
	//================================================== QnA �뙎湲� 異붽�
	
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
		
		//======================================================= QnA �뙎湲� �궘�젣
		
		@PostMapping("/qna/replyDelete")
		@ResponseBody
		public void qnaDelete(@RequestParam int rno, int bno) {
			Map<String, Integer> map = new HashMap<String, Integer>();
			map.put("rno", rno);
			map.put("bno", bno);
			memberService.qnaReplyDelete(map);
		}
		
		//======================================================= QnA �뙎湲� �닔�젙
		
		@PostMapping("/qna/replyModify")
		@ResponseBody
		public void qnaReply(@RequestParam String reply, int rno) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("rno",rno);
			map.put("reply", reply);
			
			memberService.qnaReplyModify(map);
		}
		
		//======================================================= QnA �궘�젣
		
		@PostMapping("/qna/qnaDelete")
		@ResponseBody
		public void qnaDelete(@RequestParam int bno) {
			System.out.println(bno);
			memberService.qnaDelete(bno);
		}
		
		//======================================================= QnA 湲��벐湲�, �닔�젙 �뤌
		
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
		
		//======================================================= QnA 湲��벐湲�, �닔�젙 �뤌
		
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
