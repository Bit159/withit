package rich.dao;

import java.util.Date;
import java.util.List;

import hj.member.bean.MatchDTO;
import hj.member.bean.MatchedDTO;
import rich.notify.NotDTO;
import sj.board.bean.CBoardDTO;

public interface RichDAO {

	//지도용
	public abstract int insertMatch(MatchDTO matchDTO);
	public abstract List<MatchDTO> getMyListFromMatch(String username);
	public abstract int deleteMatched(List<MatchDTO> list);
	public abstract int deleteMatch(int mno);
	public abstract int getMycareer(String username);
	
	//크롤링용
	public abstract int crawlInsert(List<CBoardDTO> list);
	public abstract List<String> getEmptyContentBno();
	public abstract int insertContents(List<CBoardDTO> list);
	public abstract int getGreatestBno();
	
	//알림용
	public abstract List<NotDTO> getOnTimeList();
	public abstract Date getDBTime();
	
	//스케쥴용
	public abstract int getGreatestNo();
	public abstract int createSchedule(NotDTO dto);
	public abstract List<NotDTO> getMySchedules(String username);
	public abstract int updateSchedule(NotDTO dto);
	public abstract int removeSchedule(int no);
	public abstract List<NotDTO> getGroupSchedules(int gno);
	
	//그룹 생성
	public abstract int createGroup(List<MatchDTO> rangeValidatedList);
	public abstract int getGreatestGno();
	public abstract int getChattingRoomIndex();
	public abstract int createChattingRoom(String tableName);
	public abstract int addChattingRoomIndex();
	public abstract int setChattingRoomMembers(List<MatchDTO> rangeValidatedList);
	public abstract int registerNewChattingRoom(List<MatchDTO> rangeValidatedList);
	public abstract List<MatchDTO> getMatchingResultMap(String gno);
	public abstract List<MatchedDTO> getMyGroups(String username);
	public abstract List<MatchedDTO> getGroupDetail(int gno);
	
	//아이콘
	public abstract String getIconTagByTopic(String topic);

	//방문자 기록
	public abstract int logVisitor(VisitorDTO visitorDTO);
	
	//프로젝트 소개
	public abstract List<HistoryDTO> getHistories();
	public abstract int createHistory(HistoryDTO historyDTO);
	public abstract int updateHistory(HistoryDTO historyDTO);
	public abstract int deleteHistory(HistoryDTO historyDTO);
}
