<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<style>
@charset "UTF-8";
html,body,div,span,img,header,nav,a,ul,li,form, label,footer,tr,th,td,
section,article,aside {
    margin: 0;
	padding: 0;
	border: 0;
	font-size: 100%;
	vertical-align: baseline;   
}
.container {
    margin: 0 auto;
    width: 1280px;
    max-width: 100%;
}
body{
    font-size: 13pt;
    font-family: 'Gill Sans', 'Gill Sans MT', Calibri, 'Trebuchet MS', sans-serif;
}
.box {
    background: rgb(243, 243, 243);
    border-radius: 8px;
    box-shadow: 0px 3px 0px 0px rgba(0, 0, 0, 0.05);
}
/* ===================header=============== */
div[id=loginBar_wrapper] {
    background:rgb(50, 190, 120);
    height: 30px;
}
div[id=loginBar] {
    margin:0 auto;
}
div[id=loginBar] a {
    text-decoration: none;
    color: white;
    font-size: 10pt;
    padding-left: 10px;
    line-height: 30px;
    float: right;
}
#header_wrapper {
    padding: 5px 0 5px;
    z-index: 1;
    background-color: white;
    margin:0 auto;
    width:100%;
    box-shadow: 0 1px 4px 0 rgba(0, 0, 0, 0.2);
}
#header_wrapper.fixed{
    position: fixed; 
    left: 0; top: 0; width: 100%;
    border-bottom: solid 1px rgb(218, 216, 216);
}
header {
    position:relative;
    display:flex;
}
#logo {
    display:inline-block;
}
#nav {
    display: block;
    position:absolute;
    right:0px;
    top:0px;
    height: 50px;
}
#nav ul li {
    display: list-item;
    list-style: none;
    float:left;
    padding-left:2em;
    line-height: 59.8px;
}
#nav ul li a{
    font-weight: bold;
    text-decoration: none;
    color:black;
    padding: .5em;
}
#nav ul li a:hover {
    border-bottom: solid 2px rgb(50, 190, 120); ;
}
#nav ul li[class="welcome"] a{
    font-size: 16pt;
    line-height: 40px;
}
/* 햄버거 메뉴 관련 css */
input[id="menuicon"] {
	display:none;
}
input[id="menuicon"] +label {
	display:none;
}
input[id="menuicon"] +label span {
	display:block;
	position: absolute;
	width: 100%;
	height: 5px;
	border-radius: 30px;
	background:rgb(50, 190, 120);
	transition: all .35s;
}
input[id="menuicon"] +label span:nth-child(1) {
	top:0;
}
input[id="menuicon"] +label span:nth-child(2) {
	top:50%;
	transform: translateY(-50%);
}
input[id="menuicon"] +label span:nth-child(3) {
	bottom: 0;
}
input[id="menuicon"]:checked +label {
	z-index: 3;
}
input[id="menuicon"]:checked +label span {
	background: rgb(50, 190, 120);
    z-index: 3;
    transition: all .35s;
}
input[id="menuicon"]:checked +label span:nth-child(1) {
	top:50%;
	transform: translateY(-50%) rotate(45deg);
}
input[id="menuicon"]:checked +label span:nth-child(2) {
	opacity:0;
}
input[id="menuicon"]:checked +label span:nth-child(3) {
	bottom: 50%;
	transform: translateY(50%) rotate(-45deg);
}
@media (max-width:1920px){
    .sidebar {
        display:none;
    }
}
@media (max-width:900px){
    #nav {
        display:none;
    }
    input[id="menuicon"] +label{
		display: block;
		margin:15px;
		width:40px;
		height:30px;
		right:0;
		position: fixed;
		cursor: pointer;
	}
	#menuButtons {display:none;}
	div[class="sidebar"] {
		display:block;
		top:30px;
		width:300px;
		right:-300px;
		height:100%;
		background: rgb(230, 228, 228);
		position: fixed;
		z-index:2;
		transition: all .35s;
	}
}
.sidebar.fixed {
    display:block;
    top:0px;
    width:300px;
    right:-300px;
    height:100%;
    background: rgb(230, 228, 228);
    position: fixed;
    z-index:2;
}
div[class="sidebar"] ul {
    list-style: none;
    margin-top:70px;
    background: whitesmoke;
}
div[class="sidebar"] > ul > li {
    border-bottom: 1px solid #ccc;
    margin:10;
}
div[class="sidebar"] > ul > li > a {
    display:inline-block;
    width:auto;
    padding: 20px;
    margin:10px;
}
div[class="sidebar fixed"] ul {
    list-style: none;
    margin-top:70px;
    background: whitesmoke;
}
div[class="sidebar fixed"] > ul > li {
    border-bottom: 1px solid #ccc;
    margin:10;
}
div[class="sidebar fixed"] > ul > li > a {
    display:inline-block;
    width:auto;
    padding: 20px;
    margin:10px;
}
input[id="menuicon"]:checked +label +div {right:0;}

div[id="banner_wrapper"] {
	opacity="0";
}
</style>
<div id="loginBar_wrapper">
	<div id="loginBar" class="container">
		<sec:authorize access="isAnonymous()">
			<a href="/joinForm">회원가입</a> <a href="/loginForm">로그인</a>
		</sec:authorize>
		<sec:authorize access="isAuthenticated()">
			<form action="/logout" method="post" name="logout">
   				<a href="javascript:document.logout.submit();">로그아웃</a>
   				<input type="hidden" name="${_csrf.parameterName }" value="${_csrf.token }">
   			</form>
			<sec:authorize access="hasRole('ROLE_MEMBER')"><a href="/myPage">마이페이지</a></sec:authorize>
			<sec:authorize access="hasRole('ROLE_ADMIN')"><a href="/admin">관리자페이지</a></sec:authorize>
		</sec:authorize>
	</div>
</div>
<div id=header_wrapper>
	<header id="header" class="container">
		<!-- 로고 -->
		<div id="logo">
			<a href="/"><img alt="홈으로" style="width: 170px; height: 55px;" src="/resources/kh/image/logo.png" /></a>
		</div>
		<!-- nav -->
		<nav id="nav">
			<ul>
				<li class="welcome" style="white-space: nowrap;"><a	href="/">Welcome</a></li>
				<li class="matching" style="white-space: nowrap;"><a href="/match">스터디 매칭</a></li>
				<li class="createGroup" style="white-space: nowrap;"><a href="/cardBoard">스터디 모집</a></li>
				<li class="groupManage" style="white-space: nowrap;"><a href="/myGroup">그룹관리</a></li>
				<li class="freeBoard" style="white-space: nowrap;"><a href="/freeBoard">자유게시판</a></li>
				<li class="menu3" style="white-space: nowrap;"><a href="/crawlBoard">크롤게시판</a></li>
			</ul>
		</nav>
	</header>
</div>