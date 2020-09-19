<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
	<link rel="stylesheet" href="/resources/sj/css/boardWriteForm.css">
</head>

<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" />
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
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" />
    
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
    <script type="text/javascript">
    // 글 작성 버튼
    $(document).on('click', '#boardWriteBtn', function(){
    	var title = $("#boardWriteTitleText").val();
    	var content = $("#boardWriteContentText").val();
    	var param = "title="+title+"&content="+content;
    	
    	var csrfHeader = document.getElementById('csrf_header').content;
		var csrfToken = document.getElementById('csrf').content;
		console.log(csrfHeader);
		console.log(csrfToken);
    	
		if(title != "" & content != ""){
			$.ajax({
				type : "post",
				url : "/freeBoard/boardWrite",
				beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeader, csrfToken);
		    		
		    	},
		    	data: param,
		    	success: function(){
		    		Swal.fire(
							  '게시글 등록 완료',
							  '게시글이 등록되었습니다.',
							  'success'
							).then((res)=>{
								location.href='/freeBoard';
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
    	location.href='/freeBoard';
    });
    </script>
    
</body>
</html>