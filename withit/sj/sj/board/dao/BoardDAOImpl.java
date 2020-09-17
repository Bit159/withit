package sj.board.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import lombok.Setter;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.bean.CBoardDTO;
import sj.board.bean.CBoardReplyDTO;
import sj.board.paging.Pagination;
import sj.board.paging.Search;

@Repository("boardDAO")
@Transactional
@Setter
public class BoardDAOImpl implements BoardDAO {
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public int getBoardTotalA() {
		return sqlSession.selectOne("boardSQL.getBoardTotalA");
	}

	@Override
	public List<CBoardDTO> getBoardList1() {
		return sqlSession.selectList("boardSQL.getBoardList1");
	}

	@Override
	public List<CBoardDTO> getCBoardList() {
		return sqlSession.selectList("boardSQL.getCBoardList");
	}

	@Override
	public CBoardDTO getCBoard(int bno) {
		return sqlSession.selectOne("boardSQL.getCBoard", bno);
	}
	
	@Override
	public BBoardDTO getBBoard(int bno) {
		return sqlSession.selectOne("boardSQL.getBBoard", bno);
	}

	@Override
	public List<CBoardReplyDTO> getCBoardReplyList(int bno) {
		return sqlSession.selectList("boardSQL.getCBoardReplyList", bno);
	}
	
	@Override
	public List<BBoardReplyDTO> getBBoardReplyList(int bno) {
		return sqlSession.selectList("boardSQL.getBBoardReplyList", bno);
	}

	@Override
	public void boardReply(Map<String, Object> map) {
		sqlSession.insert("boardSQL.boardReply", map);
	}
	
	@Override
	public void boardReply2(Map<String, Object> map) {
		sqlSession.insert("boardSQL.boardReply2", map);
	}

	@Override
	public void hitUpdate(int bno) {
		sqlSession.update("boardSQL.hitUpdate", bno);
	}
	
	@Override
	public void boardHitUpdate(int bno) {
		sqlSession.update("boardSQL.boardHitUpdate", bno);
	}

	@Override
	public void replyDelete(int rno) {
		sqlSession.delete("boardSQL.replyDelete", rno);
	}
	
	@Override
	public void replyDelete2(int rno) {
		sqlSession.delete("boardSQL.replyDelete2", rno);
	}

	@Override
	public void replyWrite(Map map) {
		sqlSession.insert("boardSQL.replyWrite", map);
	}

	@Override
	public void replyModify(Map<String, Object> map) {
		sqlSession.update("boardSQL.replyModify", map);
	}
	
	@Override
	public void replyModify2(Map<String, Object> map) {
		sqlSession.update("boardSQL.replyModify2", map);
	}

	@Override
	public void replyUpdate(int bno) {
		sqlSession.update("boardSQL.replyUpdate", bno);
	}
	
	@Override
	public void replyUpdate2(int bno) {
		sqlSession.update("boardSQL.replyUpdate2", bno);
	}

	@Override
	public void replyDeleteUpdate(int bno) {
		sqlSession.update("boardSQL.replyDeleteUpdate",bno);
	}
	
	@Override
	public void replyDeleteUpdate2(int bno) {
		sqlSession.update("boardSQL.replyDeleteUpdate2",bno);
	}

	@Override
	public int getBoardListCnt() {
		return sqlSession.selectOne("boardSQL.getBoardListCnt");
	}

	@Override
	public List<CBoardDTO> getCBoardList(Pagination paging) {
		return sqlSession.selectList("boardSQL.getCBoardList1", paging);
	}
	
	@Override
	public List<CBoardDTO> getCBoardList(Search search) throws Exception {
		return sqlSession.selectList("boardSQL.getCBoardList1", search);
	}

	@Override
	public int getBoardListCnt(Search search) throws Exception {
		return sqlSession.selectOne("boardSQL.getBoardListCnt1",search);
	}
	
	@Override
	public int getCBoardListCnt(Search search) throws Exception {
		return sqlSession.selectOne("boardSQL.getCBoardListCnt",search);
	}

	@Override
	public int getBBoardListCnt(Search search) throws Exception {
		return sqlSession.selectOne("boardSQL.getBBoardListCnt",search);
	}
	
	@Override
	public List<BBoardDTO> getBBoardList(Map<String, String> map) {
		return sqlSession.selectList("boardSQL.getBBoardList", map);
	}

	@Override
	public void writeBBoard(Map<String, Object> map) {
		sqlSession.insert("boardSQL.writeBBoard", map);
	}

	@Override
	public List<BBoardDTO> getBBoardList(Search search) {
		return sqlSession.selectList("boardSQL.getBBoardList", search);
	}

	@Override
	public void deleteBBoard(Map<String, Object> map) {
		sqlSession.delete("boardSQL.deleteBBoard", map);
	}

	@Override
	public void deleteBBoard(int bno) {
		sqlSession.delete("boardSQL.deleteBBoard", bno);
	}

	@Override
	public void modifyBBoard(Map<String, Object> map) {
		sqlSession.update("boardSQL.modifyBBoard", map);
	}

	

	

	

	

	

	

	



}
