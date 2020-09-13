package hj.member.bean;

import org.springframework.stereotype.Service;

import lombok.Data;

@Data
@Service
public class ProgrammingDTO {
	private String topic;
	private int topicTotal;
}
