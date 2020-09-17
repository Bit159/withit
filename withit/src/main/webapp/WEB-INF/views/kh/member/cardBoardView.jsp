<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
<title>위드잇</title>
<link rel="stylesheet" href="/resources/kh/css/cardBoardView.css">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
<script type="text/javascript" src="/resources/kh/js/autolink.js"></script>
</head>
<body>
	<div class="body-wrapper">
		<jsp:include page="/WEB-INF/views/kh/template/header.jsp"></jsp:include>
		<div class="view-container">
			<div class="cardView">
				<div id="card-title">
					<div id="card-info">
						<h1 id="titleH1">${dto.title}</h1>
						<c:if test="${dto.open ne 1}">
							<c:if test="${isAuthor eq true }">
								<input type="button" id="modifyCard" value="수정" onclick="location.href='/modifyCard?seq=${dto.seq}'">
								<input type="button" id="closeCard" value="마감">
							</c:if>
						</c:if>
					</div>
					<fmt:formatDate var="registDate" pattern="yyyy-MM-dd HH:mm"
						value="${dto.registDate }" />
					<div class="card-info2">
						<span id="writer">작성자 ${dto.nickname}</span> <span id="registDate">등록일
							${registDate}</span>
					</div>
					<input type="hidden" id="boardSeq" value="${dto.seq}">
				</div>
				<div id="view-content">
<!-- 					<h1>모집내용</h1> -->
					<table id="viewTable">
						<tr>
							<th>지역</th>
							<td>${dto.location }</td>
						</tr>
						<tr>
							<th>주제</th>
							<td>${dto.topic }</td>
						</tr>
						<tr>
							<th>최대인원</th>
							<td>${dto.people }명</td>
						</tr>
					</table>
					<div id="card-content">
						<h1>상세내용</h1>
						<div>${dto.content}</div>
					</div>
				</div>
			</div>
			<div class="view-reply">
				<ul class="reply_group">
					<li id="reply_group_top">댓글 ${dto.replys }개</li>
					<c:forEach var="replydto" items="${replyList }">
						<c:if test="${not empty replydto }">
							<li class="reply_group_item">
								<div class="reply_group_div">
									<div class="reply_nickname">${replydto.nickname }</div>
									<fmt:formatDate var="regDate" pattern="yyyy-MM-dd HH:mm:ss"
										value="${replydto.regDate }" />
									<fmt:formatDate var="editDate" pattern="yyyy-MM-dd HH:mm:ss"
										value="${replydto.editDate }" />
									<div id="reply_regDate">${regDate}</div>
									<div id="reply_editDate">${editDate}수정</div>
									<div class="reply">${replydto.reply }</div>
									<c:if test="${replydto.username eq username }">
										<div class="reply_button">
											<button type="button" id="modifyReplyBtn"
												data-rseq="${ replydto.rseq }">수정</button>
											<button type="button" id="deleteReplyBtn"
												data-rseq="${ replydto.rseq }" data-seq="${replydto.seq }">삭제</button>
										</div>
									</c:if>
									<div class="reply_modify_wrapper">
										<div class="reply_modify">
											<!--                               <label class="reply_modify_label">댓글 수정</label> -->
											<div class="reply_modify_div">
												<textarea name="reply_modify_text" id="reply_modify_text"></textarea>
												<div class="reply_modify_button_div">
													<button id="reply_modify_button"
														data-rseq="${ replydto.rseq }">수정</button>
													<button id="reply_modify_cancel">취소</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</li>
						</c:if>
					</c:forEach>
				</ul>
				<c:if test="${dto.open ne 1 }">
					<div class="reply_write">
						<div class="reply_write_item">
							<textarea name="reply" id="reply" rows="3"></textarea>
							<div class="reply_write_button">
								<button type="button" id="reply_write_regist">등록</button>
							</div>
						</div>
					</div>
				</c:if>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/kh/template/footer.jsp"></jsp:include>
	</div>
	<script type="text/javascript"
		src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script type="text/javascript">
autolink($('.reply, #card-content pre'));
/* ===========댓글 등록================= */
$('#reply_write_regist').click(function(){
	if($('#reply').val()!=""){
		Swal.fire({
		    title: '등록하시겠습니까?',
		//  text: "You won't be able to revert this!",
		    icon: 'question',
		    showCancelButton: true,
		    confirmButtonColor: '#3085d6',
		    cancelButtonColor: '#d33',
		    confirmButtonText: '등록',
		    cancelButtonText: '취소',
		 	}).then((result) => {
			    if (result.value) {
					$.ajax({
						type:'get',
						url:'/writeReply',
						data:{'reply':$('#reply').val(),'seq':$('#boardSeq').val()},
						success:function(){
							location.reload();
						},
						error:function(){
							alert('다시 시도해 주세요')
						}
					});
			    }
		 	});
	}else {
		Swal.fire({
		    title: '내용을 입력해주세요',
		    icon: 'warning',
		 	})
	}
});
/* ==================댓글삭제========== */
$('.reply_button').on('click','#deleteReplyBtn',function(){
	let rseq = $(this).data('rseq')
	let seq = $(this).data('seq')
    Swal.fire({
    title: '삭제하시겠습니까?',
    icon: 'warning',
    showCancelButton: true,
    confirmButtonColor: '#3085d6',
    cancelButtonColor: '#d33',
    confirmButtonText: '삭제',
    cancelButtonText: '취소',
  }).then((result) => {
    if (result.value) {
      Swal.fire(
        '삭제 완료',
        '',
        'success',
        ).then(result => {
	        $.ajax({
	    		type:'get',
	    		url:'/deleteReply',
	    		data:{'rseq':rseq,'seq':seq},
	    		success:function(){
	    			location.reload();
	    		},
	    		error:function(){
	    		}
	    	})
	    	//ajax
        })
    }
})
});
/* ============댓글 수정============= */
$('.reply_button').on('click','#modifyReplyBtn',function(){
	$(this).parent().parent().children('.reply_modify_wrapper').css('display','block')
});
$('.reply_modify_button_div').on('click','#reply_modify_button',function(){
	let rseq = $(this).data('rseq');
	reply = $(this).parent().parent().children('textarea').val();
	Swal.fire({
	    title: '수정하시겠습니까?',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: '확인',
	    cancelButtonText: '취소',
	 	}).then((result) => {
		    if (result.value) {
				$.ajax({
					type:'get',
					url:'/modifyReply',
					data:{'rseq':rseq,'reply':reply},
					success:function(){
						location.reload();
					},
					error:function(){
					}
				});
		    }
	 	});
});
$('.reply_modify_button_div').on('click','#reply_modify_cancel',function(){
	$(this).parent().parent().parent().parent().css('display','none');
	$(this).parent().parent().children('textarea').val('');
});
/* ==================마감=============== */
$('#closeCard').click(function(){
	Swal.fire({
	    title: '마감하시겠습니까?',
	    icon: 'warning',
	    showCancelButton: true,
	    confirmButtonColor: '#3085d6',
	    cancelButtonColor: '#d33',
	    confirmButtonText: '마감',
	    cancelButtonText: '취소',
	 	}).then((result) => {
	    if (result.value) {
    		$.ajax({
    			type:'get',
    			url:'/closeCard',
    			data:'seq='+$('#boardSeq').val(),
    			success:function(){
    				location.href="/cardBoardView?seq="+$('#boardSeq').val();
    			},
    			error:function(){
    				
    			}
    		});
	    }
		});
});
</script>
</body>
</html>