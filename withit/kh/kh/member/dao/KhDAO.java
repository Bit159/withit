package kh.member.dao;

import java.util.List;

public interface KhDAO {
	public List<String> autocomplete();

	public String getUsername(String nickname);
}
