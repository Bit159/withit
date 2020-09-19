package hj.member.service;



import java.util.List;
import java.util.Map;

import bj.member.bean.MemberDTO;
import hj.member.bean.MatchDTO;
import hj.member.bean.ProgrammingDTO;
import hj.member.bean.Search;
import hj.member.bean.TotalDTO;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;

public interface HjService {

	public MemberDTO login(String id, String pwd);

	public void join(Map<String, String> map);

	public void withdrawal(String username);

	public MemberDTO getMyPage(Map<String, String> map);

	public void revise(Map<String, String> map);

	public void nicknameRevice(Map<String, String> map);

	public List<MemberDTO> getMember();

	public void memberDelete(String username);

	public List<MemberDTO> getBoardList();

	

	

	public List<TotalDTO> getTotalStats();

	public List<ProgrammingDTO> getProgrammingStats();

	public List<MatchDTO> getListFromMatch();

	public int getBoardListCnt(Search search);

	public List<MemberDTO> getMemberList(Search search);

	public List<MemberDTO> getWithdrawalList(String username);

	public List<MemberDTO> getNickName(String nickname);

	public void passwordRevise(Map<String, String> map);

	public int checkUsername(String username);

	public int checkNickname(String nickname);

	public int totalprogramming();

	public List<BBoardDTO> getBBoardList(Search search);

	public int getBBoardListCnt(Search search);

	public BBoardDTO getBBoard(int bno);

	public List<BBoardReplyDTO> getBBoardReplyList(int bno);

	public void deleteBBoard(int bno);

	

	

	

	
}
