<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" th:content="${_csrf.headerName}"/>
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/adminBoard.css">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
</head>
<body>
    
    <!-- 가운데 main 내용 -->
	
    <div id="wrap">
        
        <aside class="aside">
            <div class="aside_menu">
                <ul class="aside_menu_list">
                    <li class="aside_menu_top">Admin Menu</li>
                    <li class="aside_menu_list_1">
                    	<a href="/synergy2/all/adminStats" class="aside_menu_list_1_a">
                        <img src="../resources/image/chartIcon3.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Statistics
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 80px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_2">
                    	<a href="/synergy2/all/programmingStats" class="aside_menu_list_2_a">
                        <img src="../resources/image/chartIcon4.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Programming
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 50px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_3">
                    	<a href="/synergy2/all/adminBoard" class="aside_menu_list_3_a">
                        <img src="../resources/image/task2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Management
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 45px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_4">
                    	<a href="/synergy2/all/admin_map" class="aside_menu_list_4_a">
                        <img src="../resources/image/map2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Location Map
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 45px;"/>
                    	</a>
                    </li>
                </ul>
            </div>
        </aside>
        
        
        <input type="checkbox" id="menuicon">
        <label for="menuicon">
            <span></span>
            <span></span>
            <span></span>
        </label>
        <div class="sidebar">
            <ul>
                <li class="sidebar_menu">Admin Menu</li>
                <li><a class="sidebar_menu_button"><img src="../resources/image/chartIcon.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Member
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; margin-left: 30px;"/>
                </a></li>
                <li><a class="sidebar_menu_button"><img src="../resources/image/chartIcon2.png" style="width: 13px; height: 13px;"/>Programming
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>   
                <li><a class="sidebar_menu_button"><img src="../resources/image/task.png" style="width: 13px; height: 13px;"/>Management
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>
                <li><a class="sidebar_menu_button"><img src="../resources/image/map.png" style="width: 13px; height: 13px;"/>Location Map
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>
            </ul>
        </div>
        
        <header class="header">
            <div class="header_title"><img src="../resources/image/task.png" style="width: 40px; height: 35px; margin-right:20px;"/>Member Management</div>
        </header>
       
        <section class="section">
        
        	<div class="searchDiv">
	           
		            <select name="searchType" id="searchType">
		            	<option value="username">아이디</option>
		            	<option value="nickname">닉네임</option>
		            </select>
		            <input type="text" name="keyword" id="keyword">
		            <button name="btnSearch" id="btnSearch">검색</button>
	        	
	        	
        	</div>
        
            <div class="list_wrap">
                <ul class="list">
                    <li class="list_group">
                        <div class="nickname">닉네임</div>
                        <div class="username">아이디</div>
                        <div class="created">가입일</div>
                        <div class="button">회원 탈퇴</div>    
                    </li>
                    <from name="memberDeleteForm" id="memberDeleteForm" method="post" action="">
                    <c:forEach var="memberDTO" items="${list}" varStatus="status">
                    <li class="list_group_main">
                        <div class="nickname" name="nickname"><c:out value="${memberDTO.nickname }"></c:out></div>
                        <div class="username" id="username${status.count}" name="username"><c:out value="${memberDTO.username }"></c:out></div>
                        <div class="created" name="created"><fmt:formatDate value="${memberDTO.created }" pattern="yyyy-MM-dd"/></div>
                        <input type="hidden" id="username" name="username" value="${memberDTO.username}">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="button"><input type="image" src="../resources/image/basket.png" class="withdrawalBtn" id="withdrawalBtn"></div>  
                        
                    </li>
                    </c:forEach>
 					</from>
                </ul>
            </div>
           
         	<div class="paginationDiv">
        		<ul class="pagination"> 
        		
					<c:if test="${pagination.first}">
						<li class="page-item"><a class="page-link" href="#" onClick="location.href='/synergy2/all/adminBoard?page=1&range=1&searchType=${search.searchType }&keyword=${search.keyword }'">《</a></li>
					</c:if>
        		
        			<c:if test="${pagination.prev}">

						<li class="page-item"><a class="page-link" href="#" onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${search.searchType }', '${search.keyword }')">〈</a></li>

					</c:if>

					<c:forEach begin="${pagination.startPage}" end="${pagination.endPage}" var="idx">

						<li class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a class="page-link" href="#" onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}', '${search.searchType }', '${search.keyword }')"> ${idx} </a></li>

					</c:forEach>	

					<c:if test="${pagination.next}">

						<li class="page-item"><a class="page-link" href="#" onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${search.searchType }', '${search.keyword }')" >〉</a></li>

					</c:if>
					
					<c:if test="${pagination.last}">
						<li class="page-item"><a class="page-link" href="#" onClick="fn_last('${pagination.pageCnt}', '${pagination.rangeSize}','${search.searchType }', '${search.keyword }')" >》</a></li>
					</c:if>	
	
        		</ul>

    	    </div>	
        </section>
        <footer class="main_footer"></footer>
    </div>
    <c:url var="adminBoardUrl" value="/all/adminBoard"></c:url>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

//검색버튼 클릭 이벤트

$(document).on('click', '#btnSearch', function(e){
	e.preventDefault();
	var url = "${adminBoard}";

	url = url + "?searchType=" + $('#searchType').val();

	url = url + "&keyword=" + $('#keyword').val();

	location.href = encodeURI(url);

	console.log(url);

});

//이전 버튼 이벤트

function fn_prev(page, range, rangeSize, searchType, keyword) {

		var page = ((range - 2) * rangeSize) + 1;

		var range = range - 1;

		var url = "${pageContext.request.contextPath}/all/adminBoard";

		url = url + "?page=" + page;

		url = url + "&range=" + range;
		
		url = url + "&searchType=" + $('#searchType').val();
		
		url = url + "&keyword=" + keyword;
		
		location.href = url;

	}



  //페이지 번호 클릭

	function fn_pagination(page, range, rangeSize, searchType, keyword) {

		var url = "${pageContext.request.contextPath}/all/adminBoard";

		url = url + "?page=" + page;

		url = url + "&range=" + range;
		
		url = url + "&searchType=" + searchType;
		
		url = url + "&keyword=" + keyword;

		location.href = url;	

	}


	//다음 버튼 이벤트

	function fn_next(page, range, rangeSize, searchType, keyword) {

		var page = parseInt((range * rangeSize)) + 1;

		var range = parseInt(range) + 1;

		var url = "${pageContext.request.contextPath}/all/adminBoard";

		url = url + "?page=" + page;

		url = url + "&range=" + range;
		
		url = url + "&searchType=" + $('#searchType').val();
		
		url = url + "&keyword=" + keyword;


		location.href = url;

	}
	
	//맨끝 버튼 이벤트
	function fn_last(pageCnt, rangeSize, searchType, keyword) {
		
		var url = "${pageContext.request.contextPath}/all/adminBoard";
		var range = Math.ceil(pageCnt/rangeSize);
		url = url + "?page=" + pageCnt;
		url = url + "&range=" + range;
		url = url + "&searchType=" + searchType;
		url = url + "&keyword=" + keyword;
		location.href = url;
		
	}



</script>
<script type="text/javascript">


var csrfHeaderName = "${_csrf.headerName}";
var csrfTokenValue = document.getElementById('_csrf').content;


	
let a = document.querySelectorAll('input.withdrawalBtn');


for(let i = 0; i<a.length; i++){
	
	let username = a[i].parentElement.parentElement.children[1].innerText;
	
	console.log(username);
	
    a[i].addEventListener('click', ()=> {    
    
	//let result = confirm("정말 탈퇴 시키시겠습니까?");
	
	Swal.fire({
		
	  title: '회원 탈퇴',
	  text: "회원을 탈퇴 시키시겠습니까?",
	  icon: 'warning',
	  showCancelButton: true,
	  confirmButtonColor: '#3085d6',
	  cancelButtonColor: '#d33',
	  confirmButtonText: '탈퇴시키기',
	  cancelButtonText: '취 소'
	}).then((result) => {
	  if (result.value) {
	    
		  $.ajax({
				type: 'post',
				url: '/synergy2/all/memberDelete',
				data: {'username' : username},
				
				beforeSend:function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
				},
				success: function(data){
					
					a[i].parentElement.parentElement.remove();
					
					location.href = "/synergy2/all/adminBoard";
				},
				error: function(err){
					console.log(err);
				}
			
			});
		  
		  
		  
	  }
	})

	
	
    }
    
    )
}//회원 탈퇴



	    	
	
</script>
</body>
</html>