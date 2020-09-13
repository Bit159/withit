<%@ page language="java" contentType="text/html;charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta id="_csrf" name="_csrf" content="${_csrf.token}">
	<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}">
    <title>Document</title>
    <link rel="stylesheet" href="../resources/css/card.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.11.0/css/all.min.css"/>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />
</head>
<body>
	<div id="body-wrapper">
	<jsp:include page="../template/header.jsp"></jsp:include>
    <div id="container">
        <div id="selectBox">
        	<h1>지역 선택</h1>
        	<div class="selectLocation">
        		<ul id="select-si">
        			<li><a href="#">서울</a></li>
        			<li><a href="#">경기</a></li>
        			<li><a href="#">인천</a></li>
        			<li><a href="#">부산</a></li>
        			<li><a href="#">대구</a></li>
        			<li><a href="#">광주</a></li>
        			<li><a href="#">대전</a></li>
        			<li><a href="#">울산</a></li>
        			<li><a href="#">세종</a></li>
        			<li><a href="#">강원</a></li>
        			<li><a href="#">경남</a></li>
        			<li><a href="#">전남</a></li>
        			<li><a href="#">전북</a></li>
        			<li><a href="#">경북</a></li>
        			<li><a href="#">충남</a></li>
        			<li><a href="#">충북</a></li>
        			<li><a href="#">제주</a></li>
        		</ul>
	        	<ul id="select-gu">
	        		<li id="selectAll"><a>전체선택</a></li>
	        	</ul>
	        	<div id="selected-location">
	        	선택한 지역:
	        	</div>
        	</div>
        	<div class="selectTopic">
        		<h1>주제 선택</h1>
        		<div id="selectTopic">
        			<select id="sel">
        				<option value="" selected>전체</option>
        				<option value="Java">Java</option>
        				<option value="JavaScript">JavaScript</option>
        				<option value="Python">Python</option>
        				<option value="Algorithm">Algorithm</option>
        				<option value="C">C</option>
        				<option value="C++">C++</option>
        				<option value="C#">C#</option>
        				<option value="React">React</option>
        				<option value="Vue">Vue</option>
        				<option value="Spring">Spring</option>
        				<option value="SpringBoot">SpringBoot</option>
        				<option value="SQL">SQL</option>
        				<option value="Android">Android</option>
        				<option value="iOS">iOS</option>
        				<option value="Swift">Swift</option>
        				<option value="FrontEnd">FrontEnd</option>
        				<option value="BackEnd">BackEnd</option>
        				<option value="모각코">모각코</option>
        			</select>
        		</div>
        	</div>
        	<div id="searchCard">
        		<input type="button" value="검색" id="searchCardBtn">
        		<input type="button" value="그룹 만들기" id="regist" onclick="location.href='/synergy-kh/member/createGroup'">
        	</div>
        </div>
       	<form id="listForm">
        <div class="cardboard">
	        <c:if test="${list ne null}">
	        <c:forEach var="dto" items="${list}">
	           	 <div class="card">
	                <!-- 카드 헤더 -->
	                <div class="card-header">
	                    <div class="card-header-content">
	                    	<input type=hidden name="seq" id="seq" value="${dto.seq}">
	                        <c:set var="topic" value="${dto.topic }"/>
	                        <c:choose>
	                        <c:when test="${topic eq 'Java'}">
	                        <i class="fab fa-java fa-2x" style="color:orange;"></i><span id="topicIcon">&nbsp;Java</span>
	                        </c:when>
	                        <c:when test="${topic eq 'JavaScript'}">
	                        <i class="fab fa-js-square fa-2x" style="color:#EBEB1D;"></i><span id="topicIcon">&nbsp;JavaScript</span>
	                        </c:when>
	                       	<c:when test="${topic eq 'Python'}">
	                        <i class="fab fa-python fa-2x" style="color:navy;"></i><span id="topicIcon">&nbsp;Python</span>
	                        </c:when>
	                       	<c:when test="${topic eq 'React'}">
	                        <i class="fab fa-react fa-2x" style="color:blue;"></i><span id="topicIcon">&nbsp;React</span>
	                        </c:when>
	                       	<c:when test="${topic eq 'Vue'}">
	                        <i class="fab fa-vuejs fa-2x" style="color:green;"></i><span id="topicIcon">&nbsp;Vue</span>
	                        </c:when>
	                       	<c:when test="${topic eq 'Android'}">
	                        <i class="fab fa-android fa-2x" style="color:green;"></i><span id="topicIcon">&nbsp;Android</span>
	                        </c:when>
	                       	<c:when test="${topic eq 'iOS'}">
	                        <i class="fab fa-apple fa-2x" style="color:black;"></i><span id="topicIcon">&nbsp;iOS</span>
	                        </c:when>
	                       	<c:when test="${topic eq 'Swift'}">
	                        <i class="fab fa-swift fa-2x" style="color:Orange;"></i><span id="topicIcon">&nbsp;Swift</span>
	                        </c:when>
	                       	<c:when test="${topic eq '모각코'}">
	                        <i class="fas fa-laptop-code fa-2x" style="color:silver;"></i><span id="topicIcon" style="width:100px;font-size: 15pt">&nbsp;모각코</span>
	                        </c:when>
	                        </c:choose>
	                        <input type="hidden" id="hidden-open" value="${dto.open }">
	                        <c:if test="${dto.open eq 0}">
	                        <div id="card-header-text"> 모집중 </div>
	                        </c:if>
	                        <c:if test="${dto.open eq 1}">
	                        <div id="card-header-text"> 마감 </div>
	                        </c:if>
	                    </div>
	                </div>
	                <!-- 카드 바디 -->
	                <div class="card-body">
	                    <div class="card-body-content">
	                        <a href="/synergy-kh/member/cardBoardView?seq=${dto.seq}" id="card-body-title">${dto.title }</a>
	                        <div class="card-body-info">
	                        	<div class="card-body-info-nickname">
		                        	<span>작성자</span>&nbsp;&nbsp;
			                        <p id="card-body-nickname"> ${dto.nickname} </p>
		                    	</div>
		                    	<div class="card-body-info-location">
		                    		<span>지역</span>&nbsp;&nbsp;
		                        	<p id="card-body-location"> ${dto.location }</p>
								</div>
<%-- 		                        <p id="card-body-people">인원 ${dto.people}명</p> --%>
	                   		</div> 
	                    </div>
	                </div>
	                <!-- 카드 푸터 -->
	                <div class="card-footer">
	                <fmt:formatDate var="regDate" pattern="yyyy-MM-dd" value="${dto.registDate }"/>
	                	<span>${regDate}</span>
	                	<i class="far fa-user" > ${dto.people }</i> &nbsp;&nbsp;
	                	<i class="far fa-comment-dots" > ${dto.replys}</i>
	                </div>
            	</div>
	        </c:forEach>
            </c:if>
            <c:if test="${list eq null }">
            <div><h1>없다아아아ㅏ아아</h1></div>
	        </c:if>
        </div>
        </form>
        <!-- pagination{s} -->
		<div id="paginationBox">
			<ul class="pagination">
				<c:if test="${paging.first}">
					<li class="page-item"><a class="page-link" href="#" onClick="location.href='/synergy-kh/member/cardBoardList?pg=1&range=1&location=${paging.location}&topic=${paging.topic}'">《</a></li>
				</c:if>
				<c:if test="${paging.prev}">
					<li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${paging.page}', '${paging.range}', '${paging.rangeSize}','${paging.location}','${paging.topic }')">〈</a></li>
				</c:if>
				<c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="idx">
					<li class="page-item"><a class="page-link-${idx }" href="#" onClick="fn_pagination('${idx}', '${paging.range}', '${paging.rangeSize}','${paging.location}','${paging.topic }')"> ${idx} </a></li>
					<input type="hidden" id="hidden-page" value="${paging.page }">
				</c:forEach>
				<c:if test="${paging.next}">
					<li class="page-item"><a class="page-link" href="#" onClick="fn_next('${paging.range}', '${paging.range}', '${paging.rangeSize}','${paging.location}','${paging.topic }')" >〉</a></li>
				</c:if>
				<c:if test="${paging.last}">
					<li class="page-item"><a class="page-link" href="#" onClick="fn_last('${paging.pageCnt}', '${paging.rangeSize}','${paging.location}','${paging.topic }')" >》</a></li>
				</c:if>
			</ul>
		</div>
		<!-- pagination{e} -->
    </div>
    <jsp:include page="../template/footer.jsp"></jsp:include>
    </div>
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
	<script type="text/javascript">
	let aIndex=0;
	let guIndex=0;
	let si='';
	let gu='';
	let sigu='';
	let count=0;
	let locations = [];
	let pageA= 0;
	$('#sel').select2();
	$(document).ready(function(){
		$.ajax({
			type:'get',
			url:'/synergy-kh/member/getLocation',
			dataType:'json',
			success:function(data){
				/* 상위지역 선택 */
				$('#select-si').on('click','li',function(){
					aIndex = $(this).index();
					si = $('#select-si li:nth-child('+(aIndex+1)+')').children('a').text();
					$('#select-gu li:gt(0)').remove();
					$.each(data[aIndex], function(i,item){
						$('#select-gu').append("<li><a>"+data[aIndex][i]+"</li></a>")
					});
					var color = $(this).css('background-color');
					if(color!='rgb(50, 190, 120, 0.7)'){
						$('#select-si > li').css('background-color','white');
						$('#select-si > li > a').css('color','black');
						$(this).css('background-color','rgb(50, 190, 120, 0.7)');
						$(this).children().css('color','white').css('font-weight','550');
					}else {
						$(this).css('background-color','white');
					}
				});
				$('#select-si > li:nth-child(1)').trigger('click');
			},
			error:function(){
				console.log('error');
			}
		});
		$('.page-link-'+$('#hidden-page').val()).css('background','green').css('color','white');
		/* 마감 모집글 음영처리 */
		if($('#hidden-open').val()==1){
			$('.card').css('background','lightgray');
		}
	});		
	/* 하위지역 선택 */	
	$('#select-gu').on('click','li',function(){
		guIndex=$(this).index()+1;
		gu =  $('#select-gu li:nth-child('+guIndex+')').children('a').text();
		sigu = si+' '+gu;
		if($('#selected-location > span').text().includes(sigu)){
			return;
		}
		if($('#selected-location > span').length <= 2 ){
			count=count+1;
			$('#selected-location').append("<span id=close"+count+">"+sigu+"<button type=button>x</button></span>");
			locations.push(sigu);
			/* 추가된 지역 삭제 */
			$('#selected-location > span#close'+count).on('click','button',function(){
				$(this).parent().remove();
				let text = $(this).parent().text(); //해당 텍스트값에서
				let sliceChar = text.slice(0,-1); //마지막 글자인 x를 빼기
				locations.splice(locations.indexOf(sliceChar),1); //그 인덱스값을 제거
			});
		}else {
			Swal.fire(
			  '최대 3개까지 선택 가능합니다',
			  '',
			  'warning'
			)
		}
	});
	$('#searchCardBtn').click(function(){
		$.ajax({
			type:'get',
			url:'/synergy-kh/member/cardBoardList?pg=1&range=1',
			data:{'location':locations,'topic':$('#sel').val()},
// 			dataType:'json',
// 			traditional:true,
			success:function(data){
				location.href='/synergy-kh/member/cardBoardList?pg=1&range=1&location='+locations+'&topic='+$('#sel').val()
			},
			error:function(){
				console.log('에러러러럴')
			}
		});
	});
	//이전 버튼 이벤트
	function fn_prev(page, range, rangeSize, loc, topic) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "${pageContext.request.contextPath}/member/cardBoardList";
		url = url + "?pg=" + page;
		url = url + "&range=" + range;
		url = url + "&location=" + loc;
		url = url + "&topic=" +topic;
		location.href = encodeURI(url);
	}
    //페이지 번호 클릭
	function fn_pagination(page, range, rangeSize, loc, topic) {
		var url = "${pageContext.request.contextPath}/member/cardBoardList";
		url = url + "?pg=" + page;
		url = url + "&range=" + range;
		url = url + "&location=" + loc;
		url = url + "&topic=" + topic;
		location.href = encodeURI(url);	
	}
	//다음 버튼 이벤트
	function fn_next(page, range, rangeSize,loc,topic) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "${pageContext.request.contextPath}/member/cardBoardList";
		url = url + "?pg=" + page;
		url = url + "&range=" + range;
		url = url + "&location=" + loc;
		url = url + "&topic=" +topic;
		location.href = encodeURI(url);
	}
	//맨끝 버튼 이벤트
	function fn_last(pageCnt, rangeSize, loc, topic) {
		var url = "${pageContext.request.contextPath}/member/cardBoardList";
		var range = Math.ceil(pageCnt/rangeSize);
		url = url + "?pg=" + pageCnt;
		url = url + "&range=" + range;
		url = url + "&location=" +loc;
		url = url + "&topic=" +topic;
		location.href = encodeURI(url);
	}
	</script>
</body>
</html>