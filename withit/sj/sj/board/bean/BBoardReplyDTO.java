package sj.board.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("bBoardReplyDTO")
@Data
public class BBoardReplyDTO {
	private int rno;
	private int bno;
	private String reply;
	private String nickname;
	private Date replydate;
	private Date updatedate;
	
	@Override
	public String toString() {
		return rno+" "+bno+" "+reply+" "+nickname;
	}
}
