<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="/resources/rich/css/myGroup.css" />
<script defer src="/resources/rich/js/myGroup.js"></script>
<script defer src="/resources/rich/js/rich.js"></script>

<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
	outline-style: none;
}

div[id="superWrapper"] {
	width: 1280px;
	height: 700px;
	display: flex;
	margin: 0 auto;
	margin-top: 35px;
}

div[id="navWrapper"] {
	margin-left: 100px;
}

.sidebar-wrapper {
	position: relative;
}

div[class="page-wrapper.chiller-theme.toggled"], nav[id="sidebar"] {
	width: 200px;
	height: 100%;
	float: left;
}
</style>
<div id="superWrapper">
	<div id="navWrapper">
		<div class="page-wrapper chiller-theme toggled">
			<nav id="sidebar" class="sidebar-wrapper">
				<div class="sidebar-content">
					<div class="sidebar-header">
						<div class="user-pic">
							<img class="img-responsive img-rounded"
								src="https://raw.githubusercontent.com/azouaoui-med/pro-sidebar-template/gh-pages/src/img/user.jpg"
								alt="User picture" onclick="location.href='/myPage'"
								style="cursor: pointer" />
						</div>
						<div class="user-info">
							<span class="user-name"><strong>${nickname }</strong></span>
							<span class="user-role">withIT</span> <span class="user-status">
								<i class="fa fa-circle"></i> <span>Online</span>
							</span>
						</div>
					</div>

					<div class="sidebar-menu">
						<ul>
							<li class="header-menu"><span>Groups</span></li>
							<c:if test="${list ne null}">
								<c:forEach var="dto" items="${list}">
									<li class="sidebar-dropdown">
									<a href="#"> <i class="fab fa-java"></i> <span>${dto.topic }</span>
									</a>
										<div class="sidebar-submenu">
											<ul>
												<li>
													<a onclick="myGroupNav('Info',${dto.gno})" > 
														<i class="fa fa-book"></i> 
														<span>Info</span>
													</a>
												</li>

												<li><a onclick="myGroupNav('Schedule',${dto.gno})"> <i class="far fa-calendar-alt"></i>
														<span>Schedules</span>
												</a></li>
												<li><a onclick="myGroupNav('Chat',${dto.gno})"> <i class="fas fa-comment"></i> <span>Chat</span>
												</a></li>
											</ul>
										</div></li>
								</c:forEach>
							</c:if>
					</div>
			</nav>
			<!-- sidebar-wrapper  -->

		</div>
		<!-- page-wrapper -->
	</div>
