<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>    

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
    #chatWrap{
        width :400px;
        border : 1px solid #ddd;
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
        height: 500px;
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
        margin-bottom: 10px;
        margin-top: 5px;
    }

    .otherMessage > .message{
        background-color: #f1f0f0;
    }

    .myMessage > .message{
        background-color: #32be78;
    }

    .otherName{
        font-size: 12px;
        display: block;
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

    #messageForm > input[type=submit]{
        outline: none;
        border : none;
        background :none;
        color : #32be78;
        font-size: 17px;
        cursor: pointer;
    }
</style>
</head>
<body>
<sec:authentication property="principal.username" var="username"/>
<div id="contentCover" align="center">
    <div id="chatWrap">
        <div id="chatHeader">
			채팅방 이름
        </div>
        <div id="messages">
            <div class="otherMessage">
                <span class="otherName">byungjoo104@gmail.com</span>
                <span class="message">앙뇽하세용</span>
                <span class="otherName">byungjoo3011@naver.com</span>
                <span class="message">가나다라마바사아차카타파하오렌지먹고싶다바나나먹고싶다고양이멍멍이</span>
            </div>
            <div class="myMessage">
                <span class="message">네 안녕하세용</span>

            </div>
        </div>
        <form id="messageForm">
            <input type="text" autocomplete="off" size="30" id="messageInput" placeholder="메시지 입력">
            <input type="submit" value="보내기">
        </form>
    </div>
</div>
</body>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<script type="text/javascript">
</script>
</html>