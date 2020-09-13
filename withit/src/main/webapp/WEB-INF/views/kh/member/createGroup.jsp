<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta id="_csrf" name="_csrf" content="${_csrf.token}">
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}">
<meta charset="UTF-8">
<title>시너지</title>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link rel="stylesheet" href="../resources/css/createGroup.css">
<link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/css/select2.min.css" rel="stylesheet" />	
</head>
<body>
	<jsp:include page="../template/header.jsp"></jsp:include>
	<form id="registerForm" method="post" action="/synergy-kh/member/regist">
	<input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}">
    <div id="body-wrapper">
        <div id="container" style="white-space: nowrap;">
            <div class="registForm-header">
                <h2 align=center>스터디그룹 개설하기</h2>
            </div>
            <div class="registForm">
                <div class="registForm-title">
                    <h1>한 줄 소개<span>*</span></h1>
                    <input required type="text"  name="title" id="title" maxlength="15" placeholder="소개를 입력해주세요" autocomplete="off">
                </div>
                <div class="registForm-topic">
                    <h1>주제 검색<span>*</span></h1>
<!--                <input type="text" id="topic" name="topic" placeholder="ex) Java"> -->
                    <select id="selectTopic" name="topic">
						<option value="Java">Java</option>
						<option value="JavaScript">JavaScript</option>
						<option value="Python">Python</option>
						<option value="Spring">Spring</option>
						<option value="Vue">Vue</option>
						<option value="React">React</option>
						<option value="Android">Android</option>
						<option value="iOs">iOs</option>
						<option value="Swift">Swift</option>
						<option value="모각코">모각코</option>
						<option>option13</option>
						<option>option14</option>
						<option>option15</option>
						<option>option16</option>
						<option>option17</option>
						<option>option18</option>
						<option>option19</option>
						<option>option20</option>
						</select>
                    <div id="AddTopic"></div>
                </div>
                <div class="registForm-location">
                    <h1>지역 검색<span>*</span></h1>
<!--                     <input type="text" name="location" id="location" placeholder="ex) 서울 송파구"> -->
                    <select id="location" name="location"></select>
                </div>
                <div class="registForm-people">
                    <h1>최대 인원<span>*</span></h1>
                    <select id="people" name="people">
                        <option value="3">3명</option>
                        <option value="4">4명</option>
                        <option value="5">5명</option>
                        <option value="6">6명</option>
                        <option value="7">7명</option>
                        <option value="8">8명</option>
                        <option value="9">9명</option>
                    </select>
                </div>
                <div class="registForm-content">
                    <h1>상세설명</h1>
                    <textarea name="content"></textarea>
                </div> 
<!--                 <input type="hidden" id="content" name="content"> -->
                <div class="buttons">
                	<input type="submit" value="등록">
                	<input type="button" id="backBtn" value="돌아가기">
                </div>
            </div>
        </div>
    </div>
    </form>
    <jsp:include page="../template/footer.jsp"></jsp:include>
</body>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@9"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.9/js/select2.min.js"></script>
<script>
$(document).ready(function(){
	$.ajax({
		type:'get',
		url:'/synergy-kh/member/autocomplete',
		data:{},
		dataType:'json',
		success:function(data){
			$("#location").select2({
// 	            placeholder: '입력',
	            closeOnSelect: true,
	            allowClear: false,
	            data: data.arr
	        });
		},	
		error:function(){
			alert('값 가져오기 실패')
		}
	});
});
$('#selectTopic').select2();
$('#people').select2({
	minimumResultsForSearch: Infinity
});
	$('#backBtn').click(function(){
		Swal.fire({
			  title: '',
			  text: "입력하신 정보가 저장되지 않을 수 있습니다",
			  icon: 'warning',
			  showCancelButton: true,
			  confirmButtonColor: '#3085d6',
			  cancelButtonColor: '#d33',
			  confirmButtonText: '확인',
			  cancelButtonText: '취소'
			}).then((result) => {
			  if (result.isConfirmed) {
				location.href='/synergy-kh/member/cardBoardList';
			  }
			})
	});
	$(document).ready(function(){ 
		$('#title').keyup(function(){ 
			if ($(this).val().length > $(this).attr('maxlength')) { 
				alert('최대 13글자 까지 입력가능합니다'); $(this).val($(this).val().substr(0, $(this).attr('maxlength'))); } }); });
</script>
</html>