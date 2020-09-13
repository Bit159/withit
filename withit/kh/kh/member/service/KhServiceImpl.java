package kh.member.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kh.member.dao.KhDAO;

@Service
public class KhServiceImpl implements KhService {
	@Autowired
	private KhDAO khDAO;

	@Override
	public List<String> autocomplete() {
		return khDAO.autocomplete();
	}

}
