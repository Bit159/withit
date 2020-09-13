<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>

<head>
<meta id="_csrf" name="_csrf" content="${_csrf.token}">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}">
<meta charset="UTF-8">
<title>자유게시판</title>
<link rel="stylesheet" href="/resources/sj/css/boardView.css">
</head>

<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" />

	<div class="bodywrapper">
        <div class="boardwrapper">
            <h1>자유게시판</h1>
            <div class="boardcontainer">                
                <div class="board_header">
                    <div class="header_upside">
                        <div class="view_bno">${bBoardDTO.bno }</div>
                        <div class="view_title">${bBoardDTO.title }</div>
                    </div>
                    <div class="header_downside">
                        <div class="downside_left">                                                   
                            <div class="view_nickname">${bBoardDTO.nickname }&emsp;</div>
                            <div class="view_boarddate"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${bBoardDTO.boarddate }"/></div>
                            <c:if test="${isAuthor eq true }">
	                            <button type="button" id="modifyBoardBtn" style="width: 70px" data-bno="${bBoardDTO.bno }" data-page="${paging.page }" data-range="${paging.range }">수정</button>
                            	<button type="button" id="deleteBoardBtn" style="width: 70px" data-bno="${bBoardDTO.bno }" data-page="${paging.page }" data-range="${paging.range }">삭제</button>
                            </c:if>
                        </div>
                        <div class="downside_right">
                            <div class="view_replys">댓글수 : ${bBoardDTO.replys }</div>
                            <div class="view_hit">조회수 : ${bBoardDTO.hit }</div>
                        </div>               
                    </div>
                </div>
                <div class="board_body">
                    <div class="content" style="white-space:pre;">${bBoardDTO.content }</div>
                </div>
                <div class="board_footer">
                    <div class="replywrapper">
                        <div class="reply_header">댓글수 : ${bBoardDTO.replys }</div>
	                        
	                        <ul class="reply_group">
	                            
	                            <c:forEach var="replydto" items="${replyList }" varStatus="status">
		                            	<c:if test="${not empty replydto }">
		                            		<div calss="reply_group_div">
			                            		<li class="reply_group_item2">
					                                <div class="itemwrapper">
					                                    <div class="reply_nickname2">${replydto.nickname }</div>
					                                    <div class="replydate2">
					                                    	<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${replydto.replydate }"/>
					                                    </div>
					                                    <textarea name="reply_modify_text1" class="reply_modify_text1" readonly="readonly">${replydto.reply }</textarea>
					                                    <div class="reply_button">
						                                	<button type="button" class="modifyBtn" data-rno="${ replydto.rno }">수정</button>
						                                	<button type="button" class="deleteBtn" data-rno="${ replydto.rno }">삭제</button>
						                                </div>
					                                </div>
					                            </li>
					                            <div class="reply_modify_wrapper">
					                                <div class="reply_modify">
					                                    <label class="reply_modify_label">댓글 수정</label>
					                                    <div class="reply_modify_div">
					                                        <textarea name="reply_modify_text" class="reply_modify_text">${replydto.reply }</textarea>
					                                        <div class="reply_modify_button_div">
					                                            <button class="reply_modify_button" data-rno="${ replydto.rno }" data-page="${paging.page }" data-range="${paging.range }">수정완료</button>
					                                            <button class="reply_modify_cancel">취소</button>
					                                        </div>
					                                    </div>
					                                </div>
					                            </div>
				                            </div>
		                            	</c:if>
	                            </c:forEach>
	                            
	                        </ul>
	                        
	                        <br><br><br><br>
	                    
						<div class="reply_writer_wrapper">
							<div class="reply_writer">
								<label class="reply_writer_label">
									댓글 쓰기
								</label>
								<div class="reply_writer_div">
									<textarea id="reply_writer_text"></textarea>
									<button type="submit" id="reply_writer_btn" data-page="${paging.page }" data-range="${paging.range }">등록</button>
								</div>
								<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}">
							</div>
						</div>
						
						
                    </div>                    
                </div>
            </div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/sj/freeViewBoard.jsp" flush="false"/>
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" />
    
    <c:url var="boardListURL" value="/synergy/board/boardList"></c:url>
    
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script src="/resources/sj/js/boardView2.js" defer></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
	
</body>
</html>