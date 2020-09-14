package bj.member.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("chatting")
@Data
public class ChattingDTO {
	private String chattingRoom;
	private String username;
	private String nickname;
	private String chat;
	private String chat_date;
}
