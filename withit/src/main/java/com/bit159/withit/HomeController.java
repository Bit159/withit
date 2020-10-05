package com.bit159.withit;

import java.util.Date;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import rich.dao.RichDAO;
import rich.dao.VisitorDTO;
import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

@Controller
public class HomeController {

	@Autowired
	private VisitorDTO visitorDTO;
	@Autowired
	private RichDAO richDAO;

	@GetMapping("/")
	public String home(HttpServletRequest httpServletRequest) {
		System.out.println(httpServletRequest.getHeader("User-Agent"));
		
		visitorDTO.setUsername(httpServletRequest.getRemoteUser()); // 로그인유저일 경우 ip 비로그인이면 null
		visitorDTO.setIp(getClientIP(httpServletRequest));// ip
		visitorDTO.setLocale(httpServletRequest.getLocale().toString());// 위치
		visitorDTO.setTime(new Date());// 시간?
		richDAO.logVisitor(visitorDTO);
		return "kh/all/welcome";
	}

	//아이피 정보 https://linked2ev.github.io/java/2019/05/22/JAVA-1.-java-get-clientIP/
	public static String getClientIP(HttpServletRequest request) {
		String ip = request.getHeader("X-Forwarded-For");

		if (ip == null) {
			ip = request.getHeader("Proxy-Client-IP");
		}
		if (ip == null) {
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_CLIENT_IP");
		}
		if (ip == null) {
			ip = request.getHeader("HTTP_X_FORWARDED_FOR");
		}
		if (ip == null) {
			ip = request.getRemoteAddr();
		}
		return ip;
	}

	// 운영체제 정보 http://www.frostk.com/post/109
	public static String getClientOS(String userAgent) {
		String os = "";
		userAgent = userAgent.toLowerCase();
		if (userAgent.indexOf("windows nt 6.1") > -1) {
			os = "Windows7";
		} else if (userAgent.indexOf("windows nt 6.2") > -1 || userAgent.indexOf("windows nt 6.3") > -1) {
			os = "Windows8";
		} else if (userAgent.indexOf("windows nt 6.0") > -1) {
			os = "WindowsVista";
		} else if (userAgent.indexOf("windows nt 5.1") > -1) {
			os = "WindowsXP";
		} else if (userAgent.indexOf("windows nt 5.0") > -1) {
			os = "Windows2000";
		} else if (userAgent.indexOf("windows nt 4.0") > -1) {
			os = "WindowsNT";
		} else if (userAgent.indexOf("windows 98") > -1) {
			os = "Windows98";
		} else if (userAgent.indexOf("windows 95") > -1) {
			os = "Windows95";
		} else if (userAgent.indexOf("iphone") > -1) {
			os = "iPhone";
		} else if (userAgent.indexOf("ipad") > -1) {
			os = "iPad";
		} else if (userAgent.indexOf("android") > -1) {
			os = "android";
		} else if (userAgent.indexOf("mac") > -1) {
			os = "mac";
		} else if (userAgent.indexOf("linux") > -1) {
			os = "Linux";
		} else if (userAgent.indexOf("bingbot/") > -1 || userAgent.indexOf("googlebot/") > -1) {
			os = "Robot";
		} else {
			os = userAgent;
		}
		return os;
	}

	// 브라우저 정보 : http://www.frostk.com/post/109
	public static String getClientBrowser(String userAgent) {
		String browser = "";
		if (userAgent.indexOf("Trident/7.0") > -1) {
			browser = "ie11";
		} else if (userAgent.indexOf("MSIE 10") > -1) {
			browser = "ie10";
		} else if (userAgent.indexOf("MSIE 9") > -1) {
			browser = "ie9";
		} else if (userAgent.indexOf("MSIE 8") > -1) {
			browser = "ie8";
		} else if (userAgent.indexOf("Edg/") > -1) {
			browser = "Edge";
		} else if (userAgent.indexOf("Chrome/") > -1) {
			browser = "Chrome";
		} else if (userAgent.indexOf("Safari/") > -1) {
			browser = "Safari";
		} else if (userAgent.indexOf("Firefox/") > -1) {
			browser = "Firefox";
		} else if (userAgent.indexOf("bingbot/") > -1 || userAgent.indexOf("Googlebot/") > -1) {
			browser = "Robot";
		} else {
			browser = userAgent;
		}
		return browser;
	}

}
