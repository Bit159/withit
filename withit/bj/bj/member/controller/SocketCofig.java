package bj.member.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class SocketCofig implements WebSocketMessageBrokerConfigurer{
	
	@Override
	public void configureMessageBroker(MessageBrokerRegistry registry) {
		registry.enableSimpleBroker("/topic");
		registry.setApplicationDestinationPrefixes("/app");
	}

	@Override
	public void registerStompEndpoints(StompEndpointRegistry registry) {
		registry.addEndpoint("/chat").withSockJS();
	}
	
}

/*
Stomp는 중간 메시지 브로커 역할이기 때문에 WebSocketMessageBrokerCofigurer를 구현해야한다.

1. configureMessageBroker()는 publish할때와 subscribe할 때 사용할 url prefix를 지정해준다.

	enableSimpleBroker("/topic")
	 : /topic 아래로 들어오는 url이 subscribe 할 때 사용할 url이다.
	 
	setApplicationDestinationPrefixes("/app")
	 : /app이 publish 할 때 사용할 url이다.

2. registStomopEndPoints는 해당 링크로 동작하는 SockJs를 만들어 등록하겠다는 의미이다.
*/
