package rich.dao;

import java.util.Date;

import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class VisitorDTO {
	
	private int no;
	private String username;
	private String ip;
	private Date time;
	private String locale;
	private Date dbtime;

}