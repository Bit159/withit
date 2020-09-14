package bj.member.bean;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("chattingRoom")
@Data
public class ChattingRoomDTO {
	private String chattingRoom;
	private String members;
	private String username;
	private String nickname;
	private String chat;
	private String chat_date;
}
