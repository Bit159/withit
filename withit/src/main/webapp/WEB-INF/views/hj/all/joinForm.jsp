<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<meta id="_csrf" name="_csrf" content="${_csrf.token}"/>
	<!-- default header name is X-CSRF-TOKEN -->
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}"/> 
<link rel="stylesheet" href="/resources/hj/css/join.css">
<script defer type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script defer type="text/javascript" scr="/resources/hj/css/join.js"></script>
<script defer src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script defer src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
</head>
<body>
<jsp:include page="/WEB-INF/views/kh/template/header.jsp"/>
	<div class="joinDiv">
		<section class="join-form">
			<h1>Let's  With IT</h1>
			<form name="joinFormDiv" action="/join" method="post">
				
					<div class="join-area">
						<input type="text" name="username" id="username" autocomplete="off" placeholder="실제 사용하는 이메일로 가입해주세요!" onblur="checkUsername()">
						<label for="email">E-MAIL</label>
						<div class="usernameDiv"></div>
					</div>
					
					<div class="join-area">
						<input type="text" name="nickname" id="nickname" autocomplete="off" required onblur="checkNickname()">
						<label for="id">NICKNAME</label>
						<div class="nicknameDiv"></div>
					</div>
					
					<div class="join-area">
						<input type="password" name="password" id="password" autocomplete="off" placeholder="영문,숫자  포함 8~16자리">
						<label for="pwd">PASSWORD</label>
						<div class="passwordDiv"></div>
					</div>
					
					<div class="join-area">
						<input type="password" name="repwd" id="repwd" autocomplete="off">
						<label for="repwd">RE-PASSWORD</label>
						<div class="rePasswordDiv"></div>
					</div>
				
					<div class="join-area">
						<input type="number" id="mycareer" name="mycareer" style="width: 45%;" autocomplete="off" required>
						<label for="mycareer">Career</label><br>
						<div class="careerDiv"></div>
						<div style="font-size:8pt;color:gray;margin-top:5px;"><span style="color:red;">&emsp;*</span>경력 년수를 입력해주세요!</div>
					</div>
					<div class="buttonDiv"></div>
					<div class="btn-area">
					
						<input type="button" onclick="validate()" id="singUpBtn" value="JOIN!">
						<button type="button" name="back" id="back" onclick="javascript='history.go(-1)'">BACK</button>
						
					</div>
					
				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			</form>
		</section>
	</div>	
<jsp:include page="/WEB-INF/views/kh/template/footer.jsp"/>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
var checkId = false;
var checkNick = false;
//아이디 중복검사
function checkUsername(){
	
	var csrfHeaderName = document.getElementById('_csrf_header').content;
	var csrfTokenValue = document.getElementById('_csrf').content;	
	
	var emailValidate = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	
	let username = $('#username').val();
	
	if(!(username=="" || username==null)){
		
		if(!emailValidate.test(username)){
			$('.usernameDiv').text("email형식에 맞게 입력하세요").css('font-weight','bold').css('color','red').css('font-size','10pt');
			$('.usernameDiv').focus();
			
			return false;
			
		}	
		
	
	$.ajax({
		type: 'post',
		url: '/all/checkUsername',
		data: {'username':username},
		beforeSend:function(xhr){
			xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		},
		success: function(data){
			if(data == 'success'){
				$('.usernameDiv').text("email 사용 가능").css('font-weight','bold').css('color','red').css('font-size','10pt');
				$('.usernameDiv').focus();
				checkId= true;
				return true;
			}else{
				$('.usernameDiv').text("email 중복").css('font-weight','bold').css('color','red').css('font-size','10pt');
				$('.usernameDiv').focus();
				checkId = false;
				return false;
			}
		},
		error: function(err){
			console.log(err);
		}
		
	});
	
	
	}
	
}

//닉네임 중복검사
function checkNickname(){
	
	var csrfHeaderName = document.getElementById('_csrf_header').content;
	var csrfTokenValue = document.getElementById('_csrf').content;	
	
	let nickname = $('#nickname').val();
	
	//console.log(nickname);
	
	if(!(nickname=="" || nickname==null)){
		
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
					return true;
				}else{
					$('.nicknameDiv').text("닉네임 중복").css('font-weight','bold').css('color','red').css('font-size','10pt');
					$('.nicknameDiv').focus();
					
					checkNick = false;
					return false;
				}
			},
			error: function(err){
				console.log(err);
			}
			
		});
		
	}
	
}


//유효성 검사

function validate() {
	var pwdValidate = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/;/ // 패스워드가 적합한지 검사할 정규식
	var emailValidate = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
	       // 이메일이 적합한지 검사할 정규식
	       
	$('.usernameDiv').empty();//입력하면 한번 지우고 시작
	$('.nicknameDiv').empty();//입력하면 한번 지우고 시작
	$('.passwordDiv').empty();//입력하면 한번 지우고 시작
	$('.rePasswordDiv').empty();//입력하면 한번 지우고 시작
	$('.careerDiv').empty();//입력하면 한번 지우고 시작
	$('.buttonDiv').empty();//입력하면 한번 지우고 시작
	
	let username = $('#username').val();
	let nickname = $('#nickname').val();       
	let pwd = $('#password').val();
	let repwd = $('#repwd').val();
	let mycareer = $('#mycareer').val();
	
	
	 
	 
	if(username==""){
		$('.usernameDiv').text("email을 입력하세요").css('font-weight','bold').css('color','red').css('font-size','10pt');
		$('.usernameDiv').focus();
		return false;
	}
	
	if(!emailValidate.test(username)){
		$('.usernameDiv').text("email을 형식으로 입력하세요").css('font-weight','bold').css('color','red').css('font-size','10pt');
		$('.usernameDiv').focus();
		return false;
		
	}
	
	if(nickname ==""){
		
		$('.nicknameDiv').text("닉네임을 입력하세요").css('font-weight','bold').css('color','red').css('font-size','10pt');
		$('.nicknameDiv').focus();
		
		return false;
		
	}
	
	if(!pwdValidate.test(pwd)){
		$('.passwordDiv').text("비밀번호 형식에 맞게 입력하세요").css('font-weight','bold').css('color','red').css('font-size','10pt');
		$('.passwordDiv').focus();
		return false;
		
	}
	
	if(pwd != repwd){
		
		$('.rePasswordDiv').text("비밀번호를 동일하게 입력하세요").css('font-weight','bold').css('color','red').css('font-size','10pt');
		$('.rePasswordDiv').focus();
		
		return false;
		
	}
	
	if(mycareer ==""){
		
		$('.careerDiv').text("커리어를 입력하세요").css('font-weight','bold').css('color','red').css('font-size','10pt');
		$('.careerDiv').focus();
		
		return false;
	}
	
	if(checkId == false || checkNick == false){
	       
		$('.buttonDiv').text("아이디와 닉네임을 중복되지 않게 해주세요").css('font-weight','bold').css('color','red').css('font-size','10pt');
		$('.buttonDiv').focus();
		
		return false;
	
	}else{
			
		$('form[name=joinFormDiv]').submit();  
		
		
	}
}

function showPwdRules(){
	Swal.fire({
		title : '비밀번호 생성 규칙',
		text : '영문과 숫자를 포함한 8~16자리로 설정해야합니다.'
	});
}

</script>
</body>
</html>