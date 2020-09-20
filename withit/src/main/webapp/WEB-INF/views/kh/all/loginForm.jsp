<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" />
	<meta charset="UTF-8">
	<meta name="google-signin-scope" content="profile email" />
	<meta name="google-site-verification" content="fb6rIsh8WzJKvF5SCARFAzqdWF95ZEKdhPfXX2lLTzw"/>
	<meta name="google-signin-client_id" content="752749290235-0lrjurm4fdk31il80d87i99knklc9650.apps.googleusercontent.com"/>
	<script defer src="https://apis.google.com/js/platform.js"></script>
	<link rel="stylesheet" href="/resources/kh/css/login.css">
	<script defer type="text/javascript" src="/resources/kh/js/login.js"></script>
	<script defer type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
</head>
<body>
	<section class="login-form">
		<label for="sideicon" id="back"></label>
		<h1>Let's Withit</h1>
		
		<form id="loginForm" name="loginForm" method="post" action="/login" >
			<div class="info-area">
				<input type="text" name="username" id="username" autocomplete="off" required>
				<label for="username">EMAIL</label>
			</div>

			<div class="info-area">
				<input type="password" name="password" id="password" autocomplete="off" onkeydown="enterKey()" required>
				<label for="password">PASSWORD</label>
			</div>
			<div style="margin-top:15px;"><input type="checkbox" name="remember-me">자동로그인</div>
			<div class="btn-area">
				<button id="loginBtn">LOGIN</button>
				<button type="button" onclick="location='/'">BACK</button>
			</div>
			
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
			<input type="hidden" id="email" name="email">
		</form>
		
		<div class="thirdParty" align="center" style="margin-top:30px;">
			<div class="g-signin2" data-onsuccess="onSignIn" data-theme="dark"></div>
		<script>
		let csrfHeaderName = "${_csrf.headerName}";
		let csrfTokenValue = "${_csrf.token}";
		
		function onSignIn(googleUser) {
			var profile = googleUser.getBasicProfile();			
		    let username = profile.getEmail();
		    console.log(username);
		    $.ajax({
		    	type : 'post',
		    	url  : '/checkMember',
		    	beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    		
		    	},
		    	data : 'username=' + username,
		    	dataType: 'text',
		    	success : function(data){
		    		if(data == 'none'){
		    			logout();
		    		    page_move(username);
		    		    
		    		}else{
		    			$.ajax({
		    				type : 'post',
		    				url : '/login',
		    		    	beforeSend: function(xhr){
		    		    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    		    	},
		    		    	data : {
		    		    			'username' : username,
		    		    			'password' : data
		    		    			},
		    				success : function(){
		    					logout();
		    					location="/";
		    				}
		    			});
		    		}
		    	}
		    	
		    });
		  }
		function logout(){
			let auth2 = gapi.auth2.getAuthInstance(); //소셜로그인은 바로 로그아웃 처리
			auth2.signOut().then(function(){
				
			})
			auth2.disconnect();
		}
		</script>
			<%-- <img src="/resources/kh/image/kakao_login_medium_narrow.png"><br> --%>
		</div>

		<div class="caption">
			<a href="/joinForm">회원가입</a>&emsp;
			<a href="javascript:findPwd()" id="findPwd">비밀번호 찾기</a>
		</div>
	</section>
	<jsp:include page="/WEB-INF/views/kh/template/footer.jsp"></jsp:include>
</body>
<script type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
let csrfHeaderName2 = "${_csrf.headerName}";
let csrfTokenValue2 = "${_csrf.token}";
function enterKey(){
	if(window.event.keyCode == 13){
		document.getElementById('loginForm').submit();
	}
}
function page_move(username){
	let form = document.loginForm;
	form.email.value = username;
	form.action="/all/addInfoForm";
	form.method="post";
	form.submit();
}

function findPwd(){
	Swal.fire({
		text : '이메일을 입력해주세요',
		icon : 'info',
		input : 'text',
		showCancelButton  : true,
		confirmButtonColor: '#3085d6',
		cancelButtonColor : '#d33',
		confirmButtonText : '확인',
		cancelButtonText  : '취소',
		
	}).then((result) => {
		if(result.isConfirmed) {
			let answer = JSON.stringify(result.value);
			$.ajax({
				type: 'post',
				beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeaderName2, csrfTokenValue2);
		    	},
				url : '/findPwd',
				data : 'username=' + answer,
				dataType : "text",
				success : function(data){
					if(data == "none"){
						Swal.fire({
							text : '해당 이메일은 없는 이메일 입니다.',
							icon : 'error',
							confirmButtonColor: '#3085d6',
							confirmButtonText : '확인'
						});
					
					}else {
						Swal.fire({
							html : "<strong>해당 이메일로 변경된 비밀번호를 보냈습니다.<br><br>해당 비밀번호로 로그인해주세요.</string>",
							icon : 'success',
							confirmButtonColor: '#3085d6',
							confirmButtonText : '확인'
						
						}).then((result) => {
							if(result.isConfirmed){
							}
						})
					}
					
				}
			});
		}
	});
}

</script>
</html>