package bj.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.websocket.OnClose;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;


//@Controller
//@ServerEndpoint(value="/chat")
public class WebSocket {
	private static final List<Session> sessionList = new ArrayList<Session>();
	private static final Logger logger = LoggerFactory.getLogger(WebSocket.class);
	
	//ServerEndPoint에서는 autowired를 못해준다. 가장 처음 빈을 만들기 때문에.
	
	public WebSocket() {
		System.out.println("웹 소켓 객체 생성");
	}
	
	@OnOpen
	public void onOpen(Session session) {
		logger.info("Open Session Id : " + session.getId());
		System.out.println("Open Session Id : " + session.getId());
		try {
			final Basic basic = session.getBasicRemote();
			basic.sendText("connection establish");
			
		} catch (IOException e) {
			System.out.println(e.getMessage());
			
		}
		sessionList.add(session);
	}
	
	private void sendAllSessionToMessage(Session self, String sender , String message) {
		for(Session session : sessionList) {
			if(!self.getId().equals(session.getId())) {
				try {
					session.getBasicRemote().sendText(sender + " : " + message);
					System.out.println(sender + " : " + message);
					
				} catch (IOException e) {
					System.out.println(e.getMessage());

				}
			}
		}
	}
	
	@OnMessage
	public void onMessage(String message, Session session) {
		String sender = message.split(",")[1]; 
		message = message.split(",")[0]; 
		logger.info("Message From " + sender + " : " + message); 
		System.out.println("Message From " + sender + " : "+ message);
		try { 	
			final Basic basic = session.getBasicRemote(); 
			basic.sendText("<나> : " + message); 
			
		}catch (Exception e) { 
			System.out.println(e.getMessage()); 
			
		} 
		System.out.println(sender + " : " + message);
		sendAllSessionToMessage(session, sender, message);
	}
	
	@OnClose
	public void onClose(Session session) {
		logger.info("Session " + session.getId() + " has ended");
		System.out.println("Session " + session.getId() + " has ended");
		
		sessionList.remove(session);
	}
	
	/*
	@ServerEndpoint(value="/chat") 는 /chat 라는 url 요청을 통해 웹소켓에 들어가겠다라는 어노테이션입니다.

	@onOpen 는 클라이언트가 웹소켓에 들어오고 서버에 아무런 문제 없이 들어왔을때 실행하는 메소드입니다.

	@onMessage 는 클라이언트에게 메시지가 들어왔을 때, 실행되는 메소드입니다.

	@onError 

	@onClose 는 클라이언트와 웹소켓과의 연결이 끊기면 실행되는 메소드입니다.

	sendAllSessionToMessage()는 어떤 누군가에게 메시지가 왔다면 그 메시지를 보낸 자신을 제외한 연결된 세션(클라이언트)에게 메시지를 보내는 메소드입니다.
	*/

}
