<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
	<link rel="stylesheet" href="/resources/hj/css/adminFreeViewForm.css">
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
        <div class="boardwrapper">
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
                           
                            
                            	<button type="button" id="deleteBoardBtn" style="width: 70px" data-bno="${bBoardDTO.bno }" data-page="${paging.page }" data-range="${paging.range }">삭제</button>
                           
                        </div>
                        <div class="downside_right">
                            <div class="view_replys">댓글수 : ${bBoardDTO.replys }</div>
                            <div class="view_hit">조회수 : ${bBoardDTO.hit }</div>
                        </div>               
                    </div>
                
           		</div>
             <div class="board_body">
                    <div class="content" style="white-space:pre;"><pre style="white-space: pre-line;">${bBoardDTO.content }</pre></div>
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
					                                    <%-- <textarea name="reply_modify_text1" class="reply_modify_text1" readonly="readonly">${replydto.reply }</textarea> --%>
					                                    <div class="reply_reply">
					                                    	${replydto.reply }
					                                    </div>
					                                    <div class="reply_button">
					                                    
							                               <button type="button" class="deleteBtn" data-rno="${ replydto.rno }">삭제</button>
						                                
						                                </div>
					                                </div>
					                            </li>
					                            
				                            </div>
		                            	</c:if>
	                            </c:forEach>
	                            
	                        </ul> 
	                        
	                        <sec:authorize access="isAuthenticated()">
			                    <br><br>
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
							</sec:authorize> 
						
                    </div>                    
                </div>
    		</div>
         	</div>
        </section>
        <footer class="main_footer"></footer>
    </div>
    
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<!-- <script src="/resources/hj/js/adminFreeViewForm.js" defer></script> -->
<script type="text/javascript">
$(document).ready(function(){
	
	// 보드 삭제
	$(document).on("click","#deleteBoardBtn", function(){
		var csrfHeaderName = document.getElementById('csrf_header').content;
		var csrfTokenValue = document.getElementById('csrf').content;	
		var $btnObj = $(this);
		var page = $(this).data('page');
		var range = $(this).data('range');
		let bno = $(this).data('bno'); 
		
		
		var param = "bno="+bno;
		
		Swal.fire({
			title:`게시글 삭제`,
			text:`정말 삭제하시겠습니까?`,
			icon:`question`,
			confirmButtonText:`확인`,
			showCancelButton:true,
			cancelButtonText:`취소`,
		}).then((res)=>{
			if(res.isConfirmed){
				console.log('승인, 게시글 삭제처리가 들어올 곳')
				deleteBoard();
			}else {
				console.log('비승인');
				Swal.fire('취소', '게시글 삭제가 취소되었습니다', 'error');
			}
		});
		
		function deleteBoard(){
			$.ajax({
				type: 'post',
				url: '/all/boardDelete',
				data: param,
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    	},
				success: function(data){
					Swal.fire({
							  title: '게시글 삭제 완료',
							  text: '게시글이 삭제 되었습니다.',
							  icon: 'success'
					}).then((res)=>{
						location.href='/adminFreeView?pg='+page+'&range='+range;
		    		});
					
				},
				error: function(err){
					console.log(err);
				}
			});
		}
		
		
	});
	
	
	
	
	// 댓글 삭제
	$(document).on("click",".deleteBtn", function(){
		var $btnObj = $(this);
		let rno = $(this).data('rno'); // data-rno
		var bno = document.querySelector('div.view_bno').innerText;
		
		var csrfHeaderName = document.getElementById('csrf_header').content;
		var csrfTokenValue = document.getElementById('csrf').content;	
		
		var param = "rno="+rno+"&bno="+bno;
		
		
		Swal.fire({
			title:`댓글 삭제`,
			text:`정말 삭제하시겠습니까?`,
			icon:`question`,
			confirmButtonText:`확인`,
			showCancelButton:true,
			cancelButtonText:`취소`,
		}).then((res)=>{
			if(res.isConfirmed){
				console.log('승인, 댓글삭제처리가 들어올 곳')
				deleteReply();
			}else {
				console.log('비승인');
				Swal.fire('취소', '댓글 삭제가 취소되었습니다', 'error');
			}
		});
		
		function deleteReply(){
			$.ajax({
				type: 'post',
				url: '/all/replyDelete',
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    	},
				data: param,
				success: function(data){
					$btnObj.parent().parent().remove();
					
					let target = document.querySelector('.reply_header');
					let newnum = target.innerText.substring(6);
					newnum--;
					console.log(newnum);
					target.innerHTML = '댓글수 : ${newnum1}';
					
					let target1 = document.querySelector('.view_replys');
					let newnum1 = target1.innerText.substring(6);
					newnum1--;
					target1.innerText = '댓글수 : ${newnum1}';
					
					Swal.fire({
							  title: '댓글 삭제 완료',
							  text: '댓글이 삭제되었습니다.',
							  icon: 'success'
					})
					.then(()=>location.reload(true));
					
					
					
				},
				error: function(err){
					console.log(err);
					Swal.fire({
							  title: '댓글 삭제 실패',
							  text: '댓글이 삭제 되지 않았습니다',
							  icon: 'error'
					});
					
				}
			});
		}
		
	});
	
	
	
	
	// 댓글 쓰기
	$(document).on("click","#reply_writer_btn",function(){
		var $btnObj = $(this);
		var page = $(this).data('page');
		var range = $(this).data('range');
		var reply = $("#reply_writer_text").val();
		var bno = document.querySelector('div.view_bno').innerText;
		var param = "reply="+reply+"&bno="+bno;
		
		var csrfHeaderName = document.getElementById('csrf_header').content;
		var csrfTokenValue = document.getElementById('csrf').content;	
		
		if(reply != ""){
			$.ajax({
				type: "post",
				url: "/all/boardReply",
				beforeSend: function(xhr){
					xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    	},
				data: param, 
				dataType: 'json',
				success: function(data){
					console.log(data);
					Swal.fire({
						  title: '댓글 등록 완료',
						  text: '댓글이 등록되었습니다.',
						  icon: 'success',
					}).then((res)=>{
						location.href='/adminFreeView/'+bno+'?pg='+page+'&range='+range;									
					});
				},
				error: function(err){
					console.log(err);
				}
			});
		}else{
			Swal.fire({
				  title: '댓글 내용이 없음',
				  text: '댓글 내용을 입력하세요',
				  icon: 'warning'
			});
		}
		
	});
	
	
	
	
	
	
});



</script>

</body>
</html>