package rich.controller;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import bj.member.service.MemberService;
import hj.member.bean.MatchDTO;
import hj.member.bean.MatchedDTO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import rich.dao.RichDAO;
import rich.notify.NotDTO;

@Controller
public class RichController {
	private static final Logger logger = LoggerFactory.getLogger(RichController.class);
	@Autowired
	private RichDAO richDAO;
	@Autowired
	private MemberService memberService;
	
	@GetMapping("/myGroupSchedule")
	public ModelAndView myGroupSchedule(Principal principal) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("rich/member/myGroupSchedule");
		return mav;
	}
	
	@PostMapping("/myGroup{menu}")
	public ModelAndView myGroupMap(Principal principal, @PathVariable("menu") String menu, @RequestParam int gno) {
		ModelAndView mav = new ModelAndView();
		System.out.println(menu);
		System.out.println(gno);
		List<MatchedDTO> list = richDAO.getMyGroups(principal.getName());
		mav.addObject("list", list);
		mav.setViewName("rich/member/myGroup"+menu);
		System.out.println(mav.getViewName());
		return mav;
	}
	
	@PostMapping("/getMatchingResultMap")
	@ResponseBody
	public JSONArray getMatchingResultMap(Principal principal, @RequestBody String gno) {
		System.out.println(Integer.parseInt(gno));
		List<MatchDTO> list = richDAO.getMatchingResultMap(gno);
		System.out.println(list);
		System.out.println(list.get(0));
		JSONArray json = new JSONArray();
		json.addAll(list);
		return json;
	}
	
	
	@GetMapping("/myGroup")
	public ModelAndView myGroup(Principal principal) {
		ModelAndView mav = new ModelAndView();
		
		//매칭된 그룹 목록정보 - sidebar
		List<MatchedDTO> list = richDAO.getMyGroups(principal.getName());
		mav.addObject("list", list);

		//그룹별 그룹원 상세정보
		List<List<MatchedDTO>> groups = new ArrayList<>();
		for(MatchedDTO dto : list) {
			groups.add(richDAO.getGroupDetail(dto.getGno()));
		}
		mav.addObject("groups", groups);
		
		mav.addObject("nickname", memberService.getNickname(principal.getName()));
		mav.setViewName("rich/member/myGroup");
		return mav;
	}
	
	//달력에서 Ajax로 일정을 생성하는 함수입니다.
	@ResponseBody
	@PostMapping(path="/createSchedule", produces="application/json;charset=UTF-8")
	public JSONObject createSchedule(@RequestBody JSONObject json, @Autowired NotDTO dto, Principal principal) {
		dto.setUsername(principal.getName());
		dto.setGroup(json.getInt("group"));
		dto.setStart(new Date(json.getLong("start")));
		dto.setEnd(new Date(json.getLong("end")));
		dto.setPlace(json.getString("place"));
		dto.setTitle(json.getString("title"));
		dto.setContent(json.getString("content"));
		int result = richDAO.createSchedule(dto);
		if (result != 1) logger.info("일정 생성중 에러가 발생하였습니다.");
		json.put("no", richDAO.getGreatestNo());
		return json;
	}

	//달력에서 Ajax로 일정을 제거할 때 사용되는 함수입니다 
	@PostMapping("/removeSchedule")
	@ResponseBody
	public int removeSchedule(@RequestBody int no) {
		return richDAO.removeSchedule(no);
	}
	
	//일정보기 페이지
	@GetMapping("/schedules")
	public String schedules() {
		return "rich/member/schedules";
	}
	
	//일정보기 페이지 진입시 ajax로 정보 요청하기
	@PostMapping(path="/getMySchedules", produces="application/json;charset=UTF-8")
	@ResponseBody
	public JSONArray getMySchedules(Principal principal) {
		JSONArray json = new JSONArray();
		json.addAll(richDAO.getMySchedules(principal.getName()));
		return json;
	}
	
	//스터디 매치 페이지
	@GetMapping("/match") 
	public ModelAndView match(Principal principal) {
		ModelAndView mav = new ModelAndView();
		List<MatchDTO> list = richDAO.getMyListFromMatch(principal.getName());
		
		//view단(match.jsp)에서 사용할 데이터 가공
		for(MatchDTO dto: list) {
			//1. Date 형식 변경
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM.dd HH:mm:ss");
			dto.setStringCreated(sdf.format(dto.getCreated()));
			switch(dto.getCareer()) {
			case 0: dto.setStringCareer("0년~2년"); break;
			case 2: dto.setStringCareer("2년~5년"); break;
			case 5: dto.setStringCareer("5년 이상"); break;
			case 10: dto.setStringCareer("10년 이상"); break;
			default: dto.setStringCareer("가져오기 실패");break;
			}
			
			//2. 희망 인원 설정
			switch(dto.getPeople()) {
			case 3: dto.setStringPeople("3명"); break;
			case 6: dto.setStringPeople("4명~6명"); break;
			case 9: dto.setStringPeople("7명~9명"); break;
			case 10: dto.setStringPeople("10명 이상"); break;
			default: dto.setStringPeople("가져오기 실패");break;
			}
			
			//3. 지도 확대 수준 설정
			if(dto.getRange() < 1000) dto.setLevel(6);
			else if(dto.getRange() < 2500) dto.setLevel(8);
			else if(dto.getRange() < 7000) dto.setLevel(9);
			else dto.setLevel(10);
		}
		mav.addObject("list", list);
		mav.setViewName("rich/member/match");
		return mav; 
	}
	
	//매칭 위시 넣기
	@PostMapping(path="/insertMatch", produces="application/json;charset=UTF-8")
	@ResponseBody
	public JSONObject insertMatch(@RequestBody JSONObject json, @Autowired MatchDTO matchDTO, Principal principal) {
		matchDTO.setUsername(principal.getName());
		matchDTO.setMycareer(richDAO.getMycareer(principal.getName()));
		matchDTO.setX(json.getDouble("x"));
		matchDTO.setY(json.getDouble("y"));
		matchDTO.setRange(json.getDouble("range"));
		matchDTO.setTime(json.getString("time"));
		matchDTO.setTopic(json.getString("topic"));
		matchDTO.setCareer(json.getInt("career"));
		matchDTO.setPeople(json.getInt("people"));
		int result = richDAO.insertMatch(matchDTO);
		JSONObject return_json = (result == 1) ? json : null;
		return return_json;
	}
	
	
	//매칭 위시 삭제
	@PostMapping(path="/deleteMatch", produces="application/json;charset=UTF-8")
	@ResponseBody
	public String deleteMatch(@RequestBody String mno) {
		int _result = richDAO.deleteMatch(Integer.parseInt(mno));
		String result = (_result == 1) ? "success" : "fail";
		return result;
	}
	
	//에러 페이지 대응
	@GetMapping("/Error_{code}")
	public ModelAndView error(@PathVariable("code") String code) {
		String msg = "";
		switch(code) {
			case "400": msg = "잘못된 요청입니다"; break;
			case "401": msg = "허용되지 않은 접근입니다"; break;
			case "403": msg = "접근 권한이 없는 요청입니다"; break;
			case "404": msg = "존재하지 않는 페이지 입니다"; break;
			case "405": msg = "허용되지 않은 메소드입니다"; break;
			case "500": msg = "서버 내부 에러가 발생하였습니다"; break;
			case "503": msg = "서버가 일시적으로 이용불가합니다"; break;
			default : msg = "에러가 발생하였습니다"; break;
		}
		ModelAndView mav = new ModelAndView();
		mav.addObject("codeFront", code.substring(0,1));
		mav.addObject("codeEnd", code.substring(2,3));
		mav.addObject("msg", msg);
		mav.setViewName("rich/all/error");
		return mav;
	}

	
}
