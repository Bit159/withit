package rich.crawl;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import rich.dao.RichDAO;
import rich.dao.RichDAOImpl;
import rich.notify.Email;
import sj.board.bean.CBoardDTO;

@Service
public class Crawler {

	@Autowired
	private RichDAO userDAO;
	@Autowired
	private CBoardDTO cboardDTO;
	private static final int HOUR = 1000 * 3600;
	@Autowired
	private Email email;
	
	@Async
	@Scheduled(cron="0 0/10 * * * *") // (cron="0 0/N * * * *") N분마다
	public void getList() {
		/*
		 * Document 클래스 : 연결해서 얻어온 HTML 전체 문서 Element 클래스 : Documnet의 HTML 요소 Elements
		 * 클래스 : Element가 모인 자료형
		 */
		String url = "https://okky.kr/articles/gathering";
		String selector = "div#list-article>div.panel.panel-default>ul>li";
		Document doc = null;

		try {
			doc = Jsoup.connect(url).get(); // -- 1. get방식의 URL에 연결해서 가져온 값을 doc에 담는다.
		} catch (IOException e) {
			email.send("ztzy1907@gmail.com", "크롤링 중 에러 발생", e.getMessage());
		}

		Elements titles = doc.select(selector); // -- 2. doc에서 selector의 내용을 가져와 Elemntes 클래스에 담는다.

		List<CBoardDTO> list = new ArrayList<CBoardDTO>();
		int standard;
		try {
			standard = userDAO.getGreatestBno();
		}catch(NullPointerException e) {
			standard = 0;
		}
		for (Element element : titles) {
			cboardDTO = new CBoardDTO();

			int bno = Integer.parseInt(element.getElementsByClass("list-group-item-text article-id").text().substring(1));
			// #754380 -> substring -> 754380

			// db에 있는 글 번호중 가장 큰 값 보다 작을 경우 skip한다.
			if (bno <= standard) continue;

			String title = element.getElementsByClass("list-group-item-heading list-group-item-evaluate").text();
			// [온라인] 알고리즘 스터디 인원 추가합니다

			String nickname = element.getElementsByClass("nickname").text();
			// 오키동

			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			String _date = element.getElementsByClass("timeago").text();
			Date date = new Date();
			try {
				date = sdf.parse(_date);
				// 2020-08-05 10:12:56
			} catch (ParseException e) {
				e.printStackTrace();
			}

			cboardDTO.setBno(bno);
			cboardDTO.setTitle(title);
			cboardDTO.setNickname(nickname);
			cboardDTO.setBoarddate(date);
			list.add(cboardDTO);
		}
		
		//크롤 대상이 없을 경우 return;
		if (list.size() == 0) return;
		
		//있을 경우 db 저장
		try {
			userDAO.crawlInsert(list);
		} catch (Exception e) {
			email.send("jpcnani@naver.com", "글 목록 Insert 중 에러 발생!", "글 목록 db 입력 중 예외가 발생하였습니다!\r\n\r\n"+e.getMessage()+"\r\n\r\n"+e.getLocalizedMessage());
			return;
		}

	}

}
