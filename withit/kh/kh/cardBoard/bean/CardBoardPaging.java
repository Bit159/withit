package kh.cardBoard.bean;

import lombok.Data;

@Data
public class CardBoardPaging {
	private int listSize = 9; // 초기값으로 목록개수를 9로 셋팅
	private int rangeSize = 5; // 초기값으로 페이지범위를 5로 셋팅
	private int page; 
	private int range; 
	private int listCnt; 
	private int pageCnt; 
	private int startPage; 
	private int startList; 
	private int endPage; 
	private boolean prev; 
	private boolean next;
	private boolean first;
	private boolean last;
	private String location;
	private String topic;
	
	public void pageInfo(int page, int range, int listCnt, String location, String topic) {
		this.page = page;
		this.range = range;
		this.listCnt = listCnt;
		//전체 페이지수 
		this.pageCnt = (int) Math.ceil((double)listCnt/listSize);
		//각 범위 시작 페이지
		this.startPage = (range - 1) * rangeSize + 1 ;
		//끝 페이지
		this.endPage = range * rangeSize;
		//게시글 시작번호
		this.startList = (page - 1) * listSize;
		//이전 버튼 상태
		this.prev = range == 1 ? false : true;
		//다음 버튼 상태
		this.next = pageCnt > endPage ? true : false;
		if (this.endPage > this.pageCnt) {
			this.endPage = this.pageCnt;
			this.next = false;
		}
		//맨 처음으로
		this.first = page == 1 ? false : true;
		//맨 마지막으로
		this.last = pageCnt == page ? false : true;
		if(this.pageCnt == 0) {
			this.last = false;
		}
		
		this.location = location;
		this.topic = topic;
		
	}
}
