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
    <div id="loginBar_wrapper">
        <div id="loginBar" class="container">
            <a href="#">회원가입</a>
            <a href="#">로그인</a>
        </div>
    </div>
    <div id=header_wrapper>
        <header id="header" class="container">
            <!-- 로고 -->
            <div id="logo">
             <a href="#"><img alt="" style="width:155px;height:55px;" src="../resources/image/logo.png"/></a> 
            </div>
            <!-- nav -->
            <nav id="nav">
                <ul>
                    <li class="welcome" style="white-space: nowrap;">
                        <a href="#">Welcome</a>
                    </li>
                    <li class="matching" style="white-space: nowrap;">
                        <a href="#">스터디 매칭</a>
                    </li>
                    <li class="menu1" style="white-space: nowrap;">
                        <a href="#">스터디 모집</a>
                    </li>
                    <li class="menu2" style="white-space: nowrap;">
                        <a href="#">메뉴</a>
                    </li>
                    <li class="menu3" style="white-space: nowrap;">
                        <a href="#" >문의</a>
                    </li>
                </ul>
            </nav>
        </header>
    </div>
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