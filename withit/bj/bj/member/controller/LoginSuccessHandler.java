package bj.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import bj.member.service.MemberService;

public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	@Autowired
	private MemberService memberService;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		System.out.println(memberService);
		String username = request.getParameter("username");
		String nickname = memberService.getNickname(username);
		System.out.println(nickname);
		
		HttpSession session = request.getSession();
		session.setAttribute("nickname", nickname);
		session.setAttribute("chattingCheck", "0");
		response.sendRedirect("/");
		
	}

}
