package bj.member.service;

import java.util.List;
import java.util.Map;

import org.apache.commons.collections4.map.HashedMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import bj.member.bean.ChattingDTO;
import bj.member.bean.ChattingRoomDTO;
import bj.member.bean.MemberDTO;
import bj.member.dao.MemberDAO;

@Service
public class MemberServiceImpl implements MemberService {
	@Autowired
	private MemberDAO memberDAO;
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	//======================================================= 로그인
	
	@Override
	public MemberDTO login(Map<String, String> map) {
		return memberDAO.login(map);
	}
	
	//======================================================= 채팅방
	
	@Override
	public void sendMessage(String sender, String message, String chattingRoom) {
		Map<String,String> map = new HashedMap<String, String>();
		map.put("sender", sender);
		map.put("message", message);
		map.put("chattingRoom", chattingRoom);
		memberDAO.sendMessage(map);
	}

	@Override
	public void sendMessage(ChattingDTO chattingDTO) {
		memberDAO.sendMessage(chattingDTO);
		
	}
	
	@Override
	public List<ChattingDTO> getChatting(String chattingRoom) {
		return memberDAO.getChatting(chattingRoom);
	}

	@Override
	public void createChat() {
		memberDAO.createChat();
	}

	@Override
	public List<ChattingRoomDTO> getChattingRoom(String username) {
		return memberDAO.getChattingRoom(username);
	}

	@Override
	public String getNickname(String username) {
		return memberDAO.getNickname(username);
	}

	@Override
	public ChattingDTO getLastChatting(String chattingRoom) {
		return memberDAO.getLastChatting(chattingRoom);
	}

	@Override
	public ChattingRoomDTO getAllChatting() {
		return memberDAO.getAllChatting();
	}

	
	
}
