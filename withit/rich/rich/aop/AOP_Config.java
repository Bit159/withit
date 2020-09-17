package rich.aop;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.Aspect;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import hj.member.bean.MatchDTO;
import hj.member.dao.HjDAO;
import rich.dao.RichDAO;
import rich.notify.Email;
import sj.board.bean.CBoardDTO;

@Service
@Aspect
public class AOP_Config {

	@Autowired
	private HjDAO hjDAO;
	@Autowired
	private RichDAO richDAO;
	@Autowired
	private Email email;

	//글 내용 삽입하기
	@Async
	@After("execution(public * rich.crawl.Crawler.getList(..))")
	public void getContent() {
		System.out.println("10분마다 작동하는 글 내용 삽입을 위한 애프터");
		List<String> list = richDAO.getEmptyContentBno();
		if (list.size() == 0)
			return;

		List<CBoardDTO> insertList = new ArrayList<CBoardDTO>();

		for (int i = 0; i < list.size(); i++) {
			String url = "https://okky.kr/article/" + list.get(i);
			String selector = "article.content-text";

			Document doc = null;
			try {
				doc = Jsoup.connect(url).get();
			} catch (IOException e) {
				System.out.println(e.getMessage());
			}

			CBoardDTO cboardDTO = new CBoardDTO();
			cboardDTO.setBno(Integer.parseInt(list.get(i)));

			// .text() 에서 .outerHtml로 변경하여 태그를 유지한다.
			cboardDTO.setContent(doc.select(selector).outerHtml());
			insertList.add(cboardDTO);
		}

		int result = 0;
		try {
			result = richDAO.insertContents(insertList);
		} catch (Exception e) {
			email.send("jpcnani@naver.com", "글 내용 INSERT 입력중 에러 발생!", "글 내용을 등록중 에러가 발생하였습니다." + e.getMessage());
			e.printStackTrace();
			return;
		}
		if (result != 0) {
			//email.send("jpcnani@naver.com", result + "개 글 내용 INSERT 성공!", result + "개의 글 내용을 정상적으로 등록하였습니다.");
		}
	}

	//매칭 검증
	@Async
	@AfterReturning("execution(public * com.bit159.withit.HomeController.home(..))")
	public void after() {
		System.out.println("---------------------------------------------------------");
		System.out.println("match db 삽입 후 매칭 검증을 위한 after Returning");
		List<MatchDTO> listFromMatch = hjDAO.getListFromMatch();
		List<MatchDTO> rangeValidatedList = rangeValidation(listFromMatch);
		System.out.println();
		System.out.println("최종결과");
		System.out.println(rangeValidatedList);
		
		//매칭된 리스트가 존재할 경우
		if(rangeValidatedList != null) {
			//메일 발송을 위해 매칭된 요소들의 username을 리스트에 담음
			List<String> emailList = new ArrayList<>();
			for(MatchDTO dto: rangeValidatedList) {
				emailList.add(dto.getUsername());
			}
			
			//1. 메일발송
			email.send(emailList);
			//2. db.match 에서 제거
			richDAO.deleteMatched(rangeValidatedList);
			//3. 동적 테이블 생성
			
		}
		
	}// after method
	
	private static double distance(double lat1, double lon1, double lat2, double lon2) {
        double theta = lon1 - lon2;
        double dist = Math.sin(deg2rad(lat1)) * Math.sin(deg2rad(lat2)) + Math.cos(deg2rad(lat1)) * Math.cos(deg2rad(lat2)) * Math.cos(deg2rad(theta));
        dist = Math.acos(dist);
        dist = rad2deg(dist);
        dist = dist * 60 * 1.1515 * 1.609344;
        return dist;
    }
 
    private static double deg2rad(double deg) {
        return (deg * Math.PI / 180.0);
    }
    private static double rad2deg(double rad) {
        return (rad * 180 / Math.PI);
    }
	
	
	
	public List<MatchDTO> rangeValidation(List<MatchDTO> listFromMatch) { // match 테이블 전체 리스트를 파라메타로 받는다.
		for(MatchDTO dto : listFromMatch) System.out.print(dto.toString()+" ");
		System.out.println();
		List<MatchDTO> result = null;
		
		for (int i = 0; i < listFromMatch.size(); i++) { 
			//이전 검증에서 visited를 건드렸을 거기 전수 visited false 준다.
			for(MatchDTO dto : listFromMatch) dto.setVisited(false);
			List<MatchDTO> candidateList = new ArrayList<>();
			candidateList.add(listFromMatch.get(i)); //기준이 될 녀석이 후보리스트의 첫번째 요소가 된다.
			
			List<MatchDTO> sourceList = new ArrayList<>();
			for(MatchDTO dto : listFromMatch) sourceList.add(dto);
			sourceList.remove(i); //기준이 되는 녀석은 검증할 리스트에서 제거한다.
			
			//매칭 성공값을 받을 리스트 생성
			List<MatchDTO> rangeValidatedList = new ArrayList<>();
			
			rangeValidation(sourceList, candidateList, rangeValidatedList, 0);
			if(rangeValidatedList.isEmpty()) {
				System.out.println(i + "번째 기준 " + listFromMatch.get(i).toString() + "매칭 실패");
			}else {
				result = rangeValidatedList;
				break;
			}
		}
		return result;
	}// 메소드 끝
	
	public void rangeValidation(List<MatchDTO> sourceList, List<MatchDTO> candidateList, List<MatchDTO> rangeValidatedList, int flag) {
		//무한루프 방지를 위한 flag처리.
		if(flag >= sourceList.size()) return;

		//기준 자신을 제거한 전체리스트가 소스리스트가 된다. 
		for (int i = 0; i < sourceList.size(); i++) {
			//후보리스트에서 제거된 적이 있는 요소는 건너뛴다.
			if(sourceList.get(i).isVisited()) continue;
			
			boolean rangeMatchWithAllCandidates = true;
			//소스리스트를 순회하며 후보리스트에 있는 모든 요소와 접면이 있는 요소를 후보리스트에 추가한다.
			for (int j = 0; j < candidateList.size(); j++) {
 				double sumOfTwoRanges = (candidateList.get(j).getRange() + sourceList.get(i).getRange()) / 1000.0;
				double distance = distance
						(candidateList.get(j).getY(), candidateList.get(j).getX(),
								sourceList.get(i).getY(), sourceList.get(i).getX());
				if (sumOfTwoRanges < distance)	{
					rangeMatchWithAllCandidates = false;
				}
				
				//위에는 접면 검증. 접면이 존재하지 않으면 false를 줘서 후보리스트에 추가되지 않게 조치한다.
				//아래는 인원 검증. 
				//기준의 인원이 0이면 무관이니까 건드릴 필요 없고
				//기준의 인원이 0이 아닐 경우에만 후보리스트 추가하기 전에 인원검증을 추가한다
				
				//기준의 인원이 무관이 아닌데 기준과 희망인원이 다르면 false를 주어 추가되지 않게 한다  
				if(!(candidateList.get(0).getPeople() == sourceList.get(i).getPeople()))
					rangeMatchWithAllCandidates = false;
			}
			//모든 요소와 접면 존재할 경우 추가검증
			if(rangeMatchWithAllCandidates)	{
				//하나라도 조건을 만족하지 않으면 추가하지 않기 위한 변수선언.
				boolean isNotSatisfied = false;
				
				//이미 존재하는 값은 아닌지
				for(MatchDTO dto : candidateList) {
					if(dto.toString().equals(sourceList.get(i).toString()))
						isNotSatisfied = true;
				}
				//같은 유저가 생성한 게 아닌지
				for(MatchDTO dto : candidateList) {
					if(dto.getUsername().equals(sourceList.get(i).getUsername()))
						isNotSatisfied = true;
				}
				
				//상호 경력조건을 만족하는지
				if(candidateList.get(0).getPeople() != sourceList.get(i).getPeople()) isNotSatisfied = true;
				for(MatchDTO dto : candidateList) {
					if(dto.getMycareer() < sourceList.get(i).getCareer()) {
						isNotSatisfied = true;
					}
					if(dto.getCareer() > sourceList.get(i).getMycareer()) {
						isNotSatisfied = true;
					}
				} 
				
				//if(candidateList.get(0).getCareer() > sourceList.get(i).getMycareer()) isNotSatisfied = true;
				//if(sourceList.get(i).getCareer() > candidateList.get(0).getMycareer()) isNotSatisfied = true;

				//주제가 일치하는지
				if(!candidateList.get(0).getTopic().equals(sourceList.get(i).getTopic())) isNotSatisfied = true;
				//시간대가 일치하는지
				if(!candidateList.get(0).getTime().equals(sourceList.get(i).getTime())) isNotSatisfied = true;
				
				
				//모늗 후보리스트 요소와 접면이 존재하고, + 후보리스트에 이미 존재하지 않을 경우 후보리스트에 추가한다.
				//기준의 인원수 제한을 넘기지 않았는지 검증을 추가해야 한다.
				if(!isNotSatisfied) candidateList.add(sourceList.get(i));
			}else {
			}
		}
		
		//후보리스트의 규모가 기준의 희망규모보다 작을 때는 분기점으로 회귀해야한다.
		if(candidateList.get(0).getPeople() > candidateList.size()) {
			//기준 자체를 제거하면 안되니까 마지막 요소가 기준이 아니라는 조건을 추가한다
			if(candidateList.size() != 1) {
				candidateList.get(candidateList.size()-1).setVisited(true);
				candidateList.remove(candidateList.size()-1);
				rangeValidation(sourceList, candidateList, rangeValidatedList, flag+1);
			}
		//후보리스트의 규모가 희망규모보다 크거나 같을 경우 rangeValidatedList에 후보리스트값을 주고 메소드를 종료한다.
		}else {
			for(MatchDTO dto : candidateList) rangeValidatedList.add(dto);
		}
	}
	
}
