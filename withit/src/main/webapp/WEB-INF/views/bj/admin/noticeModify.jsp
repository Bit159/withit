<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
	<link rel="stylesheet" href="/resources/sj/css/boardModifyForm.css">
</head>

<body>
	<jsp:include page="/WEB-INF/views/kh/template/header.jsp" />
	<div id="boardModifyWrapper">
        <div id="boardModifyContainer">
        	<h1>게시글 수정</h1>
            <!--
            <div id="boardWriteTopic">
                <label for="" id="boardWriteTopicLabel"></label>
                <div id="boardWriteTopicDiv"></div>
            </div>
            -->
            <div id="boardModifyTitle">
                <label for="" id="boardModifyTitleLabel"></label>
                <div id="boardWriteTitleDiv">
                    <input type="text" id="boardModifyTitleText" value="${bBoardDTO.title }" placeholder="제목을 입력하세요.">
                </div>
            </div>
            <div id="boardModifyContent">
                <label for="" id="boardModifyContentLabel"></label>
                <div id="boardModifyContentDiv">
                    <textarea name="boardModifyContentText" id="boardModifyContentText" placeholder="내용을 입력하세요.">${bBoardDTO.content }</textarea>
                </div>
            </div>
            <div id="boardModifyButton">
                <button type="button" id="boardModifyBtn">글 수정</button>
                <button type="button" id="boardListBtn" onclick="location.href='/freeBoard'">글 목록</button>
            </div>
        </div>
    </div>
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" />
    
    <script src="http://code.jquery.com/jquery-latest.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@9.17.2/dist/sweetalert2.all.min.js"></script>
    <script type="text/javascript">
    // 글 수정 버튼
    $(document).on('click', '#boardModifyBtn', function(){
    	var title = $("#boardModifyTitleText").val();
    	var content = $("#boardModifyContentText").val();
    	var nickname = "nickname";
    	var bno = ${bBoardDTO.bno };
    	var param = "title="+title+"&content="+content+"&nickname="+nickname+"&bno="+bno;
    	
    	
    	var csrfHeader = document.getElementById('csrf_header').content;
		var csrfToken = document.getElementById('csrf').content;
		console.log(csrfHeader);
		console.log(csrfToken);
    	
		if(title != "" & content != ""){
			$.ajax({
				type : "post",
				url : "/notice/noticeModify",
				beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeader, csrfToken);
		    		
		    	},
		    	data: param,
		    	success: function(){
		    		Swal.fire(
							  '게시글 수정 완료',
							  '게시글이 수정 되었습니다.',
							  'success'
							).then((res)=>{
								location.href='/notice/'+bno;
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
    
    // 글 목록 버튼
    </script>
    
</body>
</html>