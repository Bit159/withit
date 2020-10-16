package bj.member.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import bj.member.bean.ChattingDTO;
import bj.member.service.MemberService;

@Controller
public class StompSocketController {
	@Autowired
	private SimpMessagingTemplate simpMessagingTemplate;
	@Autowired
	private MemberService memberService;
	
	@MessageMapping("/message")
	public void send(ChattingDTO chattingDTO) {	
		LocalDateTime date = LocalDateTime.now();
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy.MM.dd HH:mm");
		
		chattingDTO.setChat_date(formatter.format(date));
		
		memberService.sendMessage(chattingDTO);
		simpMessagingTemplate.convertAndSend("/topic/" + chattingDTO.getChattingRoom(), chattingDTO);
	}
}
