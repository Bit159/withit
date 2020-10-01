package com.bit159.withit;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import rich.dao.RichDAO;
import rich.dao.VisitorDTO;
import sun.reflect.ReflectionFactory.GetReflectionFactoryAction;

@Controller
public class HomeController {
	
	@Autowired private VisitorDTO visitorDTO;
	@Autowired private RichDAO richDAO;
	
	@GetMapping("/")
	public String home(HttpServletRequest httpServletRequest) {
		System.out.println(httpServletRequest.getRequestedSessionId());
		System.out.println(httpServletRequest.getRequestedSessionId()==null);
		if(httpServletRequest.getRequestedSessionId() == null) {
			visitorDTO.setUsername(httpServletRequest.getRemoteUser());
			visitorDTO.setIp(httpServletRequest.getRemoteAddr());
			visitorDTO.setLocale(httpServletRequest.getLocale().toString());
			visitorDTO.setTime(new Date());
			richDAO.logVisitor(visitorDTO);	
		}
		return "kh/all/welcome";
	}
	
}
