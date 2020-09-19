package hj.member.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import bj.member.bean.MemberDTO;
import hj.member.bean.MatchDTO;
import hj.member.bean.ProgrammingDTO;
import hj.member.bean.Search;
import hj.member.bean.TotalDTO;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;

@Repository
@Transactional
public class HjDAOMybatis implements HjDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public void join(Map<String, String> map) {
		sqlSession.insert("hjSQL.join", map);
	}

	@Override
	public void withdrawal(String username) {
		sqlSession.delete("hjSQL.withdrawal", username);
	}

	@Override
	public MemberDTO getMyPage(Map<String, String> map) {
		return sqlSession.selectOne("hjSQL.getMyPage", map);
	}

	@Override
	public void revise(Map<String, String> map) {

		sqlSession.update("hjSQL.revise", map);

	}

	@Override
	public void nicknameRevise(Map<String, String> map) {

		sqlSession.update("hjSQL.nicknameRevise", map);

	}

	@Override
	public List<MemberDTO> getMember() {

		return sqlSession.selectList("hjSQL.getMember");
	}

	@Override
	public void memberDelete(String username) {

		sqlSession.delete("hjSQL.memberDelete", username);

	}

	@Override
	public List<MemberDTO> getBoardList() {

		return sqlSession.selectList("hjSQL.getBoardList");
	}

	@Override
	public List<TotalDTO> getTotalStats() {
		return sqlSession.selectList("hjSQL.getTotalStats");
	}

	@Override
	public List<ProgrammingDTO> getProgrammingStats() {
		return sqlSession.selectList("hjSQL.getProgrammingStats");
	}

	@Override
	public List<MatchDTO> getListFromMatch() {
		return sqlSession.selectList("hjSQL.getListFromMatch");
	}

	@Override
	public int getBoardListCnt(Search search) {
		return sqlSession.selectOne("hjSQL.getBoardListCnt", search);
	}

	@Override
	public List<MemberDTO> getMemberList(Search search) {
		return sqlSession.selectList("hjSQL.getMemberList", search);
	}

	@Override
	public List<MemberDTO> getWithdrawalList(String username) {
		return sqlSession.selectList("hjSQL.getWithdrawalList", username);
	}

	@Override
	public List<MemberDTO> getNickName(String nickname) {
		return sqlSession.selectList("hjSQL.getNickName", nickname);
	}

	@Override
	public void passwordRevise(Map<String, String> map) {
		sqlSession.update("hjSQL.passwordRevise", map);
	}

	@Override
	public MemberDTO login(String id, String pwd) {
		return null;
	}

	@Override
	public int checkUsername(String username) {
		
		return sqlSession.selectOne("hjSQL.checkUsername", username);
	}

	@Override
	public int checkNickname(String nickname) {
	
		return sqlSession.selectOne("hjSQL.checkNickname", nickname);
	}

	@Override
	public int totalprogramming() {
		
		return sqlSession.selectOne("hjSQL.totalprogramming");
	}

	@Override
	public List<BBoardDTO> getBBoardList(Search search) {
		
		return sqlSession.selectList("hjSQL.getBBoardList", search);
	}

	@Override
	public int getBBoardListCnt(Search search) {
		
		return sqlSession.selectOne("hjSQL.getBBoardListCnt",search);
	}

	@Override
	public BBoardDTO getBBoard(int bno) {
		
		return sqlSession.selectOne("hjSQL.getBBoard", bno);
	}

	@Override
	public List<BBoardReplyDTO> getBBoardReplyList(int bno) {
		
		return sqlSession.selectList("hjSQL.getBBoardReplyList", bno);
	}

	@Override
	public void deleteBBoard(int bno) {
		sqlSession.delete("hjSQL.deleteBBoard", bno);
		
	}

	@Override
	public void replyDelete2(int rno) {
		sqlSession.delete("hjSQL.replyDelete2", rno);
		
	}

	@Override
	public void replyDeleteUpdate2(int bno) {
		sqlSession.update("hjSQL.replyDeleteUpdate2",bno);
		
	}

}
