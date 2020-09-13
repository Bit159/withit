<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta name="google-signin-scope" content="profile email" />
	<meta name="google-site-verification" content="fb6rIsh8WzJKvF5SCARFAzqdWF95ZEKdhPfXX2lLTzw"/>
	<meta name="google-signin-client_id" content="752749290235-0lrjurm4fdk31il80d87i99knklc9650.apps.googleusercontent.com"/>
	<title>로그인</title>
	<script defer type="text/javascript" src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script defer src="https://apis.google.com/js/platform.js"></script>
	<link rel="stylesheet" href="/resources/kh/css/login.css">
	<script defer type="text/javascript" src="/resources/kh/js/login.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" />
	<section class="login-form">
		<label for="sideicon" id="back"></label>
		<h1>Let's Withit</h1>
		
		<form id="loginForm" name="loginForm" method="post" action="/login" >
			<div class="info-area">
				<input type="text" name="username" id="username" autocomplete="off" required>
				<input type="hidden" name="email" id="email">
				<label for="username">EMAIL</label>
			</div>

			<div class="info-area">
				<input type="password" name="password" id="password" autocomplete="off" onkeyup="enterKey()" required>
				<input type="hidden" name="redirect" id="redirect" value="${password }">
				<label for="password">PASSWORD</label>
			</div>
			<div><input type="checkbox" name="remember-me" style="padding-bottom: 5pt">자동로그인</div>
			<div class="btn-area">
				<button type="button" id="loginBtn" onclick="checkLogin()">LOGIN</button>
				<button type="button" onclick="location='/all/welcome'">BACK</button>
			</div>
			
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	
		</form>
		
		<div class="thirdParty" align="center" style="margin-top:30px;">
			<div class="g-signin2" data-onsuccess="" data-theme="dark"></div>
		<script>
		let csrfHeaderName = "${_csrf.headerName}";
		let csrfTokenValue = "${_csrf.token}";
		
		function onSignIn(googleUser) {
		    // Useful data for your client-side scripts:
			var profile = googleUser.getBasicProfile();
		    console.log("ID: " + profile.getId()); // Don't send this directly to your server!
		    console.log("Full Name: " + profile.getName());
		    console.log("Given Name: " + profile.getGivenName());
		    console.log("Family Name: " + profile.getFamilyName());
		    console.log("Image URL: " + profile.getImageUrl());
		    console.log("Email: " + profile.getEmail());
			
		    let username = profile.getEmail();
		    let password = $('#redirect').val();
		    
		    if(username == ''){
		    	return;
		    }
	
		    $.ajax({
		    	type : 'post',
		    	url  : '/all/checkMember',
		    	beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    		
		    	},
		    	data : 'username=' + username,
		    	dataType: 'text',
		    	success : function(data){
		    		if(data == 'ok'){
		    			//$('#username').val(username);
		    			//$('#password').val(password);
		    			//document.loginForm.submit();
		    			alert("있음");
		    			
		    			$.ajax({
		    				type : 'post',
		    				url : '/socialLogin',
		    		    	beforeSend: function(xhr){
		    		    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    		    		
		    		    	},
		    		    	data : 'username1=' + username,
		    				success : function(){
		    					alert("에이작스");
		    					location="/all/welcome";
		    				}
		    			});
		    			
		    		}else{
		    			alert("없음");
		    		    page_move(username);
		    			
		    		}
		    	}
		    	
		    });
	
		    // The ID token you need to pass to your backend:
		    var id_token = googleUser.getAuthResponse().id_token;
		    console.log("ID Token: " + id_token);
		    
		  }
		
		function page_move(username){
			let form = document.loginForm;
			form.email.value = username;
			form.action="/all/addInfoForm";
			form.method="post";
			form.submit();
		}
		
		function socialLogin(username){
			let form = document.loginForm;
			form.username.value= username;
			form.method="post";
			form.action="/socialLogin";
			form.submit();
		}
		</script>
			<img src="/resources/kh/image/kakao_login_medium_narrow.png"><br>
		</div>

		<div class="caption">
			<a href="/all/joinForm">회원가입</a>&emsp;
			<a href="">아이디/비밀번호 찾기</a>
		</div>
	</section>
	<jsp:include page="/WEB-INF/views/kh/template/footer.jsp"></jsp:include>
</body>
<script type="text/javascript">
function enterKey(){
	if(window.event.keyCode == 13){
		document.loginForm.submit();
	}
}
</script>
</html>