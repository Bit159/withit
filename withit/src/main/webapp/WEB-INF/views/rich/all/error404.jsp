<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
  	<%@ include file="/WEB-INF/views/kh/template/head.jsp" %>
    <link href="https://fonts.googleapis.com/css2?family=Nunito+Sans:wght@600;900&display=swap" rel="stylesheet" />
    <script src="https://kit.fontawesome.com/4b9ba14b0f.js" crossorigin="anonymous"></script>
    <style>
      * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
      }
      body {
        background-color: #32be78;
      }
      div[class="error404"] {
        font-size: 10rem;
        color: white;
        font-family: "Poppins", sans-serif;
        margin: 0 auto;
        width: 500px;
        text-align: center;
      }

      div[id="nodataImage"] {
        background-image: url("/resources/rich/image/nodatasmall.png");
        background-size: contain;
        background-repeat: no-repeat;
        background-position: center;
        width: 300px;
        height: 300px;
        margin: 0 auto;
        margin-top: -35px;
      }
      div[class="msg"] {
        width: 500px;
        margin: 0 auto;
        font-size: 2rem;
        text-align: center;
        color: white;
        font-weight: 600;
        text-shadow: gray 10px 2px 20px;
        margin-top: -20px;
      }
      button {
        margin-top: 30px;
        text-decoration: none;
        padding: 1rem 3rem;
        color: black;
        background: #fff;
        border-radius: 1rem;
        font-size: 1.5rem;
        font-weight: bold;
        cursor: pointer;
        border: none;
        box-shadow: 0 3px 3px 0 rgba(0, 0, 0, 0.2),
          0 4px 10px 0 rgba(0, 0, 0, 0.19);
      }
      button[id="back"] {
        margin-left: 20px;
      }
    </style>
  </head>
  <body>
    <div class="error404">
      4&nbsp;<i class="far fa-question-circle fa-spin"></i>&nbsp;4
     </div>
    <div id="nodataImage"></div>
    <div class="msg">존재하지 않는 페이지 입니다
      <p>
         <button onclick="location.href='/'">Home</button>
         <button id="back" onclick="javascript:history.back()">Back</button>
      </p>
    </div>
  </body>
</html>