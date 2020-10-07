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
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import bj.member.service.MemberService;

public class LoginSuccessHandler implements AuthenticationSuccessHandler{
	@Autowired
	private MemberService memberService;

	
	// 로그인 성공시 redirect 처리 by rich 2020.10.07
	// 참고 출처 : https://to-dy.tistory.com/94
	// 스프링 시큐리티에서 제공하는 인터페이스로 요청URL 정보가 담긴 클래스에 접근해서 보내준다.
    private RequestCache requestCache = new HttpSessionRequestCache();
    private RedirectStrategy redirectStratgy = new DefaultRedirectStrategy();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
		/*List<String> roleNames = new ArrayList<String>();
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
			request.getSession().setAttribute("admin", null);
			response.sendRedirect("/");
			return;
		} */
		String username = request.getParameter("username");
		String nickname = memberService.getNickname(username);
		request.getSession().setAttribute("nickname", nickname);
		
		
        SavedRequest savedRequest = requestCache.getRequest(request, response);
        if(savedRequest!=null) {
            String targetUrl = savedRequest.getRedirectUrl();
            redirectStratgy.sendRedirect(request, response, targetUrl);
        } else {
            redirectStratgy.sendRedirect(request, response, "/");
        }
        
	}

}
