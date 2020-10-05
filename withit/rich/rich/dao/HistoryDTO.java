package rich.dao;

import java.util.Date;

import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class HistoryDTO {
	
	private int no;
	private Date time;
	private String title;
	private String content;
	private Date create;
	private Date updated;
	private String username;
	private String stringTime;
	
}
