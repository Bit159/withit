
package sj.board.bean;

import java.util.Date;

import org.apache.ibatis.type.Alias;

import lombok.Data;

@Alias("boardDTO")
@Data
public class BoardDTO {
	private int seq;
	private String name;
	private String id;
	private String title;
	private String subTitle;
	private String content;
	private int reply;
	private int hit;
	private int rating;
	private Date logtime;
}
