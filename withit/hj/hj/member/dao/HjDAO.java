package hj.member.dao;

import java.util.List;
import java.util.Map;

import bj.member.bean.MemberDTO;
import hj.member.bean.MatchDTO;
import hj.member.bean.ProgrammingDTO;
import hj.member.bean.Search;
import hj.member.bean.TotalDTO;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;

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
	public abstract List<MemberDTO> getMemberList(Search search);
	public abstract List<MemberDTO> getWithdrawalList(String username);
	public abstract List<MemberDTO> getNickName(String nickname);
	public abstract void passwordRevise(Map<String, String> map);
	public abstract int checkUsername(String username);
	public abstract int checkNickname(String nickname);
	public abstract int totalprogramming();
	public abstract List<BBoardDTO> getBBoardList(Search search);
	public abstract int getBBoardListCnt(Search search);
	public abstract BBoardDTO getBBoard(int bno);
	public abstract List<BBoardReplyDTO> getBBoardReplyList(int bno);
	public abstract void deleteBBoard(int bno);
	public abstract void replyDelete2(int rno);
	public abstract void replyDeleteUpdate2(int bno);

}
