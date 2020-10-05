<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link rel="stylesheet" href="/resources/kh/css/footer.css">
<div id="footer_wrapper">
<sec:authorize access="isAuthenticated()">
    <jsp:include page="/WEB-INF/views/bj/member/chattingList.jsp"/>
</sec:authorize>
	<footer id="footer" class="container">
		<div class="footerDiv">
			<h1>서비스</h1>
			<p onclick="location='/notice'" style="cursor:pointer;">공지사항</p>
			<p onclick="location='/qna'" style="cursor:pointer;">Q n A</p>
		</div>
		<div class="footerDiv">
			<h1>프로젝트</h1>
			<p onclick="location='/history'" style="cursor:pointer;">프로젝트 소개</p>
			<p>개발진</p>
		</div>
		<div class="footerDiv">
			<h1>고객문의</h1>
			<p>Tel: 1234-5678 (24시간 연중무휴)</p>
			<p>Email: synergy.bit159@gmail.com</p>
			<p>kakaoID: 020478</p>
		</div>
	</footer>
</div>

<script>
	document.addEventListener('DOMContentLoaded', ()=>{
		var body = document.body, html = document.documentElement;
 			var height = Math.max( body.scrollHeight, body.offsetHeight, 
	                       html.clientHeight, html.scrollHeight, html.offsetHeight );
		document.querySelector('div[id="footer_wrapper"]').style.position="absolute";
		document.querySelector('div[id="footer_wrapper"]').style.top=(height-260)+"px";
		document.querySelector('div[id="footer_wrapper"]').style.opacity="1";
	});
</script>

<script>
//방문자 카운트 by rich 2020.10.05
	
	visitCount();
	
	//24시간 간격으로 방문횟수를 카운트 하는 함수입니다
	function visitCount() {
	    // 쿠키가 있으면 return;
	    if(document.cookie.match(/withit/)) return;
	
	    // 쿠키가 없으면 24시간 유효한 쿠키를 생성 후 컨트롤러 전송
	    let a = new Date();
	    a.setDate(new Date().getDate()+1);
	    document.cookie = 'withit=1;Expires='+a;
	    //컨트롤러 전송
	    let result = identifyBrowser();
	    let url = "/visitCount";
	    let options = myOptions(result);
	    fetch(url, options);
	}
	
	
	//userAgent를 받아서 클라이언트 정보를 출력하는 함수입니다.
	function identifyBrowser(userAgent) {
	    
	    //파라메타가 주어지지 않을 경우 현재 위치의 userAgent를 이용
	    if(userAgent === undefined) {
	        userAgent = navigator.userAgent;
	    }

	    //결과를 출력할 객체를 선언합니다.
	    let result = new Object();
	    
	    result.userAgent = userAgent;
	    result.width = screen.width;
	    result.height = screen.height;
	    result.language = navigator.language;
	    result.referer = document.referrer;
	    result.pathname = location.pathname;
	    result.time = new Date().getTime();


	    //-----------------------브라우저 검증---------------------------    
	    
	    //1. IE 10 이하 검증
	    if(/MSIE/.test(userAgent)){
	        result.browser = userAgent.match(/IE \d+.\d+/);
	    }

	    //2. IE11 검증
	    else if(/Trident/.test(userAgent)) {
	        result.browser = "IE " + userAgent.match(/rv:\d+\.\d+/)[0].replace("rv:", "");
	    }

	    //3. Firefox 검증
	    else if(/Firefox/.test(userAgent)) {
	        result.browser = userAgent.match(/Firefox\/\d+\.\d+/)[0].replace("/", " ");
	    }

	    //4. Opera Touch 검증
	    else if(/OPT/.test(userAgent)) {
	        result.browser = userAgent.match(/OPT\/\d+\.?[0-9]?/)[0].replace("/", " ").replace("OPT", "Opera Touch");
	    }

	    //5. Opera Mini 검증
	    else if(/Opera Mini/.test(userAgent)) {
	        result.browser = userAgent.match(/Opera Mini\/\d+\.\d+/)[0].replace("/", " ");
	    }

	    //6. Opera 검증
	    else if(/OPR/.test(userAgent) || /Opera/.test(userAgent)) {
	        if(/OPR/.test(userAgent)) {
	             result.browser = "Opera" + userAgent.match(/OPR\/\d+\.\d+/)[0].replace("OPR/", " ");
	        }else if(/Opera\//) {
	            result.browser = "Opera" + userAgent.match(/Version\/\d+\.\d+/)[0].replace("Version/", " ");
	        }else {
	            result.browser = userAgent.match(/Opera \d+\.\d+/)[0];
	        }
	    }

	    //7.Edge 검증
	    else if(/Edg/.test(userAgent)) {
	        result.browser = userAgent.match(/Edg[e]*\/\d+\.\d+/)[0].replace("/", " ").replace("Edge", "Edg").replace("Edg", "Edge");
	    }
	    
	    //8. SamsungBrowser 검증
	    else if(/SamsungBrowser/.test(userAgent)) {
	        result.browser = userAgent.match(/SamsungBrowser\/\d+\.\d+/)[0].replace("/", " ");
	    }

	    //9. Whale 검증
	    else if(/Whale/.test(userAgent)) {
	        result.browser = userAgent.match(/Whale\/\d+\.\d+/)[0].replace("/", " ");
	    }

	    //10. Safari 검증
	    else if(/Safari/.test(userAgent) && !/Chrome/.test(userAgent)) {
	        result.browser = "Safari " + userAgent.match(/Version\/\d+\.[0-9]/)[0].replace("Version/", "");
	    }

	    //11. Chrome 검증
	    else if(/Chrome/.test(userAgent)) {
	        result.browser = userAgent.match(/Chrome\/\d+\.\d+/)[0].replace("/", " ");
	    }

	    //12. 기타
	    else {
	        result.browser = "unknown";
	    }

	    //----------------------------OS 검증-----------------------------

	    //1. Windows 검증
	    if(/Windows/.test(userAgent)) {
	        result.os = "Windows ";
	        let osv = userAgent.substring(userAgent.indexOf("Windows NT ")+11, userAgent.indexOf("Windows NT ")+15);
	        if(/5.0/.test(osv)) result.os += "2000";
	        else if(/5.1/.test(osv)) result.os += "XP";
	        else if(/5.2/.test(osv)) result.os += "XP";
	        else if(/6.0/.test(osv)) result.os += "Vista";
	        else if(/6.1/.test(osv)) result.os += "7";
	        else if(/6.2/.test(osv)) result.os += "8";
	        else if(/6.3/.test(osv)) result.os += "8.1";
	        else if(/10.0/.test(osv)) result.os += "10";
	        else result.os += "unknown";
	    }

	    //2. Android 검증
	    else if(/Android/.test(userAgent)) {
	        if(userAgent.match(/Android \d+\.?\d?\.?\d?/)) {
	            result.os = userAgent.match(/Android \d+\.?\d?\.?\d?/);
	        }else {
	            result.os = "Android unknown ver.";
	        }
	    }
	            
	    //3. iPhone 검증
	    else if(/iPhone/.test(userAgent)) {
	        result.os = "iPhone";
	        if(/iPhone OS/.test(userAgent)) {
	            result.os = userAgent.match(/iPhone OS \d+_\d+_?[0-9]?/)[0].replace(" OS", "").replaceAll("_", ".");
	        }else if(/iPhone/.test(userAgent)) {
	            result.os = "iPhone unknown ver.";
	        }
	    }

	    //4. iPad 검증
	    else if(/iPad/.test(userAgent)) {
	        result.os = "iPad " + userAgent.match(/CPU OS \d+_\d+_?[0-9]?/)[0].replace("CPU OS ", "").replaceAll("_", ".");
	    }

	    //5. Mac 검증
	    else if(/Mac OS X/.test(userAgent)) {
	        result.os = userAgent.match(/Mac OS X \d+_\d+_?[0-9]?/)[0].replace(" OS X", "").replaceAll("_", ".");
	    }    

	    //6. 리눅스 검증
	    else if(/Linux/.test(userAgent)) {
	        result.os = "Linux";
	        if(/Ubuntu/.test(userAgent)) {
	            result.os += " Ubuntu";
	        }
	    }
	    
	    //7. Bot 검증
	    else if(/bot/.test(userAgent)) {
	    	result.os = "Bot";
	    }
	    
	    //8. 기타
	    else {
	        result.os = "unknown";
	    }

	    return result;
	}
	

	//POST방식으로 json 객체를 전송하는 options를 생성해주는 함수입니다.
	function myOptions(ob) {
		let options = {
			method: "POST",
			headers: {
				'X-CSRF-TOKEN': document.getElementById('csrf').content,
				Accept: "application/json",
				"Content-Type": "application/json; charset=utf-8",
			},
			body: JSON.stringify(ob),
		};
		
		return options;
	}
</script>
