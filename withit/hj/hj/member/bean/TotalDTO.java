package hj.member.bean;

import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class TotalDTO {
	private String month;
	private int total;
}
