package rich.notify;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import rich.dao.RichDAO;

//10분 간격으로 알림 발송해야할 목록을 가져와서 메일 발송하는 클래스
//비동기 처리하여 서버 내 지연을 줄여야하기 때문에 또다른 스케쥴 비동기와 다른 객체에서 선언
@Service
public class Notifier {

	@Autowired
	private RichDAO richDAO;
	@Autowired
	private Email email;
	
	//알림 메일 발송
	@Async
	@Scheduled(cron = "0 0/10 * * * *")
	public void getOnTimeList() {
		List<NotDTO> onTimeList = richDAO.getOnTimeList();
		for(NotDTO dto : onTimeList) email.send(dto.getUsername(), dto.getTitle(), dto.getContent());
	}

}
