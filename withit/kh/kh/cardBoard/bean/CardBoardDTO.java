package kh.cardBoard.bean;


import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("card")
@Data
public class CardBoardDTO {
	private int seq;
	private String title;
	private String nickname;
	private String topic;
	private String location;
	private int people;
	private String content;
	private int open;
	private int replys;
	private Date registDate;
}
