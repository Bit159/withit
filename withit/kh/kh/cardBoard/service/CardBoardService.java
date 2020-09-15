package kh.cardBoard.service;

import java.util.List;

import kh.cardBoard.bean.CardBoardDTO;
import kh.cardBoard.bean.CardBoardPaging;
import kh.cardBoard.bean.CardBoardReplyDTO;

public interface CardBoardService {
	public void regist(CardBoardDTO groupDTO);
	public List<CardBoardDTO> getCardBoardList(CardBoardPaging paging);
	public List<String> getLocationList(String location);
	public List<CardBoardDTO> searchCard(List<Object> list);
	public List<CardBoardDTO> searchCardNoloc(String topic, CardBoardPaging paging);
	public CardBoardDTO getCardContent(int seq);
	public int getBoardListCnt();
	public List<CardBoardReplyDTO> getReplyList(int seq);
	public void writeReply(CardBoardReplyDTO dto);
	public void deleteReply(int rseq);
	public void modifyReply(CardBoardReplyDTO dto);
	public void replyCntup(CardBoardDTO cardDTO);
	public void replyCntdown(CardBoardDTO cardDTO);
	public int getNolocBoardListCnt(String topic);
	public int getSearchBoardListCnt(List<Object> list);
	public void closeCard(int seq);
	public void modifyGroup(CardBoardDTO cardBoardDTO);
}
