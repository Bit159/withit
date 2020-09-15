<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>매칭 지역 설정</title>
    <link rel="stylesheet" href="/resources/css/myLocation.css" />
    <link rel="shortcut icon" href="/resources/image/symbol.png">
  </head>
  <body>
    <input type="hidden" name="x" id="x" value="33.450701" />
    <input type="hidden" name="y" id="y" value="126.570667" />
    <div id="map" style="width: 80%; height: 500px;"></div>
    <p><button onclick="removeCircles()">모두 지우기</button> <br /></p>
    <em>
      지도를 마우스로 클릭하면 원 그리기가 시작되고 <br />
      오른쪽 마우스를 클릭하면 원 그리기가 종료됩니다
    </em>
    <p>설정이 완료되었을 경우 아래 완료 버튼을 눌러주세요</p>
    <button type="button" onclick="locationSelected()">지역설정완료</button>
    <script src="//dapi.kakao.com/v2/maps/sdk.js?appkey=41be22a5170d5fc6115853c77dc3d45e"></script>
    <script src="/resources/js/myLocation.js"></script>
  </body>
</html>
