package rich.controller;

import java.security.Principal;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import hj.member.bean.MatchDTO;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import rich.dao.RichDAO;
import rich.notify.NotDTO;
import sj.board.bean.CBoardDTO;

@Controller
public class RichController {
	private static final Logger logger = LoggerFactory.getLogger(RichController.class);
	@Autowired
	private RichDAO richDAO;
	
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
	
	//일정 수정하기
	@PostMapping("/updateSchedule")
	@ResponseBody
	public int updateSchedule(@RequestBody JSONObject json) {
		NotDTO dto = new NotDTO();
		System.out.println(json);
		return 0;
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
		mav.addObject("list", list);
		mav.setViewName("rich/member/match");
		return mav; 
	}
	
	//매칭 위시 넣기
	@PostMapping(path="/insertMatch", produces="application/json;charset=UTF-8")
	@ResponseBody
	public JSONObject insertMatch(@RequestBody JSONObject json, @Autowired MatchDTO matchDTO, Principal principal) {
		System.out.println("insertMatch");
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
	@PostMapping(path="/delete_match", produces="application/json;charset=UTF-8")
	public @ResponseBody JSONObject deleteMatch(@RequestBody JSONObject json, @Autowired MatchDTO matchDTO, Principal principal) {
		matchDTO.setUsername(principal.getName());
		matchDTO.setX(json.getDouble("x"));
		matchDTO.setY(json.getDouble("y"));
		matchDTO.setRange(json.getDouble("range"));
		matchDTO.setCareer(json.getInt("career"));
		matchDTO.setPeople(json.getInt("people"));
		int result = richDAO.deleteMatch(matchDTO);
		JSONObject rjson = (result==1) ? json : null;
		return rjson;
	}
	

	
}