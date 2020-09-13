<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Insert title here</title>
<meta id="csrf_header" name="_csrf_header" content="${_csrf.headerName}" />
<meta id="csrf" name="_csrf" content="${_csrf.token}" />
<script defer src="../resources/js/admin_map.js" ></script>
<link rel="stylesheet" href="../resources/css/admin_map.css" />
</head>
<body>

	<div id="wrap">
    
    <!-- 가운데 main 내용 -->
        <aside class="aside">
            <div class="aside_menu">
                <ul class="aside_menu_list">
                	<li class="aside_menu_top">Admin Menu</li>
                    <li class="aside_menu_list_1">
                    	<a href="/synergy2/all/adminStats" class="aside_menu_list_1_a">
                        <img src="../resources/image/chartIcon3.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Statistics
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 80px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_2">
                    	<a href="/synergy2/all/programmingStats" class="aside_menu_list_2_a">
                        <img src="../resources/image/chartIcon4.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Programming
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 50px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_3">
                    	<a href="/synergy2/all/adminBoard" class="aside_menu_list_3_a">
                        <img src="../resources/image/task2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Management
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 45px;"/>
                    	</a>
                    </li>
                    <li class="aside_menu_list_4">
                    	<a href="/synergy2/all/admin_map" class="aside_menu_list_4_a">
                        <img src="../resources/image/map2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Location Map
                        <img src="../resources/image/right2.png" style="width: 13px; height: 13px; padding-left: 45px;"/>
                    	</a>
                    </li>
                </ul>
            </div>
        </aside>
        
        <input type="checkbox" id="menuicon">
        <label for="menuicon">
            <span></span>
            <span></span>
            <span></span>
        </label>
        <div class="sidebar">
            <ul>
                <li class="sidebar_menu">Admin Menu</li>
                <li><a><img src="../resources/image/chartIcon.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Member
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; margin-left: 30px;"/>
                </a></li>
                <li><a><img src="../resources/image/chartIcon2.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Programming
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>   
                <li><a><img src="../resources/image/task.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Management
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>
                <li><a><img src="../resources/image/map.png" style="width: 13px; height: 13px; margin-right: 10px;"/>Location Map
                    <img src="../resources/image/right.png" style="width: 13px; height: 13px; "/>
                </a></li>
            </ul>
        </div>
        
        <header class="header">
            <div class="header_title"><img src="../resources/image/map3.png" style="width: 40px; height: 35px; margin-right:20px;"/>Location Map</div>
        </header>
        <section class="section">
            <div class="section_main">
            	<div id="map" style="width: 100%; height: 600px; margin: 0 auto; border: 3px solid #32be78;"></div>
            </div>
        </section>
        <footer class="footer"></footer>
       
</div>

<script	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=41be22a5170d5fc6115853c77dc3d45e"></script>	
</body>
</html>