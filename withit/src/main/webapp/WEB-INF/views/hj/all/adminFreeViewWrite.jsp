<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>    
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
	<link rel="stylesheet" href="/resources/hj/css/adminFreeViewWrite.css">
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
                    <li class="aside_menu_list_3">
                    	<a href="/admin" class="aside_menu_list_3_a">
                        <img src="/resources/hj/image/task2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Management
                        <img src="/resources/hj/image/right2.png" style="width: 13px; height: 13px; padding-left: 49px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_6">
                    	<a href="/adminFreeView" class="aside_menu_list_6_a">
                        <img src="/resources/hj/image/freeBoard.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Board Management
                        <img src="/resources/hj/image/right2.png" style="width: 13px; height: 13px; padding-left: 2px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_1">
                    	<a href="/adminMemberStats" class="aside_menu_list_1_a">
                        <img src="/resources/hj/image/chartIcon3.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Statistics
                        <img src="/resources/hj/image/right2.png" style="width: 13px; height: 13px; padding-left: 80px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_4">
                    	<a href="/adminLocationMap" class="aside_menu_list_4_a">
                        <img src="/resources/hj/image/map2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Location Map
                        <img src="/resources/hj/image/right2.png" style="width: 13px; height: 13px; padding-left: 45px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_5">
                    	<a href="/" class="aside_menu_list_5_a">
                        <img src="/resources/hj/image/home.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Main Menu
                        <img src="/resources/hj/image/right2.png" style="width: 13px; height: 13px; padding-left: 61px;"/>
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
                <li><a class="sidebar_menu_button"><img src="/resources/hj/image/chartIcon.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Member
                    <img src="/resources/hj/image/right.png" style="width: 13px; height: 13px; margin-left: 30px;"/>
                </a></li>
                <li><a class="sidebar_menu_button"><img src="/resources/hj/image/chartIcon2.png" style="width: 13px; height: 13px;"/>Programming
                    <img src="/resources/hj/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>   
                <li><a class="sidebar_menu_button"><img src="/resources/hj/image/task.png" style="width: 13px; height: 13px;"/>Management
                    <img src="/resources/hj/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>
                <li><a class="sidebar_menu_button"><img src="/resources/hj/image/map.png" style="width: 13px; height: 13px;"/>Location Map
                    <img src="/resources/hj/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>
            </ul>
        </div>
        
        <header class="header">
            <div class="header_title"><img src="/resources/hj/image/freeBoard2.png" style="width: 40px; height: 35px; margin-right:20px;"/>Free Board Management</div>
        </header>
       
        <section class="section">
        	
        	
        	<div id="boardWriteWrapper">
		        <div id="boardWriteContainer">
					<h1>게시글 생성</h1>
		            <div id="boardWriteTitle">
		                <label for="" id="boardWriteTitleLabel"></label>
		                <div id="boardWriteTitleDiv">
		                    <input type="text" id="boardWriteTitleText" placeholder="제목을 입력하세요.">
		                </div>
		            </div>
		            <div id="boardWriteContent">
		                <label for="" id="boardWriteContentLabel"></label>
		                <div id="boardWriteContentDiv">
		                    <textarea name="boardWriteContentText" id="boardWriteContentText" placeholder="내용을 입력하세요."></textarea>
		                </div>
		            </div>
		            <div id="boardWriteButton">
		                <button id="boardWriteBtn">글 작성</button>
		                <button id="boardListBtn">글 목록</button>
		            </div>
		        </div>
   			 </div>
            
        	
        </section>
        <footer class="main_footer"></footer>
    </div>
   
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script>

// 글 작성 버튼
$(document).on('click', '#boardWriteBtn', function(){
	var title = $("#boardWriteTitleText").val();
	var content = $("#boardWriteContentText").val();
	var param = "title="+title+"&content="+content;
	
	var csrfHeaderName = document.getElementById('csrf_header').content;
	var csrfTokenValue = document.getElementById('csrf').content;
	
	if(title != "" & content != ""){
		$.ajax({
			type : "post",
			url : "/all/adminBoardWrite",
			beforeSend:function(xhr){
				xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
	    	data: param,
	    	success: function(){
	    		Swal.fire(
						  '게시글 등록 완료',
						  '게시글이 등록되었습니다.',
						  'success'
						).then((res)=>{
							location.href='/adminFreeView';
			    		});;
	    		
	    	},
	    	error: function(err){
				console.log(err);
			}
		});
	}else{
		Swal.fire(
				  '제목 또는 내용이 없음',
				  '제목 또는 내용을 입력하세요',
				  'warning'
				);
	}
});

// 글목록 버튼
$(document).on('click', '#boardListBtn', function(){
	location.href='/adminFreeView';
});

</script>
</body>
</html>