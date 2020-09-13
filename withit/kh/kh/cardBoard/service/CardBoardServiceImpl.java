package kh.cardBoard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import kh.cardBoard.bean.CardBoardDTO;
import kh.cardBoard.bean.CardBoardPaging;
import kh.cardBoard.bean.CardBoardReplyDTO;
import kh.cardBoard.dao.CardBoardDAO;

@Service
public class CardBoardServiceImpl implements CardBoardService {
	@Autowired
	private CardBoardDAO cardBoardDAO;
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	@Override
	public void regist(CardBoardDTO groupDTO) {
		 cardBoardDAO.regist(groupDTO);
	}
	@Override
	public List<CardBoardDTO> getCardBoardList(CardBoardPaging paging) {
		return cardBoardDAO.getCardBoardList(paging);
	}
	@Override
	public List<String> getLocationList(String location) {
		return cardBoardDAO.getLocationList(location);
	}
	@Override
	public List<CardBoardDTO> searchCard(List<Object> list) {
		return cardBoardDAO.searchCard(list);
	}
	@Override
	public List<CardBoardDTO> searchCardNoloc(String topic,CardBoardPaging paging) {
		return cardBoardDAO.searchCardNoloc(topic,paging);
	}
	@Override
	public CardBoardDTO getCardContent(int seq) {
		return cardBoardDAO.getCardContent(seq);
	}
	@Override
	public int getBoardListCnt() {
		return cardBoardDAO.getBoardListCnt();
	}
	@Override
	public List<CardBoardReplyDTO> getReplyList(int seq) {
		return cardBoardDAO.getReplyList(seq);
	}
	@Override
	public void writeReply(CardBoardReplyDTO dto) {
		cardBoardDAO.writeReply(dto);
	}
	@Override
	public void deleteReply(int rseq) {
		cardBoardDAO.deleteReply(rseq);
	}
	@Override
	public void modifyReply(CardBoardReplyDTO dto) {
		cardBoardDAO.modifyReply(dto);
	}
	@Override
	public void replyCntup(CardBoardDTO cardDTO) {
		cardBoardDAO.replyCntup(cardDTO);
	}
	@Override
	public void replyCntdown(CardBoardDTO cardDTO) {
		cardBoardDAO.replyCntdown(cardDTO);
	}
	@Override
	public int getNolocBoardListCnt(String topic) {
		return cardBoardDAO.getNolocBoardListCnt(topic);
	}
	@Override
	public int getSearchBoardListCnt(List<Object> list) {
		return cardBoardDAO.getSearchBoardListCnt(list);
	}
	@Override
	public void closeCard(int seq) {
		cardBoardDAO.closeCard(seq);
	}
	
}
