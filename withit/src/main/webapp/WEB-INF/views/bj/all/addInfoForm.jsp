<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
	<link rel="stylesheet" href="/resources/bj/css/addInfoForm.css">
</head>

<body>
<jsp:include page="/WEB-INF/views/kh/template/header.jsp"/>
<section id="addInfoForm" class="addInfoForm" name="addInfoForm">
	<form action="/all/addInfo" method="post" class="join-form">
		<div class="join-area">
			<input type="text" name="username" id="username" autocomplete="off" value="${username}" required readonly >
			<label for="username" style="top: -2px;font-size: 13px;color: rgb(50, 190, 120);">E-MAIL</label>
		</div>
		
		<br>
		
		<div class="join-area">
			<input type="text" name="nickname" id="nickname" autocomplete="off" required onblur="checkNickname()">
			<label for="nickname">NICKNAME</label>
			<div class="nicknameDiv"></div>
		</div>
		
		<br>
		
		<div class="join-area">
			<input type="number" id="mycareer" name="mycareer" autocomplete="off" required>
			<label for="mycareer">Career</label>
			<div class="careerDiv"></div>
			<div style="font-size:8pt;color:gray;margin-top:5px;"><span style="color:red;">&emsp;*</span>경력 년수를 입력해주세요!</div>
		</div>
	
		<br>
	
		<div class="btn-area">
			<button type="button" id="joinBtn" onclick="join()">JOIN!</button>
			<button type="button" name="back" id="back" onclick="javascript='history.go(-1)'">BACK</button>
		</div>
		
		<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	</form>
</section>
<jsp:include page="/WEB-INF/views/kh/template/footer.jsp"/>
</body>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
let csrfHeaderName = "${_csrf.headerName}";
let csrfTokenValue = "${_csrf.token}";
let checkNick = false;

function checkNickname(){
	let nickname = $('#nickname').val();
	$.ajax({
		type: 'post',
		url: '/all/checkNickname',
		data: {'nickname':nickname},
		beforeSend:function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		success: function(data){
			if(data == 'success'){
				
				$('.nicknameDiv').text("닉네임 사용 가능").css('font-weight','bold').css('color','red').css('font-size','10pt');
				$('.nicknameDiv').focus();
				
				checkNick = true;
			}else{
				$('.nicknameDiv').text("닉네임 중복").css('font-weight','bold').css('color','red').css('font-size','10pt');
				$('.nicknameDiv').focus();
				
				checkNick = false;
			}
		},
		error: function(err){
			console.log(err);
		}
		
	});
}

function join(){
	if(checkNick == false){
		$('.nicknameDiv').text("닉네임 중복검사를 해주세요.").css('font-weight','bold').css('color','red').css('font-size','10pt');
		$('.nicknameDiv').focus();
		return;
	}
	
	document.addInfoForm.submit();
}

</script>
</html>