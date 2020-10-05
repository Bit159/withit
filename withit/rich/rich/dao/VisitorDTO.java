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
	private String browser;
	private String os;
	private String referer;
	private int width;
	private int height;
	private String useragent;
	
	@Override
	public String toString() {
		return username + ip + time + locale + browser + os + referer + width + height + useragent;
	}

}
