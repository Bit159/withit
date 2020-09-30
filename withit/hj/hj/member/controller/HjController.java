package hj.member.controller;

import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bj.member.bean.MemberDTO;
import bj.member.service.MemberService;
import hj.member.bean.MatchDTO;
import hj.member.bean.ProgrammingDTO;
import hj.member.bean.Search;
import hj.member.bean.TotalDTO;
import hj.member.service.HjService;
import net.sf.json.JSONArray;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.paging.Pagination;

@Controller
public class HjController {
	@Autowired
	private MemberService memberService;
	@Autowired
	private BCryptPasswordEncoder encoder;
	@Autowired
	private HjService hjService;
	
	
	//관리자 : 회원목록
	@GetMapping("/admin")
	public String adminBoard(
								Model model, 
								@RequestParam(required = false, defaultValue = "1") int page,
								@RequestParam(required = false, defaultValue = "1") int range,
								@RequestParam(required = false, defaultValue = "username") String searchType,
								@RequestParam(required = false) String keyword, @ModelAttribute("search") Search search
								) {

		model.addAttribute("search", search);
		search.setSearchType(searchType);
		search.setKeyword(keyword);

		// 전체 게시글의 수
		int listCnt = hjService.getBoardListCnt(search);

		// Pagination 객체생성
		search.pageInfo(page, range, listCnt);

		List<MemberDTO> list = hjService.getMemberList(search);

		model.addAttribute("list", list);
		model.addAttribute("pagination", search);

		return "/hj/all/admin";
	}
	
	
	
	
	
	
	//myPage 페이지
	@GetMapping("/myPage")
	public ModelAndView myPage(Principal principal, @Autowired MemberDTO memberDTO) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("username", principal.getName());
		memberDTO = hjService.getMyPage(map);
		ModelAndView mav = new ModelAndView();
		mav.addObject("memberDTO", memberDTO);
		mav.setViewName("/hj/member/myPage");
		return mav;
	}



	
	//myPage 회원탈퇴
	
	@ResponseBody
	@RequestMapping(value = "/member/withdrawal", method = RequestMethod.POST)
	public String withdrawal(@RequestParam String username, String password, @Autowired MemberDTO memberDTO, HttpSession session) {
		List<MemberDTO> list = hjService.getWithdrawalList(username);
		System.out.println(list.get(0).getPassword());// db에서 받아온 비밀번호
		System.out.println(username);
		System.out.println(password);// 입력한 비밀번호
		String passwordEqual = null;
		// encoder.matches(password, memberDTO.getPassword());

		if (true == encoder.matches(password, list.get(0).getPassword())) {
			System.out.println("비번 맞춤");
			hjService.withdrawal(username);
			passwordEqual = "equal";
			session.invalidate();
		} else {
			System.out.println("비번 틀림");
			passwordEqual = "unEqual";
		}
		return passwordEqual;
	}
	
	
	//myPage 회원정보 수정
	
	@ResponseBody
	@RequestMapping(value = "/member/revise", method = RequestMethod.POST)
	public String revise(@RequestParam String username, String password, String nickname, String myCareer, String newNickname, HttpServletRequest request) {
		String revice = null;
		System.out.println(newNickname);
		HttpSession session = request.getSession();
		
		if (password == null || password == "") {
			Map<String, String> map = new HashMap<String, String>();
			map.put("username", username);
			map.put("nickname", nickname);
			map.put("myCareer", myCareer);
			
			List<MemberDTO> list = hjService.getNickName(nickname);
			
			String dbNickName = "";

			for (int i = 0; i < list.size(); i++) {
				dbNickName = list.get(i).getNickname();
			}
			
			if(newNickname.equals("1")) { // ===================================== 커리어, 닉네임 수정
				if (dbNickName == null || dbNickName == "") {
					System.out.println("닉네임 수정 가능");
					hjService.nicknameRevice(map);
					
					session.setAttribute("nickname", nickname);
					
					revice = "success";
	
				} else {
					System.out.println("닉네임 수정 불가능");
					revice = "fail";
	
				}
				
			}else { // ===================================== 커리어만 수정	
				hjService.careerRevise(map);
				revice = "success";
			}

		} else {

			Map<String, String> map = new HashMap<String, String>();
			map.put("username", username);
			map.put("password", password);
			map.put("nickname", nickname);
			map.put("myCareer", myCareer);
			
			if(newNickname.equals("0")) { // ===================================== 커리어, 비밀번호 수정!
				hjService.careerPasswordRevise(map);
				revice = "success";
				
			}else {
				List<MemberDTO> list = hjService.getNickName(nickname);
	
				String dbNickName = "";
	
				for (int i = 0; i < list.size(); i++) {
					dbNickName = list.get(i).getNickname();
				}
	
				/*if (dbNickName.equals(nickname)) {
	
					hjService.passwordRevise(map);
					System.out.println("비밀번호 바꿀때 닉네임이 같음");
	
					revice = "onlyPassword";
	
				} else {
	
					System.out.println("비밀번호 바꿀때 닉네임이 다름");
					hjService.revise(map);
	
					revice = "dualSuccess";
				}*/
				if (dbNickName == null || dbNickName == "") { // ===================================== 전체 수정!
					System.out.println("닉네임 수정 가능");
					hjService.revise(map);
					session.setAttribute("nickname", nickname);
					revice = "success";
	
				} else {
					System.out.println("닉네임 수정 불가능");
					revice = "fail";
	
				}
			}

		}

		return revice;

	}
	
	
	
	

	//관리자 페이지 회원 통계
	
	@GetMapping("/adminMemberStats")
	public String adminStats() {

		return "/hj/all/adminStats";

	}
	
	
	
	
	
	//관리자 페이지 회원통계 chart 데이터 불러오기
	@ResponseBody
	@RequestMapping(value = "/all/getAdminStats", method = RequestMethod.POST)
	public JSONArray getAdminStats() {

		List<TotalDTO> list = hjService.getTotalStats();
		
		int totalprogramming = hjService.totalprogramming();
		
		     
		
		JSONArray json = new JSONArray();
		json.addAll(list);
		

		return json;

	}
	
		//관리자 페이지 프로그래밍 게시판 chart 데이터 불러오기
		@ResponseBody
		@RequestMapping(value = "/all/totalprogramming", method = RequestMethod.POST)
		public JSONArray totalprogramming() {
	
			int totalprogramming = hjService.totalprogramming();
			
			System.out.println(totalprogramming);
			
			JSONArray json = new JSONArray();
			
			json.add(totalprogramming);
			
			return json;


		}
	
	//관리자 페이지 프로그래밍 언어 페이지
	
	@GetMapping("/adminProgrammingStats")
	public String programmingStats() {
		
		
		
		return "/hj/all/programmingStats";

	}
	
	//관리자 페이지 프로그래밍 언어 chart 데이터
	@ResponseBody
	@RequestMapping(value = "/all/getProgrammingStats", method = RequestMethod.POST)
	public JSONArray getProgrammingStats() {

		List<ProgrammingDTO> list = hjService.getProgrammingStats();

		JSONArray json = new JSONArray();
		json.addAll(list);

		return json;

	}
	
	//관리자 페이지 adminMap 페이지
	@GetMapping("/adminLocationMap")
	public String admin_map() {

		return "/hj/all/admin_map";

	}
	
	//관리자 페이지 map 불러오기
	@ResponseBody
	@RequestMapping(value = "/all/admin_map_getList", method = RequestMethod.POST)
	public JSONArray admin_map_getList() {

		List<MatchDTO> list = hjService.getListFromMatch();

		JSONArray json = new JSONArray();
		json.addAll(list);

		return json;

	}
	
	// 관리자 페이지 회원 회원탈퇴
	@ResponseBody
	@RequestMapping(value = "/all/memberDelete", method = RequestMethod.POST)
	public void memberDelete(@RequestParam String username) {

		System.out.println(username);

		hjService.memberDelete(username);

		
	}
	
	//회원가입 페이지
	@GetMapping("/joinForm")
	public String joinForm() {
		return "/hj/all/joinForm";
		
	}
	
	//회원가입
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public String join(@RequestParam Map<String, String> map) {
		hjService.join(map);
		return "redirect:/loginForm";
	}
	
		//회원가입 페이지 아이디 중복 체크
		@ResponseBody
		@RequestMapping(value = "/all/checkUsername", method = RequestMethod.POST)
		public String checkUsername(@RequestParam String username) {

			int cnt = 0;
			
			cnt = hjService.checkUsername(username);
		
			String overlap = "";
			
			if(cnt!=0) {
				overlap = "fail";
			}else {
				overlap = "success";
			}
			
			return overlap;

		}
		
		
		
		//회원가입 페이지 닉네임 중복 체크
		@ResponseBody
		@RequestMapping(value = "/all/checkNickname", method = RequestMethod.POST)
		public String checkNickname(@RequestParam String nickname) {

			
			
			int cnt2 = 0;
			
			cnt2 = hjService.checkNickname(nickname);
			
			
			
			String overlap = "";
			
			if(cnt2!=0) {
				overlap = "fail";
			}else {
				overlap = "success";
			}
			
			return overlap;

		}
	
		
		//관리자 페이지 자유게시판 관리
		
		@GetMapping("/adminFreeView")
		public ModelAndView adminFreeView(@RequestParam(required=false, defaultValue = "1") int pg
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
			//System.out.println("페이지"+page+"범위"+range);
			
			// 검색, 페이징 적용된 전체 게시글 수
			int listCnt = hjService.getBBoardListCnt(search); 
			
			// 검색
			search.pageInfo(page, range, listCnt);
			
			// 페이지네이션
			Pagination paging = new Pagination();
			paging.pageInfo(page, range, listCnt); 
			//System.out.println("paging: "+paging);
			
			// 검색, 페이징 적용된 보드리스트
			List<BBoardDTO> list = hjService.getBBoardList(search); 
			
			// 작성시간 표시 위한 현재 Date 객체
			Date now = new Date();
			
			ModelAndView mav = new ModelAndView();
			// 검색
			mav.addObject("search",search);
			// 페이징(검색 적용)
			mav.addObject("paging",search);
			mav.addObject("list", list);
			mav.addObject("now", now);
			mav.setViewName("/hj/all/adminFreeView");
			return mav;

		
		}
		
		//관리자 페이지 자유게시판 관리
		@GetMapping("/adminFreeView/{bno}")
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
			//System.out.println("페이지"+page+"범위"+range);
			
			// 검색, 페이징 적용된 전체 게시글 수
			int listCnt = hjService.getBBoardListCnt(search); 
			
			// 검색
			search.pageInfo(page, range, listCnt);
			
			// 페이지네이션
			Pagination paging = new Pagination();
			paging.pageInfo(page, range, listCnt); 
			//System.out.println("paging: "+paging);	
			
			// 원글 불러오기
			BBoardDTO bBoardDTO = hjService.getBBoard(bno);
			
			// 보드뷰 하단부 검색, 페이징 적용된 보드리스트
			List<BBoardDTO> list = hjService.getBBoardList(search);
			//System.out.println(bBoardDTO.getTitle());
			
			// 보드뷰 해당 리플 리스트
			List<BBoardReplyDTO> replyList = hjService.getBBoardReplyList(bno);
			//System.out.println(replyList);
			
			
			
			// 작성시간 표시 위한 현재 Date 객체
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
			
			mav.setViewName("/hj/all/adminFreeViewForm");
			return mav;
		}
		
		
		// 자유게시판 작성 폼	
		@GetMapping("/adminFreeViewWrite")
		public ModelAndView adminFreeViewWrite() {
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/hj/all/adminFreeViewWrite");
			return mav;
		}
		
		
		// 자유게시판 글 작성
		@ResponseBody
		@RequestMapping(value = "/all/adminBoardWrite", method = RequestMethod.POST)
		public String adminBoardWrite(@RequestParam String title, String content, Principal principal, HttpServletRequest request) {
			Date now = new Date();
			
			String username = principal.getName();
			System.out.println("username="+username);
			String nickname = memberService.getNickname(username);
			System.out.println("nickname="+nickname);
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("title",title);
			map.put("content",content);
			map.put("username", username);
			
			map.put("nickname", nickname);
			map.put("now", now);
			hjService.writeBBoard(map); 
			return "success";
		}
		
		// 자유게시판 보드 삭제
		@ResponseBody
		@RequestMapping(value = "/all/boardDelete", method = RequestMethod.POST)
		public ModelAndView boardDelete(@RequestParam int bno) {
		
			hjService.deleteBBoard(bno);
			
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/hj/all/adminFreeView");
			return mav;
			
			

		}
		
		
		//자유게시판 댓글 삭제
		@ResponseBody
		@RequestMapping(value = "/all/replyDelete", method = RequestMethod.POST)
		public ModelAndView replyDelete2(@RequestParam int rno, int bno, HttpSession session) {
			System.out.println("rno="+rno);
			
			hjService.replyDelete2(rno);
			System.out.println("bno="+bno);
			hjService.replyDeleteUpdate2(bno);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/hj/all/adminFreeView");
			mav.addObject(bno);
			return mav;
		}
		
		
		
		//자유게시판 댓글 생성
		@ResponseBody
		@RequestMapping(value = "/all/boardReply", method = RequestMethod.POST)
		public ModelAndView bboardReply(@RequestParam String reply, int bno, Principal principal) {
			System.out.println("reply:"+reply+" bno:"+bno);
			String username = principal.getName();
			//System.out.println("username="+username);
			String nickname = memberService.getNickname(username);
			//System.out.println("nickname="+nickname);
			List<BBoardReplyDTO> replyList = hjService.getBBoardReplyList(bno);
			//System.out.println("replyList:"+replyList);
			Date now = new Date();
			
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("bno",bno);
			map.put("reply", reply);
			map.put("username", username);
			map.put("nickname", nickname);
			map.put("now", now);
			hjService.boardReply2(map);
			hjService.replyUpdate2(bno);
			ModelAndView mav = new ModelAndView();
			mav.addObject("replyList", replyList);
			mav.setViewName("jsonView");
			return mav;
		}
		
		// 자유게시판 수정 폼	
		@GetMapping("/adminFreeViewModify")
		public ModelAndView adminFreeViewModify(@RequestParam int bno) {
			// 원글 불러오기
			BBoardDTO bBoardDTO = hjService.getBBoard(bno);
			ModelAndView mav = new ModelAndView();
			mav.addObject("bBoardDTO", bBoardDTO);
			mav.setViewName("/hj/all/adminFreeViewModify");
			return mav;
		}
		
		// 자유게시판 보드 수정
		@PostMapping("/all/boardModify")
		@ResponseBody
		public String boardModify(@RequestParam String title, String content, Principal principal, HttpServletRequest request, int bno) {
			Date now = new Date();
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("title",title);
			map.put("content",content);
			map.put("now", now);
			map.put("bno", bno);
			hjService.modifyBBoard(map);
			return "success";
		}
		
		// 자유게시판 댓글 수정
		@PostMapping("/all/replyModify")
		public ModelAndView replyModify2(@RequestParam String reply, int rno, HttpSession session) {
			System.out.println(reply);
			System.out.println(rno);
			/* String nickname = (String) session.getAttribute("nickname"); */
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("rno",rno);
			map.put("reply", reply);
			hjService.replyModify2(map);
			ModelAndView mav = new ModelAndView();
			mav.setViewName("/hj/all/adminFreeView");
			return mav;
		}
		
		

}

