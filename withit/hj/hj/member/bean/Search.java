package hj.member.bean;

import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class Search extends Pagination{
	private String searchType;
	private String keyword;	
}
