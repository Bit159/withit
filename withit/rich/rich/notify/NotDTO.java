package rich.notify;

import java.util.Date;
import org.springframework.stereotype.Service;
import lombok.Data;

@Service
@Data
public class NotDTO {
	private int no;
	private int gno;
	private int group;
	private String username;
	private Date start;
	private Date end;
	private String title;
	private String place;
	private String content;
	private Date created;
}
