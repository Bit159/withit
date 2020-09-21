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
import sj.board.bean.BBoardDTO;
import sj.board.bean.BBoardReplyDTO;
import sj.board.paging.Search;

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
	
	@Override
	public void join(Map<String, String> map) {
		String password = passwordEncoder.encode(map.get("password"));
		map.replace("password", password);
		memberDAO.join(map);
	}

	@Override
	public MemberDTO checkMember(String username) {
		return memberDAO.checkMember(username);
	}

	@Override
	public void newPwd(Map<String, String> map) {
		String password = passwordEncoder.encode(map.get("password"));
		map.put("password", password);
		
		memberDAO.newPwd(map);
	}

	@Override
	public int getNoticeListCnt(Search search) {
		return memberDAO.getNoticeListCnt(search);
	}

	@Override
	public List<BBoardDTO> getNoticeList(Search search) {
		return memberDAO.getNoticeList(search);
	}

	@Override
	public BBoardDTO getNotice(int bno) {
		return memberDAO.getNotice(bno);
	}

	@Override
	public void noticeHipUpdate(int bno) {
		memberDAO.noticeHitUpdate(bno);
	}

	@Override
	public List<BBoardReplyDTO> getNoticeReplyList(int bno) {
		return memberDAO.getNoticeReplyList(bno);
	}

	@Override
	public void noticeReply(Map<String, Object> map) {
		memberDAO.noticeReply(map);
	}

	@Override
	public void noticeReplyDelete(Map<String, Integer> map) {
		memberDAO.noticeReplyDelete(map);
	}

	@Override
	public void noticeReplyModify(Map<String, Object> map) {
		memberDAO.noticeReplyModify(map);
	}

	@Override
	public void noticeDelete(int bno) {
		memberDAO.noticeDelete(bno);
	}

	@Override
	public void noticeWrite(Map<String, Object> map) {
		memberDAO.noticeWrite(map);
	}

	@Override
	public void noticeModify(Map<String, Object> map) {
		memberDAO.noticeModify(map);
	}

	
	
}
