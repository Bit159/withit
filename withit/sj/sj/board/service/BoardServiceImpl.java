package sj.board.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.bean.BoardDTO;
import sj.board.bean.CBoardDTO;
import sj.board.bean.CBoardReplyDTO;
import sj.board.dao.BoardDAO;
import sj.board.paging.BoardPaging;
import sj.board.paging.Pagination;
import sj.board.paging.Search;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	private BoardDAO boardDAO;
	
	@Autowired 
	private HttpSession session;
	 
	@Autowired 
	private BoardPaging boardPaging;
	 
	
	@Override
	public List<BoardDTO> getBoardList(String pg) {
		//1페이지당 5개씩
		int endNum = Integer.parseInt(pg)*5;
		int startNum = endNum-4;
		
		Map<String,Integer> map = new HashMap<String,Integer>();
		map.put("startNum", startNum);
		map.put("endNum", endNum);
		
		return boardDAO.getBoardList(map);
	}

	@Override
	public List<CBoardDTO> getBoardList1() {
		return boardDAO.getBoardList1();
	}

	@Override
	public List<CBoardDTO> getCBoardList() {
		List<CBoardDTO> list = boardDAO.getCBoardList();
		
		return list;
	}

	@Override
	public CBoardDTO getCBoard(int bno) {
		return boardDAO.getCBoard(bno);
	}
	
	@Override
	public BBoardDTO getBBoard(int bno) {
		return boardDAO.getBBoard(bno);
	}

	@Override
	public List<CBoardReplyDTO> getCBoardReplyList(int bno) {
		return boardDAO.getCBoardReplyList(bno);
	}
	
	@Override
	public List<BBoardReplyDTO> getBBoardReplyList(int bno) {
		return boardDAO.getBBoardReplyList(bno);
	}

	@Override
	public void boardReply(Map<String, Object> map) {
		boardDAO.boardReply(map);
	}
	
	@Override
	public void boardReply2(Map<String, Object> map) {
		boardDAO.boardReply2(map);
	}

	@Override
	public void hitUpdate(int bno) {
		boardDAO.hitUpdate(bno);
	}
	
	@Override
	public void boardHitUpdate(int bno) {
		boardDAO.boardHitUpdate(bno);
	}

	@Override
	public void replyDelete(int rno) {
		boardDAO.replyDelete(rno);
		
	}
	
	@Override
	public void replyDelete2(int rno) {
		boardDAO.replyDelete2(rno);
	}

	@Override
	public void replyWrite(Map map) {
		boardDAO.replyWrite(map);
		
	}

	@Override
	public void replyModify(Map<String, Object> map) {
		boardDAO.replyModify(map);
	}
	
	@Override
	public void replyModify2(Map<String, Object> map) {
		boardDAO.replyModify2(map);
	}


	@Override
	public void replyUpdate(int bno) {
		boardDAO.replyUpdate(bno);
	}
	
	@Override
	public void replyUpdate2(int bno) {
		boardDAO.replyUpdate2(bno);
	}

	@Override
	public void replyDeleteUpdate(int bno) {
		boardDAO.replyDeleteUpdate(bno);
	}
	
	@Override
	public void replyDeleteUpdate2(int bno) {
		boardDAO.replyDeleteUpdate2(bno);
	}

	@Override
	public int getBoardListCnt() {
		return boardDAO.getBoardListCnt();
	}

	@Override
	public List<CBoardDTO> getCBoardList(Pagination paging) {
		List<CBoardDTO> list = boardDAO.getCBoardList(paging);
		
		return list;
	}
	
	@Override
	public List<CBoardDTO> getCBoardList(Search search) throws Exception {
		List<CBoardDTO> list = boardDAO.getCBoardList(search);
		
		return list;
	}

	@Override
	public int getBoardListCnt(Search search) throws Exception {
		return boardDAO.getBoardListCnt(search);

	}
	
	@Override
	public int getCBoardListCnt(Search search) throws Exception {
		return boardDAO.getCBoardListCnt(search);
	}
	
	@Override
	public int getBBoardListCnt(Search search) throws Exception {
		return boardDAO.getBBoardListCnt(search);
	}

	@Override
	public List<BBoardDTO> getBBoardList(Map<String, String> map) {
		return boardDAO.getBBoardList(map);
	}

	@Override
	public void writeBBoard(Map<String, Object> map) {
		boardDAO.writeBBoard(map);
	}

	@Override
	public List<BBoardDTO> getBBoardList(Search search) {
		return boardDAO.getBBoardList(search);
	}

	@Override
	public void deleteBBoard(Map<String, Object> map) {
		boardDAO.deleteBBoard(map);
	}

	@Override
	public void deleteBBoard(int bno) {
		boardDAO.deleteBBoard(bno);
	}

	
	

	

	

	


	


	

}
