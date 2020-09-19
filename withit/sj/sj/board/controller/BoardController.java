package sj.board.controller;

import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bj.member.service.MemberService;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.bean.CBoardDTO;
import sj.board.bean.CBoardReplyDTO;
import sj.board.dao.BoardDAO;
import sj.board.paging.Pagination;
import sj.board.paging.Search;
import sj.board.service.BoardService;

@Controller
public class BoardController {
	@Autowired
	private BoardService boardService;
	@Autowired
	private BoardDAO boardDAO;
	@Autowired
	private MemberService memberService;
	
	// 크롤링 보드 리스트
	@GetMapping("/crawlBoard")
	public ModelAndView crawlBoard(@RequestParam(required=false, defaultValue = "1") int pg
							   	 ,@RequestParam(required=false, defaultValue = "1") int range
							   	 , @RequestParam(required = false, defaultValue = "title") String searchType
								 , @RequestParam(required = false) String keyword
								 , @ModelAttribute("search") Search search) throws Exception  {
		
		// 검색
		/* Search search = new Search(); */
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		// 페이지
		int page =  pg;
		System.out.println("페이지"+page+"범위"+range);
		
		// 검색, 페이징 적용된 전체 게시글 수
		int listCnt = boardService.getCBoardListCnt(search); 
		
		// 검색
		search.pageInfo(page, range, listCnt);
		
		// 페이지네이션
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 
		System.out.println("paging: "+paging);
		
		System.out.println(search.getKeyword());
		System.out.println(search.getSearchType());
		
		// 검색, 페이징 적용된 보드리스트
		List<CBoardDTO> list = boardService.getCBoardList(search);
		
		// 작성시간 표시 위한 현재 Date 객체
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		// 검색
		mav.addObject("search",search);
		// 페이징(검색 적용)
		mav.addObject("paging",search);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.setViewName("/sj/crawlBoard");
		return mav;
	}
	
	//자유게시판 리스트
	@GetMapping("/freeBoard")
	public ModelAndView freeBoard(@RequestParam(required=false, defaultValue = "1") int pg
							   	 ,@RequestParam(required=false, defaultValue = "1") int range
							   	 , @RequestParam(required = false, defaultValue = "title") String searchType
								 , @RequestParam(required = false) String keyword
								 , @ModelAttribute("search") Search search) throws Exception  {
		
		// 검색
		/* Search search = new Search(); */
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
		
		// 검색, 페이징 적용된 보드리스트
		List<BBoardDTO> list = boardService.getBBoardList(search); 
		
		// 작성시간 표시 위한 현재 Date 객체
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		// 검색
		mav.addObject("search",search);
		// 페이징(검색 적용)
		mav.addObject("paging",search);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.setViewName("/sj/freeBoard");
		return mav;
	}
	
	//크롤링 보드뷰
	@GetMapping("/crawlBoard/{bno}")
	public ModelAndView crawlBoardView(@PathVariable("bno") int bno,
								  @RequestParam(required=false, defaultValue = "1") int pg
								 ,@RequestParam(required=false, defaultValue = "1") int range
								 , @RequestParam(required = false, defaultValue = "title") String searchType
								 , @RequestParam(required = false) String keyword
								 , Principal principal) throws Exception {
		
		// 검색
		Search search = new Search();
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		// 페이지
		int page =  pg;
		System.out.println("페이지"+page+"범위"+range);
		
		// 검색, 페이징 적용된 전체 게시글 수
		int listCnt = boardService.getCBoardListCnt(search); 
		
		// 검색
		search.pageInfo(page, range, listCnt);
		
		// 페이지네이션
		Pagination paging = new Pagination();
		paging.pageInfo(page, range, listCnt); 
		System.out.println("paging: "+paging);	
		
		// 원글 불러오기
		CBoardDTO cBoardDTO = boardService.getCBoard(bno);
		
		// 보드뷰 하단부 검색, 페이징 적용된 보드리스트
		List<CBoardDTO> list = boardService.getCBoardList(search);
		System.out.println(cBoardDTO.getTitle());
		
		// 보드뷰 해당 리플 리스트
		List<CBoardReplyDTO> replyList = boardService.getCBoardReplyList(bno);
		System.out.println(replyList);
		
		// 조회수 1증가
		boardService.hitUpdate(bno);
		
		// 작성시간 표시 위한 현재 Date 객체
		Date now = new Date();
		
		ModelAndView mav = new ModelAndView();
		mav.addObject("paging",search);
		mav.addObject("cBoardDTO", cBoardDTO);
		mav.addObject("list", list);
		mav.addObject("now", now);
		mav.addObject("replyList", replyList);
		mav.setViewName("/sj/crawlView");
		return mav;
	}
	
	//자유게시판 보드뷰
	@GetMapping("/freeBoard/{bno}")
	public ModelAndView freeBoardView(@PathVariable("bno") int bno,
								  @RequestParam(required=false, defaultValue = "1") int pg
								 ,@RequestParam(required=false, defaultValue = "1") int range
								 , @RequestParam(required = false, defaultValue = "title") String searchType
								 , @RequestParam(required = false) String keyword
								 , HttpServletRequest request
								 , Principal principal) throws Exception {
		
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
		BBoardDTO bBoardDTO = boardService.getBBoard(bno);
		
		// 보드뷰 하단부 검색, 페이징 적용된 보드리스트
		List<BBoardDTO> list = boardService.getBBoardList(search);
		System.out.println(bBoardDTO.getTitle());
		
		// 보드뷰 해당 리플 리스트
		List<BBoardReplyDTO> replyList = boardService.getBBoardReplyList(bno);
		System.out.println(replyList);
		
		// 조회수 1증가
		boardService.boardHitUpdate(bno);
		
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
		mav.setViewName("/sj/freeView");
		return mav;
	}
	
	
	// 자유게시판 작성 폼	
	@GetMapping("/freeBoard/writeForm")
	public ModelAndView boardWriteForm() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/sj/boardWriteForm");
		return mav;
	}
	
	// 자유게시판 수정 폼	
	@GetMapping("/freeBoard/boardModifyForm")
	public ModelAndView bboardWriteForm(@RequestParam int bno) {
		// 원글 불러오기
		BBoardDTO bBoardDTO = boardService.getBBoard(bno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("bBoardDTO", bBoardDTO);
		mav.setViewName("/sj/boardModifyForm");
		return mav;
	}
	
	
	
	
	//크롤링 보드 댓글 생성
	@PostMapping(path="/crawlBoard/boardReply")
	public ModelAndView boardReply(@RequestParam String reply, int bno, Principal principal) {
		
		System.out.println("reply:"+reply+" bno:"+bno);
		String username = principal.getName();
		System.out.println("username="+username);
		String nickname = memberService.getNickname(username);
		System.out.println("nickname="+nickname);
		List<CBoardReplyDTO> replyList = boardService.getCBoardReplyList(bno);
		System.out.println("replyList:"+replyList);
		Date now = new Date();
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("bno",bno);
		map.put("reply", reply);
		map.put("username", username);
		map.put("nickname", nickname);
		map.put("now", now);
		boardService.boardReply(map);
		boardService.replyUpdate(bno);
		ModelAndView mav = new ModelAndView();
		mav.addObject("replyList", replyList);
		mav.setViewName("jsonView");
		return mav;
	}
	
	//자유게시판 댓글 생성
		@PostMapping(path="/freeBoard/boardReply")
		public ModelAndView bboardReply(@RequestParam String reply, int bno, Principal principal) {
			System.out.println("reply:"+reply+" bno:"+bno);
			String username = principal.getName();
			System.out.println("username="+username);
			String nickname = memberService.getNickname(username);
			System.out.println("nickname="+nickname);
			List<BBoardReplyDTO> replyList = boardService.getBBoardReplyList(bno);
			System.out.println("replyList:"+replyList);
			Date now = new Date();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bno",bno);
			map.put("reply", reply);
			map.put("username", username);
			map.put("nickname", nickname);
			map.put("now", now);
			boardService.boardReply2(map);
			boardService.replyUpdate2(bno);
			ModelAndView mav = new ModelAndView();
			mav.addObject("replyList", replyList);
			mav.setViewName("jsonView");
			return mav;
		}
	
	//크롤링 보드 댓글 삭제
	@PostMapping("/crawlBoard/replyDelete")
	public ModelAndView replyDelete(@RequestParam int rno, int bno, HttpSession session) {
		System.out.println("rno="+rno);
		/* String nickname = (String) session.getAttribute("nickname"); */
		boardService.replyDelete(rno);
		System.out.println("bno="+bno);
		boardService.replyDeleteUpdate(bno);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("sj/crawlView");
		return mav;
	}
	
	//자유게시판 댓글 삭제
	@PostMapping("/freeBoard/replyDelete")
	public ModelAndView replyDelete2(@RequestParam int rno, int bno, HttpSession session) {
		System.out.println("rno="+rno);
		/* String nickname = (String) session.getAttribute("nickname"); */
		boardService.replyDelete2(rno);
		System.out.println("bno="+bno);
		boardService.replyDeleteUpdate2(bno);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("sj/freeBoard");
		return mav;
	}
	
	// 크롤링 보드 댓글 수정
	@PostMapping("/crawlBoard/replyModify")
	public ModelAndView replyModify(@RequestParam String reply, int rno, HttpSession session) {
		System.out.println(reply);
		System.out.println(rno);
		/* String nickname = (String) session.getAttribute("nickname"); */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rno",rno);
		map.put("reply", reply);
		boardService.replyModify(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/sj/crawlView");
		return mav;
	}
	
	// 자유게시판 댓글 수정
	@PostMapping("/freeBoard/replyModify")
	public ModelAndView replyModify2(@RequestParam String reply, int rno, HttpSession session) {
		System.out.println(reply);
		System.out.println(rno);
		/* String nickname = (String) session.getAttribute("nickname"); */
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rno",rno);
		map.put("reply", reply);
		boardService.replyModify2(map);
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/sj/freeView");
		return mav;
	}
	
	
	// 자유게시판 보드 작성
	@PostMapping("/freeBoard/boardWrite")
	@ResponseBody
	public String boardWrite(@RequestParam String title, String content, Principal principal, HttpServletRequest request) {
		Date now = new Date();
		
		String username = principal.getName();
		System.out.println("username="+username);
		String nickname = memberService.getNickname(username);
		System.out.println("nickname="+nickname);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("title",title);
		map.put("content",content);
		map.put("username", username);
		/* map.put("nickname",request.getSession().getAttribute("nickname")); */
		map.put("nickname", nickname);
		map.put("now", now);
		boardService.writeBBoard(map); 
		return "success";
	}
	
	// 자유게시판 보드 삭제
	@PostMapping("/freeBoard/boardDelete")
	public ModelAndView boardDelete(@RequestParam int bno) {
		
		
		boardService.deleteBBoard(bno);
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/sj/freeBoard");
		return mav;
	}
	
	// 자유게시판 보드 수정
	@PostMapping("/freeBoard/boardModify")
	@ResponseBody
	public String boardModify(@RequestParam String title, String content, Principal principal, HttpServletRequest request, int bno) {
		Date now = new Date();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("title",title);
		map.put("content",content);
		map.put("now", now);
		map.put("bno", bno);
		boardService.modifyBBoard(map);
		return "success";
	}
	
	
	
}