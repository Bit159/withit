package hj.member.bean;

import java.util.Date;

import org.springframework.stereotype.Service;

import lombok.Data;

@Service
@Data
//그룹의 매칭 결과를 지도로 보여주는데 사용되는 bean
public class MatchedDTO {
	private int id;
	private int gno;
	private String gname;
	private String username;
	private String nickname;
	private Double x;
	private Double y;
	private Double range;
	private Date created;
	private String time;
	private String topic;
}
