<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" />
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
	height: 1000px;
	margin: 0 auto;
	margin-top: 30px;
	display: flex;
	overflow: hidden;
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
							<span class="user-name"><strong>${list[0].nickname }</strong></span>
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
												
												<li><a onclick="myGroupNav('Map',${dto.gno})"> <i class="fas fa-map-marked-alt"></i>
														<span>Map</span>
												</a></li>
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
	<script>
		let newForm = undefined;
	
		function myGroupNav(menu, gno) {
			let url = '/myGroup'+menu;
			let options = myOptionsNotJSON(gno);
			fetch(url, options);
			
			// create element (form)
			newForm = document.createElement('form');
			// set attribute (form) 
			newForm.name = 'newForm';
			newForm.method = 'POST';
			newForm.action = '/myGroup'+menu;

			// create element (input)
			let input1 = document.createElement('input');
			let input2 = document.createElement('input');
		
			let csrf = document.getElementById('csrf').content;
			let csrfHeader = document.getElementById('csrf_header').content;
			
			console.log(csrf, csrfHeader);
			
			// set attribute (input)
			input1.setAttribute("type", "hidden");
			input1.setAttribute("name", "_csrf");
			input1.setAttribute("value", csrf);

			input2.setAttribute("type", "hidden");
			input2.setAttribute("name", "gno");
			input2.setAttribute("value", gno);
			// append input (to form)
			newForm.appendChild(input1);
			newForm.appendChild(input2);

			// append form (to body)
			document.body.appendChild(newForm);
			
			console.log(newForm.action);
			console.log(newForm.gno);
			console.log(newForm);
			
			// submit form
			newForm.submit();
			
		}
	</script>