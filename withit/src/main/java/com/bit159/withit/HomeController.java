package com.bit159.withit;

import java.security.Principal;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import net.sf.json.JSONObject;
import rich.dao.RichDAO;
import rich.dao.VisitorDTO;

@Controller
public class HomeController {

	@Autowired
	private VisitorDTO visitorDTO;
	@Autowired
	private RichDAO richDAO;

	@GetMapping("/")
	public String home() {
		return "kh/all/welcome";
	}
	
	@PostMapping("/visitCount")
	@ResponseBody
	public void visitCount(@RequestBody JSONObject json, HttpServletRequest httpServletRequest, Principal principal) {
		try {visitorDTO.setUsername(principal.getName());
		}catch (NullPointerException e) {}
		visitorDTO.setIp(getClientIP(httpServletRequest));
		Date date = new Date();
		date.setTime(json.getLong("time"));
		visitorDTO.setTime(date);
		visitorDTO.setLocale(json.getString("language"));
		visitorDTO.setBrowser(json.getString("browser"));
		visitorDTO.setOs(json.getString("os"));
		visitorDTO.setReferer(json.getString("referer"));
		visitorDTO.setWidth(json.getInt("width"));
		visitorDTO.setHeight(json.getInt("height"));
		visitorDTO.setUseragent(json.getString("userAgent"));
		
		richDAO.logVisitor(visitorDTO);
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

}
