package sj.board.bean;

import java.util.Date;

import lombok.Data;

@Data
public class CBoardReplyDTO {
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