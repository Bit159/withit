package kh.cardBoard.bean;

import java.util.Date;

import lombok.Data;

@Data
public class CardBoardReplyDTO {
	private int rseq;
	private int seq;
	private String reply;
	private String nickname;
	private Date regDate;
	private Date editDate;
}
