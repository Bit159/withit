package kh.member.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

@Repository
@Transactional
public class KhDAOMybatis implements KhDAO {
	
	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<String> autocomplete() {
		return sqlSession.selectList("khSQL.autocomplete");
	}

}
