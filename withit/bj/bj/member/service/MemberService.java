package bj.member.service;

import java.util.List;
import java.util.Map;

import bj.member.bean.ChattingDTO;
import bj.member.bean.ChattingRoomDTO;
import bj.member.bean.MemberDTO;

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

}
