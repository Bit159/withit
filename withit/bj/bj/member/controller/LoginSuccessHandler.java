package bj.member.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

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
		List<String> roleNames = new ArrayList<String>();
		authentication.getAuthorities().forEach(authority -> { 
			roleNames.add(authority.getAuthority());
		});
		if(roleNames.contains("ROLE_ADMIN")) {
			String username = request.getParameter("username");
			String nickname = memberService.getNickname(username);
			request.getSession().setAttribute("nickname", nickname);
			request.getSession().setAttribute("admin", "admin");
			response.sendRedirect("/"); 
			return; 
		} 
		
		if(roleNames.contains("ROLE_MEMBER")) { 
			String username = request.getParameter("username");
			String nickname = memberService.getNickname(username);
			HttpSession session = request.getSession();
			session.setAttribute("nickname", nickname);
			session.setAttribute("chattingCheck", "0");
			request.getSession().setAttribute("admin", null);
			response.sendRedirect("/");
			return;
		} 

		response.sendRedirect("/");
		
	}

}
