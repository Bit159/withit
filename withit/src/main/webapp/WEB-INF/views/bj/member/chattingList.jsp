<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style type="text/css">
	* {
	    margin: 0;
	    padding: 0;
	}
	
	.modal {
		font-size : 11px;
	    display: none;
	    position: fixed;
	    z-index: 4;
	    left: 0;
	    top: 0;
	    width: 100%;
	    height: 100%;
	    overflow: auto;
	    align-content: right;
	}
	
	.modal-content{
		position: fixed;
		width: 400px;
		height: 600px;
		right: 5%;
		bottom : 10%;
		background-color: white;
		box-shadow: 3px 3px 3px 3px gray;
	}
	
	.chat_list_wrap {
	    list-style: none;
	    width: 400px;
	    height : 600px;
	    background-color: white;
	}
	
	.chat_list_wrap .header {
	    font-size: 14px;
	    padding: 15px 0;
	    background: #32be78;
	    color: white;
	    text-align: center;
	    font-family: "Josefin Sans", sans-serif;
	}
	
	.chat_list_wrap .search {
	    background: #eee;
	    padding: 5px;
	}
	
	.chat_list_wrap .search input[type="text"] {
	    width: 100%;
	    border-radius: 4px;
	    padding: 5px 0;
	    border: 0;
	    text-align: center;
	}
	
	.chat_list_wrap .list {
	    padding: 0 16px;
	}
	
	.chat_list_wrap .list ul {
	    width: 100%;
	    list-style: none;
	    margin-top: 3px;
	}
	
	.chat_list_wrap .list ul li {
	    padding-top: 10px;
	    padding-bottom: 10px;
	    border-bottom: 1px solid #e5e5e5;
	}
	
	.chat_list_wrap .list ul li table {
	    width: 100%;
	    background-color: white;
	}
	
	.chat_list_wrap .list ul li table td.profile_td {
	    width: 60px;
	    padding-right: 11px;
	}
	
	.chat_td{
		vertical-align: top;
	}
	
	.chat_name{
		font-size: 15px;
		font-weight : 1000;
	}
	
	.chat_list_wrap .list ul li table td.profile_td img {
	    width: 50px;
	    heigth: 50px;
	    vertical-align:middle;
	}
	
	.chat_list_wrap .list ul li table td.chat_td .email {
	    font-size: 12px;
	    font-weight: bold;
	}
	
	.chat_list_wrap .list ul li table td.time_td {
	    width: 90px;
	    text-align: center;
	}
	
	.chat_list_wrap .list ul li table td.time_td .time {
	    padding-bottom: 4px;
	}
	
	.chat_list_wrap .list ul li table td.time_td div p {
	    width: 5px;
	    height: 5px;
	    margin: 0 auto;
	    -webkit-border-radius: 50%;
	    -moz-border-radius: 50%;
	    border-radius: 50%;
	    background: #e51c23;
	}
	
	li{
	    cursor: pointer;
	}
	
	.close {	
	    color: #aaa;	
	    float: right;	
	    font-size: 28px;	
	    font-weight: bold;	
	}
	
	.close:hover,
	.close:focus {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	<!-- 채팅방 css -->
	
	#contentCover{
	    width: 400px;
	    height : 600px;
	}
	
	#chatWrap{
        width :400px;
        top : 100px;
        border : 1px solid #ddd;
        background-color: white;
    }

    #chatHeader{
        height: 60px;
        text-align: center;
        line-height: 60px;
        font-size: 25px;
        font-weight: 900;
        border-bottom: 1px solid #ddd;
        background-color: #32be78;
    }

    #messages{
        height: 470px;
        overflow-y: auto;
        padding: 10px;
    }

    .myMessage{
        text-align: right;
    }

    .otherMessage{
        text-align: left;
        margin-bottom: 5px;
    }

    .message{
        display: inline-block;
        border-radius: 15px;
        padding : 7px 15px;
        margin-bottom: 1px;
        margin-top: 5px;
    }
    
	.date{
		padding : 0px 5px;
		margin-bottom: 10px;
		font-size: 8px;
		display: block;
	}

    .otherMessage > .message{
        background-color: #f1f0f0;
    }

    .myMessage > .message{
        background-color: #32be78;
    }

    .otherName{
    	padding : 0px 5px;
        font-size: 12px;
        display: block;
        font-weight: bold;
    }

    #messageForm{
        display: block;
        width:  100%;
        height: 50px;
        border-top: 2px solid #f0f0f0;
    }

    #messageInput{
        width: 80%;
        height: calc(100% - 1px);
        border : none;
        padding-bottom : 0;
    }

    #messageInput:focus{
        outline: none;
    }

    #messageForm > input[type=button]{
        outline: none;
        border : none;
        background :none;
        color : #32be78;
        font-size: 17px;
        cursor: pointer;
    }
    
    #messages::-webkit-scrollbar{
    	display: none;
    }
    
</style>
<link rel="stylesheet" type="text/css" href="/resources/bj/css/toastr.min.css"/>
<script defer type="text/javascript" src="/resources/bj/js/sockjs.min.js"></script>
<script defer type="text/javascript" src="/resources/bj/js/stomp.min.js"></script>
<script defer type="text/javascript" src="/resources/bj/js/toastr.min.js"></script>
<sec:authentication property="principal.username" var="username"/>
<div class="modal" id="modal">
	<div id="modal-content" class="modal-content">
		<span class="close">&times;</span>
		<div class="chat_list_wrap" id="chat_list_wrap">
		    <div class="header">
		        withIT
		    </div>
		    <div class="search">
		        <input type="text" placeholder="이메일 검색" />
		    </div>
		    <div class="list">
		        <ul id="chattingRoomList">
		            <li id="chattingRoom" class="chattingRoom" onclick="getChatting(chattingRoom)">
		                <table cellpadding="0" cellspacing="0">
		                    <tr>
		                        <td class="profile_td">
		                            <img src="/resources/bj/image/chatting.png"/>
		                        </td>
		                        <td class="chat_td" style="vertical-align:top;">
		                        	<div class="chat_name">
		                        		전체 채팅방
		                        	</div>
		                        	
		                            <div class="email" id="chattingRoom_email">
		                                
		                            </div>
		                            
		                            <div class="chat_preview" id="chattingRoom_chat_preview">
		                               	 
		                            </div>
		                        </td>
		                        <td class="time_td">
		                            <div class="time" id="chattingRoom_time">
		                                
		                            </div>
		                            <div id="chattingRoom_check">
		                                
		                            </div>
		                        </td>
		                    </tr>
		                </table>
		            </li>
		        </ul>
		    </div>
		</div>
		
		<div id="contentCover" align="center" style="display:none;">
		    <div id="chatWrap">
		        <div id="chatHeader">
					
		        </div>
		        <div id="messages">
		            
		        </div>
		        <div id="messageForm">
		            <input type="text" autocomplete="off" size="30" id="messageInput" placeholder="메시지 입력">
		            <input type="button" value="보내기" id="sendBtn">
		        </div>
		    </div>
		</div>
	</div>
</div>
<img id="chatting" src="/resources/bj/image/chatting_floating.png" width="70" height="70" style="position:fixed; top: 85%; right : 4%; cursor:pointer;">
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script> -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
let csrfHeaderName = "${_csrf.headerName}";
let csrfTokenValue = "${_csrf.token}";
let messages = document.getElementById("messages");
let chattingRoomNum = chattingRoom.id;
let username = '${username}'
let stompClient = null;
let list_wrap = document.getElementById('chat_list_wrap');
let contentCover = document.getElementById('contentCover');
let chattingCheck = "${chattingCheck}";

//======================================================== 채팅방 리스트 가져오기

$(document).ready(function(){
	
	$.ajax({
		type : 'post',
		beforeSend: function(xhr){
    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    	},
		url  : '/member/getChattingRoom',
		data : 'username=' + '${username}',
		dataType : 'json',
		success : function(data){
			connect(chattingRoomNum);
			$.each(data.list, function(index, items){
				document.getElementById("chattingRoomList").innerHTML += "<li id='" + items.chattingRoom + "' onclick='getChatting(" + items.chattingRoom + ")'><table><tr><td class='profile_td'><img src='/resources/bj/image/chatting.png'/></td>"
																		+ "<td class='chat_td'><div class='chat_name'>" + items.chattingRoom + "</div><div id='" + items.chattingRoom + "_email' class='email'>" + items.nickname + "</div><div id='" + items.chattingRoom + "_chat_preview' class='chat_preview'>" + items.chat + "</div></td>"
																		+ "<td class='time_td'><div id='" + items.chattingRoom + "_time' class='time'>" + items.chat_date + "</div><div id='" + items.chattingRoom + "_check'></div></td></tr></table></li>";

				connect(items.chattingRoom);														

			});
			
		},
		error : function(err){
			console.log(err);
		}
	});
	
	$.ajax({
		type : 'get',
    	url : '/member/getAllChatting',
    	dataType : 'json',
    	success : function(data){
    		document.getElementById("chattingRoom_email").innerHTML += data.chattingRoomDTO.nickname;
    		document.getElementById("chattingRoom_time").innerHTML += data.chattingRoomDTO.chat_date;
    		document.getElementById("chattingRoom_chat_preview").innerHTML += data.chattingRoomDTO.chat;
    	}
	});
});

//======================================================== 채팅방 생성

$('#createChat').click(function(){
	$.ajax({
		type : 'get',
		url  : '/member/createChat',
		success : function(){
			$('<div/>', {
				text : '새 채팅방'
			}).appendTo($('#roomList'));
		}

	});
});

//======================================================== 채팅방 정보 가져오기

function getChatting(chattingRoom){
	list_wrap.style.display = 'none';
	contentCover.style.display = 'block';
	let messages = document.getElementById('messages');
	
	$.ajax({
		type : 'post',
		beforeSend: function(xhr){
    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    	},
		url  : '/member/getChatting',
		data : 'chattingRoom=' + chattingRoom.id,
		dataType : 'json',
		success : function(data){
			document.getElementById('chatHeader').innerHTML += chattingRoom.id + "<span id='close' onclick='roomList()' style='cursor: pointer;'>&times;</span>";
			
			$.each(data.list, function(index, items){
				if(username == items.username) {
					messages.innerHTML += "<div class='myMessage'><span class='message'>" + items.chat + "</span>"
										+ "<span class='date'>" + items.chat_date + "</span></div>";
					
				}else {
					messages.innerHTML += "<div class='otherMessage'><span class='otherName'>" + items.nickname + "</span>"
										+ "<span class='message'>" + items.chat + "</span>"
										+ "<span class='date'>" + items.chat_date + "</span></div>";
				}
			});
			
			document.getElementById("sendBtn").setAttribute("onclick", "send(" + chattingRoom.id + ")");
			document.getElementById("messageInput").setAttribute("onkeydown", "enterKey(" + chattingRoom.id + ")");
			document.getElementById('messages').scrollTop = document.getElementById('messages').scrollHeight;
		}
	});
}

function roomList(){
	$('#chatHeader').empty();
	$('#messages').empty();
	$('p#check').remove();
	
	list_wrap.style.display = 'block';
	contentCover.style.display = 'none';
}

//======================================================== Stomp, SockJS 

function connect(chattingRoom){
	let socket = new SockJS('/chat');
	stompClient = Stomp.over(socket);
	stompClient.connect({}, function(){
		setTimeout(function(){
			stompClient.subscribe('/topic/' + chattingRoom, onMessageReceived); 
		}, 100);
		/* 
		첫번째 매개변수는 구독할 주소를 말하고
		두번째 매개변수는 메시지를 받았을 때 수행할 메소드를 넣으면 된다.
		*/
	});
}

//======================================================= 메시지 보내기

function send(data){
	let chat = document.getElementById('messageInput').value;
	
	if(chat == null || chat == ""){
		return;
	}
	
	stompClient.send("/app/message", {}, JSON.stringify({'nickname' : '${nickname}', 'chat' : chat, 'chattingRoom' : data.id, 'username' : username }))
	document.getElementById("messageInput").value="";
	
	/*
	첫번째 인자는 spring controller mapping("/app"은 spring controller로 보낸다는 stomp prefix 규칙이다. 즉 /app 뒤가 진짜 mapping 주소)
	두번째 인자는 서버로 보낼 때 추가하고싶은 stomp 헤더이다.
	세번째 인자는 서버로 보낼 때 추가하고 싶은 stomp 바디이다. 서버 컨트롤러에서는 mapping 된 함수의 string 인자로 json stringify된 문자열을 받을 수 있다.
	*/
}

//============================================================ 웹소켓 연결 끊기

function disconnect() {
    if (stompClient != null) {
        stompClient.disconnect();
    }
    setConnected(false);
    console.log("Disconnected");
}

//============================================================= 메시지 받았을 때 수행하는 메서드

function onMessageReceived(payload){
	let message = JSON.parse(payload.body);
	let chat_preview = document.getElementById(message.chattingRoom + "_chat_preview");
	let email = document.getElementById(message.chattingRoom + "_email");
	let time = document.getElementById(message.chattingRoom + "_time");
	
	$('#' + message.chattingRoom + '_chat_preview').empty();
	$('#' + message.chattingRoom + '_email').empty();
	$('#' + message.chattingRoom + '_time').empty();
	
	if(username == message.username){
		messages.innerHTML += "<div class='myMessage'><span class='message'>" + message.chat + "</span>"
							 +"<span class='date'>" + message.chat_date +  "</span></div>" ;
							 
		chat_preview.innerHTML += message.chat;
		time.innerHTML += message.chat_date;
		email.innerHTML += message.nickname;
		
	}else {
		messages.innerHTML += "<div class='otherMessage'><span class='otherName'>" + message.nickname + "</span>"
							+ "<span class='message'>" + message.chat + "</span>"
							+ "<span class='date'>" + message.chat_date + "</span></div>" ;
							
		chat_preview.innerHTML += message.chat;
		time.innerHTML += message.chat_date;
		email.innerHTML += message.nickname;					
	}
	
	if(document.getElementById('check') == null){
		document.getElementById(message.chattingRoom + '_check').innerHTML += "<p id='check'></p>";
	}
	
	if(document.getElementById('modal').style.display == 'none'){
		toastr.options = {
				closeButton : true,
				onclick: function(){
					$('#modal').fadeIn();
					$('#chatting').fadeOut();
				},
				timeOut : 5000
		}
		toastr.success(message.chat, message.nickname);
	}
	
	document.getElementById('messages').scrollTop = document.getElementById('messages').scrollHeight;
}

//========================================================= 엔터키 설정

function enterKey(data){
	if(window.event.keyCode == 13){
		send(data);
	}
}

//========================================================== 모달창 관련

//Get the modal
let modal = document.getElementById('modal');

// Get the button that opens the modal
let chatting = document.getElementById("chatting");

// Get the <span> element that closes the modal
let span = document.getElementsByClassName("close")[0];   

// When the user clicks on the button, open the modal 
chatting.onclick = function() {
	$('#modal').fadeIn();
	$('#chatting').fadeOut();
}

// When the user clicks on <span> (x), close the modal
span.onclick = function() {
	$('#modal').fadeOut();
	$('#chatting').fadeIn();
}

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
    if (event.target == modal) {
    	$('#modal').fadeOut();
    	$('#chatting').fadeIn();
    }
}

</script>