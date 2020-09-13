<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>크롤게시판</title>
<link rel="stylesheet" href="/resources/sj/css/boardList.css">
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="/resources/sj/js/welcome.js" defer></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" />
	<div class="body_wrapper">
        <div class="body_container">
            <h1>자유게시판</h1>
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
		                        <div class="title"><a id="titleA" href="/synergy/bboard/${dto.bno }?pg=${paging.page}&range=${paging.range}"><c:out value="${dto.title}" /></a></div>                        
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
            
            <!-- pagination{s} -->
			<div id="paginationBox">
				<ul class="pagination">
					<c:if test="${paging.first}">
						<li class="page-item"><a class="page-link" href="#" onClick="location.href='/synergy/bboard/boardList2?pg=1&range=1&searchType=${search.searchType }&keyword=${search.keyword }'">《</a></li>
					</c:if>
					<c:if test="${paging.prev}">
						<li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${paging.page}', '${paging.range}', '${paging.rangeSize}', '${search.searchType }', '${search.keyword }')">〈</a></li>
					</c:if>
					<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="idx">
						<li class="page-item"><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${paging.range}', '${paging.rangeSize}', '${search.searchType }', '${search.keyword }')"> ${idx} </a></li>
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
			<button type="button" id="boardWriteBtn" name="boardWriteBtn">글생성</button>
			<div class="form-group row justify-content-center">
				<div class="w100" style="padding-right:10px">
					<select class="form-control form-control-sm" name="searchType" id="searchType">
						<option value="title">제목</option>
						<option value="nickname">작성자</option>
					</select>
				</div>
				<div class="w300" style="padding-right:10px">
					<input type="text" class="form-control form-control-sm" name="keyword" id="keyword" >
				</div>
				<div>
					<button class="btn btn-sm btn-primary" name="btnSearch" id="btnSearch">검색</button>
				</div>
			</div>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" />
	
	<c:url var="boardList2URL" value="/synergy/bboard/boardList2"></c:url>

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
			var url = "${pageContext.request.contextPath}/bboard/boardList2";
			url = url + "?pg=" + page;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;
			location.href = url;
		}
		
		// 페이지 번호 클릭
		function fn_pagination(page, range, rangeSize, searchType, keyword) {
			var url = "${pageContext.request.contextPath}/bboard/boardList2";
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
			var url = "${pageContext.request.contextPath}/bboard/boardList2";
			url = url + "?pg=" + page;
			url = url + "&range=" + range;
			url = url + "&searchType=" + $('#searchType').val();
			url = url + "&keyword=" + keyword;
			location.href = url;
		}
		
		// 맨끝 버튼 이벤트
		function fn_last(pageCnt, rangeSize, searchType, keyword) {
			var url = "${pageContext.request.contextPath}/bboard/boardList2";
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
	
			var url = "${boardList2}";
	
			url = url + "?searchType=" + $('#searchType').val();
	
			url = url + "&keyword=" + $('#keyword').val();
	
			location.href = url;
	
			console.log(url);
	
		});

		// 글생성 버튼
		$(document).on('click', '#boardWriteBtn', function(){
			location.href = "/synergy/board/boardWriteForm";
		});


	</script>
</body>
</html>