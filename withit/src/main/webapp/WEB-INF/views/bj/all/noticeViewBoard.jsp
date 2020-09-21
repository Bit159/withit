<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec"  uri="http://www.springframework.org/security/tags" %>

<link rel="stylesheet" href="/resources/sj/css/boardList.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>

	<div class="body_wrapper">
        <div class="body_container">
            <div class="list_wrapper">
                <ul class="list_group">
                    <li class="list_group_item">
                        <div class="bno">글번호</div>
                        <!-- <div class="topic">말머리</div> -->
                        <div class="title" id="titleHeader">제목</div>                        
                        <div class="nickname">작성자</div>
                        <div class="boarddate">작성시간</div>
                        <div class="replys">댓글수</div>
                        <div class="hit">조회수</div>
                    </li>
                    
                    <c:if test="${list.size() != 0}">
	                    <c:forEach var="dto" items="${list }">
	                    	<li class="list_group_item">
	                    		<div class="bno"><c:out value="${dto.bno}" /></div>
		                        <%-- <div class="topic"><c:out value="${dto.topic}" /></div> --%>
		                        <div class="title"><a id="titleA" href="/notice/${dto.bno }?pg=${paging.page}&range=${paging.range}"><c:out value="${dto.title}" /></a></div>                        
		                        <div class="nickname"><c:out value="${dto.nickname}" /></div>
		                        <div class="boarddate">
		                        	<fmt:formatDate var="nowdate" pattern="yyyy-MM-dd" value="${now }"/>
		                        	<fmt:formatDate var="boarddate" pattern="yyyy-MM-dd" value="${dto.boarddate }"/>
		                        	<fmt:formatDate var="boardtime" pattern="HH:mm:ss" value="${dto.boarddate }"/>
		                        	<c:choose>
		                        		<c:when test="${nowdate eq boarddate }">${boardtime }</c:when>
		                        		<c:otherwise>${boarddate }</c:otherwise>
		                        	</c:choose>
		                        </div>
		                        <div class="replys"><c:out value="${dto.replys }"></c:out></div>	                        
		                        <div class="hit"><c:out value="${dto.hit}" /></div>
	                    	</li>
	                    </c:forEach>
                    </c:if>
                    <c:if test="${list.size() == 0}">
                    	<div id="emptyText" style="margin-top:50px;margin-bottom:50px;text-align:center;font-size:13pt;font-weight:550;">결과값이 없습니다.</div>
					</c:if>
                </ul>
            </div>
            
            <!-- 글 생성 버튼 -->
            <sec:authorize access="hasRole('ROLE_ADMIN')">
				<button type="button" id="boardWriteBtn" name="boardWriteBtn">글생성</button>
			</sec:authorize>
			<!-- 글 생성 버튼 -->
            
            <!-- pagination{s} -->
			<div id="paginationBox">
				
				<ul class="pagination">
					<c:if test="${paging.first}">
						<li class="page-item"><a class="page-link" href="#" onClick="location.href='/notice?pg=1&range=1&searchType=${search.searchType }&keyword=${search.keyword }'">《</a></li>
					</c:if>
					<c:if test="${paging.prev}">
						<li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${paging.page}', '${paging.range}', '${paging.rangeSize}', '${search.searchType }', '${search.keyword }')">〈</a></li>
					</c:if>
					<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="idx">
						<li class="page-item"><a class="page-link-${idx }" href="#" onClick="fn_pagination('${idx}', '${paging.range}', '${paging.rangeSize}', '${search.searchType }', '${search.keyword }')"> ${idx} </a></li>
						<input type="hidden" id="hidden-page" value="${paging.page }">
					</c:forEach>
					<c:if test="${paging.next}">
						<li class="page-item"><a class="page-link" href="#" onClick="fn_next('${paging.range}', '${paging.range}', '${paging.rangeSize}', '${search.searchType }', '${search.keyword }')" >〉</a></li>
					</c:if>
					<c:if test="${paging.last}">
						<c:if test="${list.size() != 0}">
							<li class="page-item"><a class="page-link" href="#" onClick="fn_last('${paging.pageCnt}', '${paging.rangeSize}', '${search.searchType }', '${search.keyword }')" >》</a></li>
						</c:if>
					</c:if>
				</ul>
			</div>
			<!-- pagination{e} -->
			
			<!-- search{s} -->
			<div id="searchDiv">
				<select name="searchType" id="searchType">
					<option value="title">제목</option>
					<option value="nickname">작성자</option>
				</select>
				<input type="text" name="keyword" id="keyword" >
				<button name="btnSearch" id="btnSearch">검색</button>
			</div>
			<!-- search{e} -->
			
        </div>
    </div>
	<c:url var="freeBoardURL" value="/freeBoard"></c:url>

	<script type="text/javascript">
		// 페이지 로딩시
		window.onload=function(){
			if("${search.searchType }"=="title" || "${search.searchType }"=="nickname"){
				document.getElementById("searchType").value = "${search.searchType }";
				document.getElementById("keyword").value = "${search.keyword }";
			}
		}
		
		// 페이징처리
		// 이전 버튼 이벤트
		function fn_prev(page, range, rangeSize, searchType, keyword) {
			var page = ((range - 1) * rangeSize) ;
			var range = range - 1;
			var url = "${pageContext.request.contextPath}/notice";
			url = url + "?pg=" + page;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;
			location.href = url;
		}
		
		// 페이지 번호 클릭
		function fn_pagination(page, range, rangeSize, searchType, keyword) {
			var url = "${pageContext.request.contextPath}/notice";
			url = url + "?pg=" + page;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;
			location.href = url;	
		}
		
		// 다음 버튼 이벤트
		function fn_next(page, range, rangeSize, searchType, keyword) {
			var page = parseInt((range * rangeSize)) + 1;
			var range = parseInt(range) + 1;
			var url = "${pageContext.request.contextPath}/notice";
			url = url + "?pg=" + page;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;
			location.href = url;
		}
		
		// 맨끝 버튼 이벤트
		function fn_last(pageCnt, rangeSize, searchType, keyword) {
			var url = "${pageContext.request.contextPath}/notice";
			var range = Math.ceil(pageCnt/rangeSize);
			url = url + "?pg=" + pageCnt;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;
			location.href = url;
		}
		
		// 검색 버튼
		$(document).on('click', '#btnSearch', function(e){

			e.preventDefault();
	
			var url = "${notice}";
	
			url = url + "?searchType=" + $('#searchType').val();
	
			url = url + "&keyword=" + $('#keyword').val();
	
			location.href = url;
	
			console.log(url);
	
		});

		// 글생성 버튼
		$(document).on('click', '#boardWriteBtn', function(){
			location.href = "/notice/noticeWrite";
		});

		// 현재 페이지 음영처리
		$('.page-link-'+$('#hidden-page').val()).css('background','#0065a5').css('color','white');

	</script>