package bj.member.service;

import java.util.List;
import java.util.Map;

import bj.member.bean.ChattingDTO;
import bj.member.bean.ChattingRoomDTO;
import bj.member.bean.MemberDTO;
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.paging.Search;

public interface MemberService {

	public MemberDTO login(Map<String, String> map);
	public List<ChattingDTO> getChatting(String chattingRoom);
	public void createChat();
	public List<ChattingRoomDTO> getChattingRoom(String username);
	public void sendMessage(String sender, String message, String chattingRoom);
	public void sendMessage(ChattingDTO chattingDTO);
	public String getNickname(String username);
	public ChattingDTO getLastChatting(String chattingRoom);
	public ChattingRoomDTO getAllChatting();
	public void join(Map<String, String> map);
	public MemberDTO checkMember(String username);
	public void newPwd(Map<String, String> map);
	public int getNoticeListCnt(Search search);
	public List<BBoardDTO> getNoticeList(Search search);
	public BBoardDTO getNotice(int bno);
	public void noticeHipUpdate(int bno);
	public List<BBoardReplyDTO> getNoticeReplyList(int bno);
	public void noticeReply(Map<String, Object> map);
	public void noticeReplyDelete(Map<String, Integer> map);
	public void noticeReplyModify(Map<String, Object> map);
	public void noticeDelete(int bno);
	public void noticeWrite(Map<String, Object> map);
	public void noticeModify(Map<String, Object> map);
	public int getQnaListCnt(Search search);
	public List<BBoardDTO> getQnaList(Search search);
	public BBoardDTO getQna(int bno);
	public List<BBoardReplyDTO> getQnaReplyList(int bno);
	public void qnaHipUpdate(int bno);
	public void qnaReply(Map<String, Object> map);
	public void qnaReplyDelete(Map<String, Integer> map);
	public void qnaReplyModify(Map<String, Object> map);
	public void qnaDelete(int bno);
	public void qnaWrite(Map<String, Object> map);
	public void qnaModify(Map<String, Object> map);

}
