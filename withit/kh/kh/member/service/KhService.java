package kh.member.service;

import java.util.List;

public interface KhService {
	public List<String> autocomplete();

	public String getUsername(String nickname);
}
