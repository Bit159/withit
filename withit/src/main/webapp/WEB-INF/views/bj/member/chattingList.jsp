<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/resources/bj/css/chattingList.css"/>
<link rel="stylesheet" type="text/css" href="/resources/bj/css/toastr.min.css"/>
<script defer type="text/javascript" src="/resources/bj/js/sockjs.min.js"></script>
<script defer type="text/javascript" src="/resources/bj/js/stomp.min.js"></script>
<script defer type="text/javascript" src="/resources/bj/js/toastr.min.js"></script>
<sec:authentication property="principal.username" var="username"/>
<input type="hidden" name="username" value="${username}"/>
<input type="hidden" name="nickname" value="${nickname }"/>
<input type="hidden" id="_csrf.token" value="${_csrf.token}"/>
<input type="hidden" id="_csrf.headerName" value="${_csrf.headerName}"/>
<div class="modal" id="modal" style="display:none;">
	<div id="modal-content" class="modal-content">
		<span class="close">&times;</span>
		<div class="chat_list_wrap" id="chat_list_wrap">
		    <div class="header">
		        withIT
		    </div>
		    <div class="search">
		        <input type="text"/>
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
					<ul id="chatHeader_ul" style="cursor:pointer;">
						<li id="li" class="hide">채팅방 나가기</li>
					</ul>
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
<div id="contextMenu" style="display:none;">
	<ul>
		<li>메뉴1</li>
		<li>메뉴2</li>
	</ul>
</div>
<img id="chatting" src="/resources/bj/image/chatting_floating.png" width="70" height="70" style="position:fixed; top: 85%; right : 4%; cursor:pointer;">
<!-- <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script> -->
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/resources/bj/js/chattingList.js"></script>
<script>
$(document).ready(function(){
    $("#chatHeader_ul").click(function(){
        //$(this).next("ul").toggleClass("hide");
        $("#li").toggleClass("hide");
    });
});

/*function handleCreateContextMenu(event){
	event.preventDefault();
	
	const contextMenu = document.getElementById("contextMenu");
	
	contextMenu.style.display = 'block';
	
	contextMenu.style.top = event.pageY + "px";
	contextMenu.style.left = event.pageX + "px";
	
}

function handleClearContextMenu(event){
	const contextMenu = document.getElementById("contextMenu");
	
	contextMenu.style.display = 'none';
	contextMenu.style.top = null;
	contextMenu.style.left = null;
	
}

document.addEventListener('contextmenu', handleCreateContextMenu, false);
document.addEventListener('click', handleClearContextMenu, false);
*/

</script>