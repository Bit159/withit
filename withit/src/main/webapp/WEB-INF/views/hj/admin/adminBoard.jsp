<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/adminBoard.css">
</head>
<body>

<div id=body_wrapper>
    <jsp:include page="/WEB-INF/views/kh/template/header.jsp" />
    <!-- 가운데 main 내용 -->
    <div id="main_wrap">
        <header class="main_header">
            <div class="hearder_content">관리자 게시판</div>
        </header>
        <aside class="main_aside"></aside>
        <section class="main_section">
            <div class="list_wrap">
                <ul class="list">
                    <li class="list_group">
                        <div class="nickname">닉네임</div>
                        <div class="id">아이디</div>
                        <div class="year">출생연도</div>
                        <div class="button">버튼</div>    
                    </li>
                    <c:forEach var="memberDTO" items="${list}">
                    <li class="list_group">
                        <div class="nickname"><c:out value="${memberDTO.nickname }"></c:out></div>
                        <div class="id"><c:out value="${memberDTO.username }"></c:out></div>
                        <div class="year"><c:out value="${memberDTO.birthyear }"></c:out></div>
                        <div class="button"><input type="button" value="회원 탈퇴"></div>    
                    </li>
                    </c:forEach>
                </ul>
            </div>
        </section>
        <article class="main_article"></article>
        <footer class="main_footer"></footer>
    </div>
</div>
</body>
</html>