package bj.member.dao;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.collections4.map.HashedMap;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import bj.member.bean.ChattingDTO;
import bj.member.bean.ChattingRoomDTO;
import bj.member.bean.MemberDTO;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.paging.Search;

@Transactional
@Repository
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	private SqlSession sqlSession;
	//private int chatNum = 1;
	
	//======================================================= 로그인
	
	@Override
	public MemberDTO login(Map<String, String> map) {
		return sqlSession.selectOne("memberSQL.login", map);
	}

	//======================================================= 회원가입
	
	@Override
	public void join(Map<String, String> map) {
		sqlSession.insert("memberSQL.join", map);
	}

	@Override
	public MemberDTO checkMember(String username) {
		return sqlSession.selectOne("memberSQL.checkMember", username);
	}

	@Override
	public void addInfo(MemberDTO memberDTO) {
		sqlSession.insert("memberSQL.addInfo", memberDTO);
	}

	//======================================================= 마이페이지
	
	@Override
	public MemberDTO getMyPage(Map<String, String> map) {
		return sqlSession.selectOne("memberSQL.getMyPage", map);
	}
	
	@Override
	public void withdrawal(String username) {
		sqlSession.delete("memberSQL.withrawal");
		
	}
	
	@Override
	public void nicknameRevise(Map<String, String> map) {
		sqlSession.update("memberSQL.nicknameRevise", map);
		
	}

	@Override
	public void revise(Map<String, String> map) {
		sqlSession.update("memberSQL.revise", map);
		
	}
	
	//======================================================= 관리자 페이지
	
	@Override
	public List<MemberDTO> getMember() {
		return sqlSession.selectList("memberSQL.getMember");
		
	}
	
	@Override
	public void memberDelete(String username) {
		sqlSession.delete("memberSQL.memberDelete", username);
		
	}
	
	//======================================================= 자동완성
	
	@Override
	public List<String> autocomplete() {
		return sqlSession.selectList("memberSQL.autocomplete");
		
	}
	
	//======================================================= 채팅방
	
	@Override
	public void sendMessage(Map<String, String> map) {
		sqlSession.insert("memberSQL.sendMessage", map);
		
	}
	
	@Override
	public void sendMessage(ChattingDTO chattingDTO) {
		sqlSession.insert("memberSQL.sendMessage", chattingDTO);
		
	}

	@Override
	public List<ChattingDTO> getChatting(String chattingRoom) {
		return sqlSession.selectList("memberSQL.getChatting", chattingRoom);
		
	}

	@Override
	public void createChat() {
		String uuid = UUID.randomUUID().toString();
		String chattingRoomName = "db.chattingRoom" + uuid;
		
		String checkRoomName = sqlSession.selectOne("memberSQL.checkRoomName", chattingRoomName);
		
		if(checkRoomName == null) {
			createChat();
			return;
		}
		
		Map<String, String> map = new HashedMap<String, String>();
		String create_table = "create table db." + chattingRoomName
							+ "(username varchar(100),"
							+ "nickname varchar(100),"
							+ "chat varchar(500),"
							+ "chat_date varchar(100)";
		
		map.put("create_table", create_table);
		System.out.println(create_table);
		sqlSession.selectOne("memberSQL.createChat", map);
		//chatNum++;
		//UUID(Universally Unique Identifier)는 소프트웨어 구축에 쓰이는 식별자 표준. 국제기구에서 표준으로 사용. 고유성을 완벽하게 보장할 수는 없지만 중복될 가능성이 거의 없다고 인정되기 때문에 많이 사용한다.
	}

	@Override
	public List<ChattingRoomDTO> getChattingRoom(String username) {
		return sqlSession.selectList("memberSQL.getChattingRoom", username);
		
	}

	@Override
	public String getNickname(String username) {
		return sqlSession.selectOne("memberSQL.getNickname",username);
	}

	@Override
	public ChattingDTO getLastChatting(String chattingRoom) {
		return sqlSession.selectOne("memberSQL.getLastChatting", "db."+chattingRoom);
	}

	@Override
	public ChattingRoomDTO getAllChatting() {
		return sqlSession.selectOne("memberSQL.getAllChatting");
	}

	@Override
	public void newPwd(Map<String, String> map) {
		sqlSession.update("memberSQL.newPwd", map);
	}

	// =============================================================== 공지사항 관련
	
	@Override
	public int getNoticeListCnt(Search search) {
		return sqlSession.selectOne("memberSQL.getNoticeListCnt", search);
	}

	@Override
	public List<BBoardDTO> getNoticeList(Search search) {
		return sqlSession.selectList("memberSQL.getNoticeList", search);
	}

	@Override
	public BBoardDTO getNotice(int bno) {
		return sqlSession.selectOne("memberSQL.getNotice", bno);
	}

	@Override
	public void noticeHitUpdate(int bno) {
		sqlSession.update("memberSQL.noticeHitUpdate", bno);
	}

	@Override
	public List<BBoardReplyDTO> getNoticeReplyList(int bno) {
		return sqlSession.selectList("memberSQL.getNoticeReplyList", bno);
	}

	@Override
	public void noticeReply(Map<String, Object> map) {
		sqlSession.update("memberSQL.noticeReply", map);
	}

	@Override
	public void noticeReplyDelete(Map<String, Integer> map) {
		sqlSession.delete("memberSQL.noticeReplyDelete", map);
	}

	@Override
	public void noticeReplyModify(Map<String, Object> map) {
		sqlSession.update("memberSQL.noticeReplyModify", map);
	}

	@Override
	public void noticeDelete(int bno) {
		sqlSession.delete("memberSQL.noticeDelete", bno);
	}

	@Override
	public void noticeWrite(Map<String, Object> map) {
		sqlSession.insert("memberSQL.noticeWrite", map);
	}

	@Override
	public void noticeModify(Map<String, Object> map) {
		sqlSession.update("memberSQL.noticeModify", map);
	}

}
