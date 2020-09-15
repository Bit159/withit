package kh.member.controller;

import java.security.Principal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bj.member.service.MemberService;
import kh.cardBoard.bean.CardBoardDTO;
import kh.cardBoard.bean.CardBoardPaging;
import kh.cardBoard.bean.CardBoardReplyDTO;
import kh.cardBoard.service.CardBoardService;
import kh.member.service.KhService;
import net.sf.json.JSONArray;

@Controller
public class KhController {
	@Autowired(required=false)
	private KhService khService;
	@Autowired 
	private CardBoardService cardBoardService;
	@Autowired
	private MemberService memberService;
	
	
	 //게시판 카드리스트 뿌리기
	 @GetMapping("/cardBoard")
	 public ModelAndView cardBoardList(
			 @RequestParam(required=false, defaultValue = "1") int pg
			,@RequestParam(required=false, defaultValue = "1") int range
	 		,@RequestParam(required=false) String[] location,
	 		 @RequestParam(required=false) String topic){
		 
		 CardBoardPaging paging = new CardBoardPaging();
		 int page =  pg; 
		 int listCnt = 0; //전체갯수
		 Map<String,Object> map = new HashMap<String,Object>();
		 ModelAndView mav = new ModelAndView();
		 if(location==null && topic==null) {
			 //전체리스트
			 listCnt = cardBoardService.getBoardListCnt();
			 paging.pageInfo(page, range, listCnt,"", "");
			 List<CardBoardDTO> listAll = cardBoardService.getCardBoardList(paging);
			 mav.addObject("list",listAll);
			 mav.addObject("paging",paging);
			 
		 }else if(location!=null && topic!=null){
			 for (int i = 0; i < location.length; i++) {
				 map.put("locations["+i+"]", location[i]);
			 }
			 String loc = Arrays.toString(location).replace("[", "").replace("]", "").replace(", ", ",");
			 map.put("topic",topic);
			 paging.pageInfo(page, range, 0, "" , "");
			 map.put("listSize", paging.getListSize());
			 map.put("startList", paging.getStartList());
			 
			 List<Object> list2 = new ArrayList<Object>(map.values());
			 listCnt = cardBoardService.getSearchBoardListCnt(list2);
			 paging.pageInfo(page, range, listCnt, loc, topic);
			 List<CardBoardDTO> list = cardBoardService.searchCard(list2);
			 mav.addObject("list",list);
			 mav.addObject("paging",paging);
			 
		 }else if(location==null && topic!=null) {
			 listCnt = cardBoardService.getNolocBoardListCnt(topic);
			 String loc = Arrays.toString(location).replace("[", "").replace("]", "").replace(", ", ",");
			 paging.pageInfo(page, range, listCnt, loc, topic);
			 List<CardBoardDTO> listNoloc = cardBoardService.searchCardNoloc(topic, paging);
			 mav.addObject("list",listNoloc);
			 mav.addObject("paging",paging);
		 }
		 mav.setViewName("/kh/member/cardBoard");
		 return mav;
	 }
	
//	 =============카드게시판 관련================
	 @GetMapping("/cardBoard/createGroup")
	 public String createGroup() {
		 return "/kh/member/createGroup";
	 }
	 
	 //모집글 등록
	 @PostMapping("/cardBoard/createGroup/regist")
	 public String regist(@ModelAttribute CardBoardDTO cardBoardDTO, Principal principal) {
		 System.out.println(cardBoardDTO.getTitle());
		 String username = principal.getName();
		 String nickname = memberService.getNickname(username);
		 cardBoardDTO.setNickname(nickname);
		 cardBoardService.regist(cardBoardDTO);
		 return "redirect:/cardBoard";
	 }
	 
	 //지역 자동완성
	 @GetMapping("/cardBoard/autocomplete")
	 @ResponseBody
	 public ModelAndView autocomplete() {
		 ModelAndView mav = new ModelAndView();
		 List<String> list = khService.autocomplete();
		 String[] arr = new String[list.size()];
		 int size=0;
		 for (String tem : list) {
			 arr[size++]=tem;
		 }
		 mav.addObject("arr",arr);
		 mav.setViewName("jsonView");
		 return mav;
	 }

	 //지역 선택창
	 @GetMapping(path="/cardBoard/getLocation",produces="application/json;charset=UTF-8")
	 @ResponseBody
	 public JSONArray getLocation() {
		 List<List<String>> list = new ArrayList<List<String>>();
		 List<String> _list = new ArrayList<String>();
		 _list.add("서울");
		 _list.add("경기");
		 _list.add("인천");
		 _list.add("부산");
		 _list.add("대구");
		 _list.add("광주");
		 _list.add("대전");
		 _list.add("울산");
		 _list.add("세종");
		 _list.add("강원");
		 _list.add("경남");
		 _list.add("경북");
		 _list.add("전남");
		 _list.add("전북");
		 _list.add("충남");
		 _list.add("충북");
		 _list.add("제주");
		 for(int i = 0; i < _list.size(); i++) {
		  list.add(cardBoardService.getLocationList(_list.get(i)));
		 }
		 JSONArray json = new JSONArray();
		 json.addAll(list);
		 return json;
	 }

	 //모집글 보기
	 @GetMapping("/cardBoardView")
	 public ModelAndView cardBoardView(@RequestParam int seq,Principal principal) {
		 CardBoardDTO dto = cardBoardService.getCardContent(seq);
		 List<CardBoardReplyDTO> replyList= cardBoardService.getReplyList(seq);
		 String username = principal.getName();
		 String memberId = memberService.getNickname(dto.getNickname());
		 ModelAndView mav = new ModelAndView();
		 boolean isAuthor = false;
		 if(username.equals(memberId)) {
			 isAuthor = true;
		 }
		 mav.addObject("dto",dto);
		 mav.addObject("replyList",replyList);
		 mav.addObject("isAuthor",isAuthor);
		 mav.setViewName("/kh/member/cardBoardView");
		 return mav;
	 }
	 //댓글등록
	 @GetMapping(value="/writeReply")
	 public String writeReply(@RequestParam String reply,@RequestParam int seq,Principal principal) {
		 String username = principal.getName();
		 String nickname = memberService.getNickname(username);
		 CardBoardReplyDTO dto = new CardBoardReplyDTO();
		 dto.setSeq(seq);
		 dto.setReply(reply);
		 dto.setNickname(nickname);
		 CardBoardDTO cardDTO = new CardBoardDTO();
		 cardDTO.setSeq(seq);
		 cardBoardService.writeReply(dto);
		 cardBoardService.replyCntup(cardDTO);
		 return "/kh/member/cardBoardView";
	 }
	 //댓글 삭제
	 @GetMapping(value="/deleteReply")
	 public String deleteReply(@RequestParam int rseq, @RequestParam int seq){
		 cardBoardService.deleteReply(rseq);
		 CardBoardDTO cardDTO = new CardBoardDTO();
		 cardDTO.setSeq(seq);
		 cardBoardService.replyCntdown(cardDTO);
		 return "/kh/member/cardBoardView";
	 }
	 //댓글 수정
	 @GetMapping(value="/modifyReply")
	 public String modifyReply(@RequestParam int rseq,@RequestParam String reply){
		 CardBoardReplyDTO dto = new CardBoardReplyDTO();
		 dto.setRseq(rseq);
		 dto.setReply(reply);
		 cardBoardService.modifyReply(dto);
		 return "/kh/member/cardBoardView";
	 }
	 //모집 글 수정페이지 이동
	 @GetMapping(value="/modifyCard")
	 public ModelAndView modifyCard(@RequestParam int seq) {
		 CardBoardDTO dto = cardBoardService.getCardContent(seq);
		 ModelAndView mav = new ModelAndView();
		 mav.addObject("dto",dto);
		 mav.setViewName("/kh/member/modifyGroup");
		 return mav;
	 }
	 //모집 글 수정
	 @PostMapping(value="/modifyGroup")
	 public String modifyGroup(@ModelAttribute CardBoardDTO cardBoardDTO, @RequestParam int seq) {
		 cardBoardDTO.setSeq(seq);
		 cardBoardService.modifyGroup(cardBoardDTO);
		 return "redirect:/cardBoardView?seq="+seq;
	 }
     //모집 글 마감
	 @GetMapping(value="/closeCard")
	 public String closeCard(@RequestParam int seq){
		 cardBoardService.closeCard(seq);
		 return "redirect:/member/cardBoardList";
	 }
}
