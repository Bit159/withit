package sj.board.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("bBoardDTO")
@Data
public class BBoardDTO {
	private int bno;
	private String topic;
	private String title;
	private String content;
	private int replys;
	private int hit;
	private String nickname;
	private Date boarddate;
	private Date updatedate;
	
	@Override
	public String toString() {
		return bno+" "+topic+" "+title+" "+content;
	}
}
