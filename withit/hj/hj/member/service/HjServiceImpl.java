package hj.member.service;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import bj.member.bean.MemberDTO;
import bj.member.dao.MemberDAO;
import hj.member.bean.MatchDTO;
import hj.member.bean.ProgrammingDTO;
import hj.member.bean.Search;
import hj.member.bean.TotalDTO;
import hj.member.dao.HjDAO;

@Service
public class HjServiceImpl implements HjService {
	@Autowired
	private HjDAO hjDAO;
	@Autowired
	private BCryptPasswordEncoder encoder;


	@Override
	public void withdrawal(String username) {
		hjDAO.withdrawal(username);
	}

	@Override
	public MemberDTO getMyPage(Map<String, String> map) {
		
		return hjDAO.getMyPage(map);
	}

	@Override
	public void revise(Map<String, String> map) {
		
		String password = encoder.encode(map.get("password"));
		map.replace("password", password);
		
		hjDAO.revise(map);
		
	}

	@Override
	public void nicknameRevice(Map<String, String> map) {
		hjDAO.nicknameRevise(map);
	}

	@Override
	public List<MemberDTO> getMember() {
		return hjDAO.getMember();
	}

	@Override
	public void memberDelete(String username) {
		hjDAO.memberDelete(username);
	}

	@Override
	public List<MemberDTO> getBoardList() {
		return hjDAO.getBoardList();
	}

	@Override
	public List<TotalDTO> getTotalStats() {
		return hjDAO.getTotalStats();
	}

	@Override
	public List<ProgrammingDTO> getProgrammingStats() {
		return hjDAO.getProgrammingStats();
	}

	@Override
	public List<MatchDTO> getListFromMatch() {
		return hjDAO.getListFromMatch();
	}

	@Override
	public int getBoardListCnt(Search search) {
		return hjDAO.getBoardListCnt(search);
	}

	@Override
	public List<MemberDTO> getMemberList(Search search) {
		return hjDAO.getMemberList(search);
	}

	@Override
	public List<MemberDTO> getWithdrawalList(String username) {
		return hjDAO.getWithdrawalList(username);
	}

	@Override
	public List<MemberDTO> getNickName(String nickname) {
		return hjDAO.getNickName(nickname);
	}

	@Override
	public void passwordRevise(Map<String, String> map) {
		String password = encoder.encode(map.get("password"));
		map.replace("password", password);
		hjDAO.passwordRevise(map);
	}

	@Override
	public MemberDTO login(String id, String pwd) {
		return null;
	}

	@Override
	public void join(Map<String, String> map) {
		String password = encoder.encode(map.get("password"));
		map.replace("password", password);
	//	map.put("auth", "ROLE_MEMBER");
		hjDAO.join(map);
	}

	@Override
	public int checkUsername(String username) {
		
		return hjDAO.checkUsername(username);
	}

	@Override
	public int checkNickname(String nickname) {
		
		return hjDAO.checkNickname(nickname);
	}

	@Override
	public int totalprogramming() {
		
		return hjDAO.totalprogramming();
	}

	@Override
	public void careerRevise(Map<String, String> map) {
		hjDAO.careerRevise(map);
	}

	@Override
	public void careerPasswordRevise(Map<String, String> map) {
		String password = encoder.encode(map.get("password"));
		map.replace("password", password);
		
		hjDAO.careerPasswordRevise(map);
	}

}
