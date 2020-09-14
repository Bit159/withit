package bj.member.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("member")
@Data
public class MemberDTO {
	private String username;
	private String nickname;
	private String password;
	private String auth;
	private String enabled;
	
	private int myCareer;
	private int github;
	private int google;
	private int kakao;
	
}
