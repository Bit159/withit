let csrfHeaderName = document.getElementById("_csrf.headerName").value;
let csrfTokenValue = document.getElementById("_csrf.token").value;
let messages = document.getElementById("messages");
let chattingRoomNum = chattingRoom.id;
let username = document.querySelector("input[name=username]").value;
let nickname = document.querySelector("input[name=nickname]").value;
let stompClient = null;
let list_wrap = document.getElementById('chat_list_wrap');
let contentCover = document.getElementById('contentCover');

//======================================================== 채팅방 리스트 가져오기

$(document).ready(function(){
	$.ajax({
		type : 'post',
		beforeSend: function(xhr){
    		xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
    	},
		url  : '/member/getChattingRoom',
		data : 'username=' + username,
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
			document.getElementById('chatHeader_ul').innerHTML += chattingRoom.id + "<span id='close' onclick='roomList()' style='cursor: pointer;'>&times;</span>";
			
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
	$('#chatHeader_ul').empty();
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
		}, 500);
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
	
	stompClient.send("/app/message", {}, JSON.stringify({'nickname' : nickname, 'chat' : chat, 'chattingRoom' : data.id, 'username' : username }))
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
		console.log(message.chattingRoom);
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