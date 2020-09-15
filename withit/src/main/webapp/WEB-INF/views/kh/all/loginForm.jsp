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
				<label for="username">EMAIL</label>
			</div>

			<div class="info-area">
				<input type="password" name="password" id="password" autocomplete="off" onkeyup="enterKey()" required>
				<label for="password">PASSWORD</label>
			</div>
			<div><input type="checkbox" name="remember-me" style="padding-bottom: 5pt">자동로그인</div>
			<div class="btn-area">
				<button id="loginBtn">LOGIN</button>
				<button type="button" onclick="location='/'">BACK</button>
			</div>
			
			<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
	
		</form>
		
		<div class="thirdParty" align="center" style="margin-top:30px;">
			<div class="g-signin2" data-onsuccess="" data-theme="dark"></div>
		<script>
		let csrfHeaderName = "${_csrf.headerName}";
		let csrfTokenValue = "${_csrf.token}";
		
		function onSignIn(googleUser) {
			var profile = googleUser.getBasicProfile();			
		    let username = profile.getEmail();
		    
		    $.ajax({
		    	type : 'post',
		    	url  : '/all/checkMember',
		    	beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
		    		
		    	},
		    	data : 'username=' + username,
		    	dataType: 'text',
		    	success : function(data){
		    		if(data == 'none'){
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
		    					let auth2 = gapi.auth2.getAuthInstance(); //소셜로그인은 바로 로그아웃 처리
		    					auth2.signOut().then(function(){
		    						console.log('로그아웃');
		    					})
		    					auth2.disconnect();
		    					
		    					location="/all/welcome";
		    				}
		    			});
		    		}
		    	}
		    	
		    });
		  }
		
		</script>
			<%-- <img src="/resources/kh/image/kakao_login_medium_narrow.png"><br> --%>
		</div>

		<div class="caption">
			<a href="/joinForm">회원가입</a>&emsp;
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
function page_move(username){
	let form = document.loginForm;
	form.email.value = username;
	form.action="/all/addInfoForm";
	form.method="post";
	form.submit();
}
</script>
</html>