package rich.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import hj.member.bean.MatchDTO;
import hj.member.bean.MatchedDTO;
import lombok.Setter;
import rich.notify.NotDTO;
import sj.board.bean.CBoardDTO;

@Repository
@Transactional
@Setter
public class RichDAOImpl implements RichDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// 방문자 기록
	@Override
	public int logVisitor(VisitorDTO visitorDTO) {
		return sqlSession.insert("richSQL.logVisitor", visitorDTO);
	}
	
	
	// FOR MAP
	//나의 경력 불러오기
	@Override
	public int getMycareer(String username) {
		return sqlSession.selectOne("richSQL.getMycareer", username);
	}
	
	//매칭 위시 생성
	@Override
	public int insertMatch(MatchDTO matchDTO) {
		return sqlSession.insert("richSQL.insertMatch", matchDTO);
	}

	//개인의 매칭 위시 불러오기
	@Override
	public List<MatchDTO> getMyListFromMatch(String username) {
		return sqlSession.selectList("richSQL.getMyListFromMatch", username);
	}

	//매칭된 그룹을 match 테이블에서 제거하는 함수
	@Override
	public int deleteMatched(List<MatchDTO> list) {
		return sqlSession.delete("richSQL.deleteMatched", list);
	}

	//개인의 매칭 위시 제거
	@Override
	public int deleteMatch(int mno) {
		return sqlSession.delete("richSQL.deleteMatch", mno);
	}
	// End of FOR MAP
	
	
	
	
	// FOR CRAWL
	//크롤링 글 삽입
	@Override
	public int crawlInsert(List<CBoardDTO> list) {
		return sqlSession.insert("richSQL.crawlInsert", list);
	}

	//크롤링 글내용 없는 행 불러오기
	@Override
	public List<String> getEmptyContentBno() {
		return sqlSession.selectList("richSQL.getEmptyContentBno");
	}

	//글내용 넣기
	@Override
	public int insertContents(List<CBoardDTO> list) {
		return sqlSession.insert("richSQL.insertContents", list);
	}

	//가장 큰 게시글번호 가져오기
	@Override
	public int getGreatestBno() {
		return sqlSession.selectOne("richSQL.getGreatestBno");
	}

	// End of FOR CRAWL

	
	
	
	
	// FOR Notification function
	//일정 시간이 된 row들 불러오기
	@Override
	public List<NotDTO> getOnTimeList() {
		return sqlSession.selectList("richSQL.getOnTimeList");
	}
	//db시간 가져오기
	@Override
	public Date getDBTime() {
		return sqlSession.selectOne("richSQL.getDBTime");
	}

	// End of Notification Methods
	
	
	
	
	
	
	// FOR DISPLAYING SCHEDULES
	//일정 생성하기
	@Override
	public int createSchedule(NotDTO dto) {
		return sqlSession.insert("richSQL.createSchedule", dto);
	}
	
	//일정 불러오기
	@Override
	public List<NotDTO> getMySchedules(String username) {
		return sqlSession.selectList("richSQL.getMySchedules", username);
	}
	
	//일정 수정 - 미구현
	@Override
	public int updateSchedule(NotDTO dto) {
		return sqlSession.delete("richSQL.updateSchedule", dto);
	}
	
	//일정 삭제
	@Override
	public int removeSchedule(int no) {
		return sqlSession.delete("richSQL.removeSchedule", no);
	}

	@Override
	public int getGreatestNo() {
		return sqlSession.selectOne("richSQL.getGreatestNo");
	}

	//그룹 생성하기
	@Override
	public int createGroup(List<MatchDTO> rangeValidatedList) {
		return sqlSession.insert("richSQL.createGroup", rangeValidatedList);
	}
	
	@Override
	public int getGreatestGno() {
		return sqlSession.selectOne("richSQL.getGreatestGno");
	}

	//1. 채팅방 인덱스를 1 더한다
	@Override
	public int addChattingRoomIndex() {
		return sqlSession.update("richSQL.addChattingRoomIndex");
	}
	//2. 채팅방 인덱스를 가져와서 테이블 쿼리생성문에 삽입한다.
	@Override
	public int getChattingRoomIndex() {
		return sqlSession.selectOne("richSQL.getChattingRoomIndex");
	}
	//3. 완성된 쿼리문으로 채팅방 테이블을 생성한다.
	@Override
	public int createChattingRoom(String tableName) {
		sqlSession.selectOne("richSQL.createChattingRoom", tableName);
		return 0;
	}
	//4. 생성한 채팅방 테이블에 첫 채팅을 삽입한다.
	@Override
	public int setChattingRoomMembers(List<MatchDTO> rangeValidatedList) {
		return sqlSession.insert("richSQL.setChattingRoomMembers", rangeValidatedList);
	}

	//5. 채팅방 목록 테이블에 새로 생성된 채팅방 테이블을 등록한다.
	@Override
	public int registerNewChattingRoom(List<MatchDTO> rangeValidatedList) {
		return sqlSession.insert("richSQL.registerNewChattingRoom", rangeValidatedList);
	}

	
	//그룹의 매칭 결과를 보여주는데 사용되는 SQL
	@Override
	public List<MatchDTO> getMatchingResultMap(String gno) {
		return sqlSession.selectList("richSQL.getMatchingResultMap", gno);
	}

	@Override
	public List<MatchedDTO> getMyGroups(String username) {
		return sqlSession.selectList("richSQL.getMyGroups", username);
	}

	@Override
	public List<MatchedDTO> getGroupDetail(int gno) {
		return sqlSession.selectList("richSQL.getGroupDetail", gno);
	}

	@Override
	public String getIconTagByTopic(String topic) {
		return sqlSession.selectOne("richSQL.getIconTagByTopic", topic);
	}

	@Override
	public List<NotDTO> getGroupSchedules(int gno) {
		return sqlSession.selectList("richSQL.getGroupSchedules", gno);
	}
	// END OF SCHEDULES
}
