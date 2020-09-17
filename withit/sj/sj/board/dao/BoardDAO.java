package sj.board.dao;

import java.util.List;
import java.util.Map;

import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.bean.CBoardDTO;
import sj.board.bean.CBoardReplyDTO;
import sj.board.paging.Pagination;
import sj.board.paging.Search;


public interface BoardDAO {

	public int getBoardTotalA();

	public List<CBoardDTO> getBoardList1();

	public List<CBoardDTO> getCBoardList();

	public CBoardDTO getCBoard(int bno);
	
	public BBoardDTO getBBoard(int bno);

	public List<CBoardReplyDTO> getCBoardReplyList(int bno);
	
	public List<BBoardReplyDTO> getBBoardReplyList(int bno);

	public void boardReply(Map<String, Object> map);
	
	public void boardReply2(Map<String, Object> map);

	public void hitUpdate(int bno);
	
	public void boardHitUpdate(int bno);

	public void replyDelete(int rno);
	
	public void replyDelete2(int rno);

	public void replyWrite(Map map);

	public void replyModify(Map<String, Object> map);
	
	public void replyModify2(Map<String, Object> map);

	public void replyUpdate(int bno);
	
	public void replyUpdate2(int bno);

	public void replyDeleteUpdate(int bno);
	
	public void replyDeleteUpdate2(int bno);

	public int getBoardListCnt();

	public List<CBoardDTO> getCBoardList(Pagination paging);
	
	public List<CBoardDTO> getCBoardList(Search search) throws Exception;

	public int getBoardListCnt(Search search) throws Exception;
	
	public int getCBoardListCnt(Search search) throws Exception;
	
	public int getBBoardListCnt(Search search) throws Exception;

	public List<BBoardDTO> getBBoardList(Map<String, String> map);

	public void writeBBoard(Map<String, Object> map);

	public List<BBoardDTO> getBBoardList(Search search);

	public void deleteBBoard(Map<String, Object> map);

	public void deleteBBoard(int bno);

	public void modifyBBoard(Map<String, Object> map);

	

	

	

	

	


	


	
	
}
