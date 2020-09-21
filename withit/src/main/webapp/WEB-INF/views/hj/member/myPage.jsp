<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>    
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
    <link rel="stylesheet" href="/resources/hj/css/myPage.css">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
</head>

<body>

	<div id=body_wrapper>
       
        <jsp:include page="/WEB-INF/views/kh/template/header.jsp" />
        <!-- 가운데 main 내용 -->
        <div id="content_wrapper">
			<header class="content_header">
                <div class="header_label" id="header_label">개인 정보 관리</div>
            </header>
			<aside class="content_aside" id="content_aside">
				<div class="aside_menu" id="aside_menu">
				<div class="study_wrap">
					<div class="study_name" onclick="getMyInfo()">개인 정보 관리</div>
				</div>

				<div class="study_wrap">
					<div class="study_name" onclick="showMenu(this)">JAVA Study</div>
                    
					<div class="study_content" id="study_content" style="padding:0;">
                    	<div class="study" onclick="getStudyInfo()">&emsp; - 스터디 정보</div>
                    	<div class="study">&emsp; - 일정 관리</div>
                    </div>
                </div>
            	</div>
			</aside>
            <section class="content_section" id="content_section">
            	<div class="revise_wrap" id="revise_wrap">
	                <form name="reviseForm" id="reviseForm" method="post" action="/synergy2/member/revise">
	                <table>
	                    <tbody>
	                        <tr>
	                            <th class="table_left">아이디</th>
	                            <td class="id_label">${memberDTO.username}</td>
	                        </tr>
	                        
	                        <tr>
	                            <th class="table_left">경력 사항</th>
	                            <td class="table_right">
	                                <input type="number" name="myCareer" id="myCareer" value="${memberDTO.myCareer}">
	                                <div id="careerDiv"></div>
	                            </td>
	                        </tr>
	                        
	                        <tr>
	                            <th class="table_left">비밀번호</th>
	                            <td class="table_right">
	                            	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	                            	<input type="hidden" id="username" name="username" value="${memberDTO.username}">
	                                <input type="password" name="password" id="password" placeholder="비밀번호 입력">
	                                <img src="/resources/bj/image/info.png" width="20" height="20" onclick="showPwdRules()" style="cursor:pointer;">
	                                <div id="pwdDiv"></div>
	                            </td>
	                        </tr>
	                        <tr>
	                            <th class="table_left">비밀번호 재입력</th>
	                            <td class="table_right">
	                                <input type="password" name="repwd" id="repwd" placeholder="한번 더 입력해 주세요">
	                            </td>
	                        </tr>
	                        <tr>
	                            <th class="table_left_bottom"><span class="nickName_star">*  </span>닉네임</th>
	                            <td class="table_right_bottom">
	                                <input type="text" name="nickname" id="nickname" value="${memberDTO.nickname}">
	                                <span class="nickName_re">닉네임을 입력하세요</span>
	                                <div id="nicknameDiv"></div>
	                            </td>
	                        </tr>

	                        
	                    </tbody>
	                </table>
	                </form>
	                <div class="buttonDiv">
	                    <input type="button" id="reviseBtn" value="수정">
	                    <input type="reset" id="resetBtn" value="취소"> 
	                </div>
	                <div class="withdrawDiv">
	                    
	                    <div class="withdrawDiv_label">
	                    	
	                    	
	                      	<input type="hidden" id="username" name="username" value="${memberDTO.username}">
	                      	
	                        <div class="withdrawBtn"><button id="withdrawBtn">회원 탈퇴</button></div>    
	                    </div>
	                </div>
                </div>
                <div id="study_info" align="center" style="display:none;">
				<form name="infoForm" id="infoForm">
					<table>
						<tbody>
							<tr>
								<th class="table_left" style="width: 30%;">스터디 이름</th>
								<td class="table_right" style="width: 500px;">&emsp; 자바 & 스프링 스터디 합시댜</td>
							</tr>
							<tr>
								<th class="table_left">스터디 과목</th>
								<td class="table_right">&emsp; 자바, 스프링</td>
							</tr>
						
							<tr>
								<th class="table_left">스터디 주제</th>
								<td class="table_right">&emsp; MVC Spring Web 프로젝트</td>
							</tr>
							
							<tr>
								<th class="table_left">스터디 인원</th>
								<td class="table_right">
									&emsp; 뱅주(byungjoo104@gmail.com)<br>
									&emsp; 근형(kkh@gmail.com) <br>
									&emsp; 형중(jhj@gmail.com) <br>
									&emsp; 세진(hsj@gmail.com) <br>
									&emsp; 하진(jhj@gmail.com) <br>
								</td>
							</tr>        
						</tbody>
					</table>
				</form>
			</div>
                
            </section>
            <article class="content_article"></article>
			<footer class="content_footer"></footer>
		</div>
		<jsp:include page="/WEB-INF/views/kh/template/footer.jsp" />
	</div>

<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">

var btn = document.getElementById("withdrawBtn");

btn.onclick = async function(){

	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";

	await Swal.fire({
		  title: '회원을 탈퇴 하시겠습니까?',
		  text: "모든 개인 정보가 삭제됩니다. ",
		  icon: 'warning',
		  showCancelButton: true,
		  confirmButtonColor: '#3085d6',
		  cancelButtonColor: '#d33',
		  cancelButtonText: '취 소',
		  confirmButtonText: '회원 탈퇴'
		}).then((result) => {
		  if (result.value) {
			  
			  const { value: password } = Swal.fire({
				  title: '비밀번호를 입력해 주세요',
				  input: 'password',
				  inputPlaceholder: '비밀번호를 입력해 주세요',
				  inputAttributes: {
				    maxlength: 10,
				    autocapitalize: 'off',
				    autocorrect: 'off'
				  }
				}).then((res)=>{
					//비번 입력 후 ok
					if	(res.isConfirmed) {
						let username = document.getElementById('username').value;
						
						$.ajax({
							type: 'post',
							url: '/member/withdrawal',
							data: {'username' : username,
									'password' : res.value},
							beforeSend:function(xhr){
								xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
							},
							success: function(data){
								
							//alert(data);	
								
							if(data == 'equal'){

								Swal.fire({
									  icon: 'success',
									  title: '회원 탈퇴 성공',
									  text: '지금까지 이용해 주셔서 감사합니다.',
								}).then((result) => {
									
									location.href="/loginForm";
								
								})

								
							}else{
								
								Swal.fire({
									  icon: 'error',
									  title: '비번이 틀렸습니다.',
									  text: '다시 입력해 주세요',
								})
								
								
							}
							
								
							},
							error: function(err){
								console.log(err);
							}		
									
						});
						
						
						
					//비번 입력 중단
					}else {
						Swal.fire('취소', '입력을 취소하셨습니다', 'error');
					}
				});
			 
				
		  }
		})
	
	
	
}


</script>
<script type="text/javascript">

$('#reviseBtn').click(function(){
	let passwordRules = /^(?=.*[a-zA-Z])(?=.*[0-9]).{8,16}$/;
	let password = $('#password').val();
	let repwd = $('#repwd').val();
	let nickname = $('#nickname').val();
	let username = document.getElementById('username').value;
	let myCareer = document.getElementById('myCareer').value;
	let newNickname = '0';
	let csrfHeaderName = "${_csrf.headerName}";
	let csrfTokenValue = "${_csrf.token}";
	
	$('#pwdDiv').empty();	
	$('#nicknameDiv').empty();

	if(password != repwd){
		
		$('#pwdDiv').text("비밀번호를 동일하게 입력해 주세요").css("color", "red").css("font-size", "8pt").css("font-weight", "bold");	
		
	}else if(nickname == null || nickname == ""){
	
		$('#nicknameDiv').text("닉네임을 입력해 주세요").css("color", "red").css("font-size", "8pt").css("font-weight", "bold");
	
	}else if(password == ""){

		if(nickname != '${nickname}'){
			newNickname = '1';
		}
		
		$.ajax({
			
			type: 'post',
			url: '/member/revise',
			data: {'username':username,
					'password':password,
					'nickname':nickname,
					'myCareer':myCareer,
					'newNickname':newNickname
			},
			beforeSend:function(xhr){
						xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
			},
			success: function(data){

				if(data =='success'){
					
					Swal.fire({
						  icon: 'success',
						  title: '변경 완료',
						  text: '변경 되었습니다.',
					}).then((result) => {
						logout();
						//location.href="/myPage";
					
					})
					
				}else if(data =='fail'){
					
					Swal.fire({
						  icon: 'error',
						  title: '닉네임 중복',
						  text: '닉네임이 중복 됩니다.',
					})
					
				}else if(data =='onlyPassword'){
					Swal.fire({
						  icon: 'success',
						  title: '비밀번호 변경 완료',
						  text: '닉네임 중복 : 변경을 원하시면 다시 확인해 주세요.',
					}).then((result) => {
						
						location.href="/myPage";
					
					})
					
				}else if(data == 'dualSuccess'){
					Swal.fire({
						  icon: 'success',
						  title: '비밀번호 닉네임 변경 완료',
						  text: '비밀번호와 닉네임이 변경 되었습니다.',
					}).then((result) => {
						
						location.href="/myPage";
					
					})
				}
				
			},
			error: function(err){
				console.log(err);
			}
					
		});
		
	}else if(!passwordRules.test(password)){
		$('#pwdDiv').text("숫자와 영문자 조합으로 8~16자리를 사용해야 합니다.").css("color", "red").css("font-size", "8pt").css("font-weight", "bold");
		
	}else if(password.indexOf(" ") != -1){
		$('#pwdDiv').text("비밀번호에 공백을 사용하실 수 없습니다.").css("color", "red").css("font-size", "8pt").css("font-weight", "bold");
	}

	
});

</script>
<script type="text/javascript">
function showPwdRules(){
	Swal.fire({
		title : '비밀번호 생성 규칙',
		text : '영문과 숫자를 포함한 8~16자리로 설정해야합니다.'
	});
}


function getStudyInfo(){
	let header_label = document.getElementById('header_label');
	let revise = document.getElementById('revise_wrap');
	let info = document.getElementById('study_info');
	
	$('#header_label').empty();
	header_label.innerHTML += '스터디 정보'
		
	revise.style.display = 'none';
	info.style.display = 'block';
	
}

function getMyInfo(){
	let header_label = document.getElementById('header_label');
	let revise = document.getElementById('revise_wrap');
	let info = document.getElementById('study_info');
	
	$('#header_label').empty();
	header_label.innerHTML += '개인 정보 관리';
	revise.style.display = 'block';
	info.style.display = 'none';
	
}

function showMenu(obj){
    let content = document.getElementById('study_content');
    if(!obj.classList.contains('1')){
        content.style.display='block';
        
    }else{
        content.style.display="none";
    }
    obj.classList.toggle("1");
}

function logout(){
	let form = document.reviseForm;
	form.action="/logout";
	form.method="post";
	form.submit();
}
</script>
</body>
</html>