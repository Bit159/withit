package hj.member.dao;

import java.util.List;
import java.util.Map;

import bj.member.bean.MemberDTO;
import hj.member.bean.MatchDTO;
import hj.member.bean.ProgrammingDTO;
import hj.member.bean.Search;
import hj.member.bean.TotalDTO;

public interface HjDAO {

	public abstract MemberDTO login(String id, String pwd);
	public abstract void join(Map<String, String> map);
	public abstract void withdrawal(String username);
	public abstract MemberDTO getMyPage(Map<String, String> map);
	public abstract void revise(Map<String, String> map);
	public abstract void nicknameRevise(Map<String, String> map);
	public abstract List<MemberDTO> getMember();
	public abstract void memberDelete(String username);
	public abstract List<MemberDTO> getBoardList();

	public abstract List<TotalDTO> getTotalStats();
	public abstract List<ProgrammingDTO> getProgrammingStats();
	public abstract List<MatchDTO> getListFromMatch();
	public abstract int getBoardListCnt(Search search);
	public abstract List<MemberDTO> getBoardList(Search search);
	public abstract List<MemberDTO> getWithdrawalList(String username);
	public abstract List<MemberDTO> getNickName(String nickname);
	public abstract void passwordRevise(Map<String, String> map);

}
