package rich.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import hj.member.bean.MatchDTO;
import lombok.Setter;
import rich.notify.NotDTO;
import sj.board.bean.CBoardDTO;

@Repository
@Transactional
@Setter
public class RichDAOImpl implements RichDAO {
	
	@Autowired
	private SqlSession sqlSession;
	
	// FOR MAP
	@Override
	public int getMycareer(String username) {
		return sqlSession.selectOne("richSQL.getMycareer", username);
	}
	
	@Override
	public int insertMatch(MatchDTO matchDTO) {
		return sqlSession.insert("richSQL.insertMatch", matchDTO);
	}

	@Override
	public List<MatchDTO> getListFromMatch() {
		return sqlSession.selectList("richSQL.getListFromMatch");
	}

	@Override
	public int deleteMatched(List<MatchDTO> list) {
		return sqlSession.delete("richSQL.deleteMatched", list);
	}

	@Override
	public int deleteMatch(MatchDTO matchDTO) {
		return sqlSession.delete("richSQL.deleteMatch", matchDTO);
	}
	// End of FOR MAP
	
	
	
	
	// FOR CRAWL
	@Override
	public int crawlInsert(List<CBoardDTO> list) {
		return sqlSession.insert("richSQL.crawlInsert", list);
	}

	@Override
	public List<String> getEmptyContentBno() {
		return sqlSession.selectList("richSQL.getEmptyContentBno");
	}

	@Override
	public int insertContents(List<CBoardDTO> list) {
		return sqlSession.insert("richSQL.insertContents", list);
	}

	@Override
	public int getGreatestBno() {
		return sqlSession.selectOne("richSQL.getGreatestBno");
	}

	// End of FOR CRAWL

	
	
	
	
	// FOR Notification function
	@Override
	public List<NotDTO> getOnTimeList() {
		return sqlSession.selectList("richSQL.getOnTimeList");
	}
	@Override
	public Date getDBTime() {
		return sqlSession.selectOne("richSQL.getDBTime");
	}

	// End of Notification Methods
	
	
	
	
	
	
	// FOR DISPLAYING SCHEDULES
	@Override
	public int createSchedule(NotDTO dto) {
		return sqlSession.insert("richSQL.createSchedule", dto);
	}
	@Override
	public List<NotDTO> getSchedules() {
		return sqlSession.selectList("richSQL.getSchedules");
	}
	@Override
	public int updateSchedule(NotDTO dto) {
		return sqlSession.delete("richSQL.updateSchedule", dto);
	}
	@Override
	public int removeSchedule(int no) {
		return sqlSession.delete("richSQL.removeSchedule", no);
	}

	@Override
	public int getGreatestNo() {
		return sqlSession.selectOne("richSQL.getGreatestNo");
	}
	// END OF SCHEDULES
}
