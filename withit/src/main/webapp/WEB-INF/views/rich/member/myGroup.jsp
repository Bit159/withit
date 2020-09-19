<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

<head>
	<%@ include file="/WEB-INF/views/kh/template/head.jsp"%>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<link rel="stylesheet" href="/resources/rich/css/myGroup.css" />
	<script defer src="/resources/rich/js/myGroup.js"></script>
	<link rel="stylesheet" href="/resources/kh/css/header.css">
	
	<style>
	* {
		margin:0;
		padding:0;
		box-sizing: border-box;
		outline-style: none;
	}
	div[id="superWrapper"] {
		width:1280px;
		height:1000px;
		margin:0 auto;
		margin-top:30px;
		display:flex;
		border: 2px solid blue;
		overflow: hidden;
	}
	div[id="navWrapper"] {
		margin-left: 100px;
	}
	.sidebar-wrapper {
		position:relative;
	}
	div[class="page-wrapper.chiller-theme.toggled"], nav[id="sidebar"] {
		width:200px;
		height:100%;
	}


	</style>
</head>

<body>
<jsp:include page="/WEB-INF/views/kh/template/header.jsp" flush="true" />
<div id="superWrapper">
<div id="navWrapper">
  <div class="page-wrapper chiller-theme toggled">
      <nav id="sidebar" class="sidebar-wrapper">
        <div class="sidebar-content">
          <div class="sidebar-brand">
            <a href="/">HOME</a>
          </div>
          <div class="sidebar-header">
            <div class="user-pic">
              <img
                class="img-responsive img-rounded"
                src="https://raw.githubusercontent.com/azouaoui-med/pro-sidebar-template/gh-pages/src/img/user.jpg"
                alt="User picture"
                onclick="location.href='/myPage'"
                style="cursor: pointer"
              />
            </div>
            <div class="user-info">
              <span class="user-name"
                >Jhon
                <strong>Smith</strong>
              </span>
              <span class="user-role">Administrator</span>
              <span class="user-status">
                <i class="fa fa-circle"></i>
                <span>Online</span>
              </span>
            </div>
          </div>

          <div class="sidebar-menu">
            <ul>
              <li class="header-menu">
                <span>Groups</span>
              </li>

              <li class="sidebar-dropdown">
                <a href="#">
                  <i class="fab fa-java"></i>
                  <span>Java Study</span>
                </a>
                <div class="sidebar-submenu">
                  <ul>
                      <li>
                        <a href="#">
                            <i class="fa fa-book"></i>
                            <span>Info</span>
                          </a>
                      </li>
                    <li>
                        <a href="#">
                            <i class="fas fa-map-marked-alt"></i>
                            <span>Map</span>
                          </a>
                      </li>
                    <li>
                      <a href="#">
                        <i class="far fa-calendar-alt"></i>
                        <span>Schedules</span>
                      </a>
                    </li>
                    <li>
                        <a href="#">
                        <i class="fas fa-comment"></i>
                        <span>Chat</span>
                    </a>
                    </li>
                  </ul>
                </div>
              </li>
          <!-- sidebar-menu  -->
        </div>
      </nav>
      <!-- sidebar-wrapper  -->

    </div>
    <!-- page-wrapper -->
    </div>
    <div id="contentWrapper">
          <main class="page-content">
        <div class="container">
          <h2>Group Name</h2><hr />
        </div>
          <h5>Group Info</h5>
          <hr />
      </main>
      <!-- page-content" -->
    </div>
    </div>
    
    <jsp:include page="/WEB-INF/views/kh/template/footer.jsp" flush="true" />
</body>

</html>