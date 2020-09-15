let x = 37.528129;
let y = 126.981729;
let lv = 8;
switch (window.opener.document.getElementById("myLocation").value) {
  case "서울": {
    x = 37.528129;
    y = 126.981729;
    lv = 8;
    break;
  }
  case "경기": {
    x = 37.275034;
    y = 127.009456;
    lv = 8;
    break;
  }
  case "인천": {
    x = 37.455826;
    y = 126.705916;
    lv = 9;
    break;
  }
  case "대전": {
    x = 36.350336;
    y = 127.38484;
    lv = 8;
    break;
  }
  case "대구": {
    x = 35.869681;
    y = 128.601611;
    lv = 7;
    break;
  }
  case "부산": {
    x = 35.171093;
    y = 129.060777;
    lv = 9;
    break;
  }
  case "울산": {
    x = 35.545271;
    y = 129.272534;
    lv = 9;
    break;
  }
  case "광주": {
    x = 35.152137;
    y = 126.836761;
    lv = 7;
    break;
  }
  case "강원": {
    x = 37.885536;
    y = 127.729733;
    lv = 9;
    break;
  }
  case "세종": {
    x = 36.4807;
    y = 127.289019;
    lv = 9;
    break;
  }
  case "충북": {
    x = 36.635826;
    y = 127.491345;
    lv = 8;
    break;
  }
  case "충남": {
    x = 36.659095;
    y = 126.672876;
    lv = 8;
    break;
  }
  case "경북": {
    x = 36.57609;
    y = 128.505574;
    lv = 8;
    break;
  }
  case "경남": {
    x = 35.238238;
    y = 128.692441;
    lv = 8;
    break;
  }
  case "전북": {
    x = 35.820351;
    y = 127.108706;
    lv = 8;
    break;
  }
  case "전남": {
    x = 34.816113;
    y = 126.462924;
    lv = 8;
    break;
  }
  case "제주": {
    x = 33.387044;
    y = 126.54398;
    lv = 9;
    break;
  }
  default: {
  }
}
var mapContainer = document.getElementById("map"), // 지도를 표시할 div
  mapOption = {
    //center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
    center: new kakao.maps.LatLng(x, y), // 지도의 중심좌표
    level: lv, // 지도의 확대 레벨
  };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

var drawingFlag = false; // 원이 그려지고 있는 상태를 가지고 있을 변수입니다
var centerPosition; // 원의 중심좌표 입니다
var drawingCircle; // 그려지고 있는 원을 표시할 원 객체입니다
var drawingLine; // 그려지고 있는 원의 반지름을 표시할 선 객체입니다
var drawingOverlay; // 그려지고 있는 원의 반경을 표시할 커스텀오버레이 입니다
var drawingDot; // 그려지고 있는 원의 중심점을 표시할 커스텀오버레이 입니다

var circles = []; // 클릭으로 그려진 원과 반경 정보를 표시하는 선과 커스텀오버레이를 가지고 있을 배열입니다

// 지도에 클릭 이벤트를 등록합니다
kakao.maps.event.addListener(map, "click", function (mouseEvent) {
  // 클릭 이벤트가 발생했을 때 원을 그리고 있는 상태가 아니면 중심좌표를 클릭한 지점으로 설정합니다
  if (!drawingFlag) {
    // 상태를 그리고있는 상태로 변경합니다
    drawingFlag = true;

    // 원이 그려질 중심좌표를 클릭한 위치로 설정합니다
    centerPosition = mouseEvent.latLng;

    // 그려지고 있는 원의 반경을 표시할 선 객체를 생성합니다
    if (!drawingLine) {
      drawingLine = new kakao.maps.Polyline({
        strokeWeight: 3, // 선의 두께입니다
        strokeColor: "#00a0e9", // 선의 색깔입니다
        strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
        strokeStyle: "solid", // 선의 스타일입니다
      });
    }

    // 그려지고 있는 원을 표시할 원 객체를 생성합니다
    if (!drawingCircle) {
      drawingCircle = new kakao.maps.Circle({
        strokeWeight: 1, // 선의 두께입니다
        strokeColor: "#00a0e9", // 선의 색깔입니다
        strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
        strokeStyle: "solid", // 선의 스타일입니다
        fillColor: "#00a0e9", // 채우기 색깔입니다
        fillOpacity: 0.2, // 채우기 불투명도입니다
      });
    }

    // 그려지고 있는 원의 반경 정보를 표시할 커스텀오버레이를 생성합니다
    if (!drawingOverlay) {
      drawingOverlay = new kakao.maps.CustomOverlay({
        xAnchor: 0,
        yAnchor: 0,
        zIndex: 1,
      });
    }
  }
});

// 지도에 마우스무브 이벤트를 등록합니다
// 원을 그리고있는 상태에서 마우스무브 이벤트가 발생하면 그려질 원의 위치와 반경정보를 동적으로 보여주도록 합니다
kakao.maps.event.addListener(map, "mousemove", function (mouseEvent) {
  // 마우스무브 이벤트가 발생했을 때 원을 그리고있는 상태이면
  if (drawingFlag) {
    // 마우스 커서의 현재 위치를 얻어옵니다
    var mousePosition = mouseEvent.latLng;

    // 그려지고 있는 선을 표시할 좌표 배열입니다. 클릭한 중심좌표와 마우스커서의 위치로 설정합니다
    var linePath = [centerPosition, mousePosition];

    // 그려지고 있는 선을 표시할 선 객체에 좌표 배열을 설정합니다
    drawingLine.setPath(linePath);

    // 원의 반지름을 선 객체를 이용해서 얻어옵니다
    var length = drawingLine.getLength();

    if (length > 0) {
      // 그려지고 있는 원의 중심좌표와 반지름입니다
      var circleOptions = {
        center: centerPosition,
        radius: length,
      };

      // 그려지고 있는 원의 옵션을 설정합니다
      drawingCircle.setOptions(circleOptions);

      // 반경 정보를 표시할 커스텀오버레이의 내용입니다
      var radius = Math.round(drawingCircle.getRadius()),
        content =
          '<div class="info">반경 <span class="number">' +
          radius +
          "</span>m</div>";

      // 반경 정보를 표시할 커스텀 오버레이의 좌표를 마우스커서 위치로 설정합니다
      drawingOverlay.setPosition(mousePosition);

      // 반경 정보를 표시할 커스텀 오버레이의 표시할 내용을 설정합니다
      drawingOverlay.setContent(content);

      // 그려지고 있는 원을 지도에 표시합니다
      drawingCircle.setMap(map);

      // 그려지고 있는 선을 지도에 표시합니다
      drawingLine.setMap(map);

      // 그려지고 있는 원의 반경정보 커스텀 오버레이를 지도에 표시합니다
      drawingOverlay.setMap(map);
    } else {
      drawingCircle.setMap(null);
      drawingLine.setMap(null);
      drawingOverlay.setMap(null);
    }
  }
});

// 지도에 마우스 오른쪽 클릭이벤트를 등록합니다
// 원을 그리고있는 상태에서 마우스 오른쪽 클릭 이벤트가 발생하면
// 마우스 오른쪽 클릭한 위치를 기준으로 원과 원의 반경정보를 표시하는 선과 커스텀 오버레이를 표시하고 그리기를 종료합니다
kakao.maps.event.addListener(map, "rightclick", function (mouseEvent) {
  if (drawingFlag) {
    // 마우스로 오른쪽 클릭한 위치입니다
    var rClickPosition = mouseEvent.latLng;

    // 원의 반경을 표시할 선 객체를 생성합니다
    var polyline = new kakao.maps.Polyline({
      path: [centerPosition, rClickPosition], // 선을 구성하는 좌표 배열입니다. 원의 중심좌표와 클릭한 위치로 설정합니다
      strokeWeight: 3, // 선의 두께 입니다
      strokeColor: "#00a0e9", // 선의 색깔입니다
      strokeOpacity: 1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
      strokeStyle: "solid", // 선의 스타일입니다
    });

    // 원 객체를 생성합니다
    var circle = new kakao.maps.Circle({
      center: centerPosition, // 원의 중심좌표입니다
      radius: polyline.getLength(), // 원의 반지름입니다 m 단위 이며 선 객체를 이용해서 얻어옵니다
      strokeWeight: 1, // 선의 두께입니다
      strokeColor: "#00a0e9", // 선의 색깔입니다
      strokeOpacity: 0.1, // 선의 불투명도입니다 0에서 1 사이값이며 0에 가까울수록 투명합니다
      strokeStyle: "solid", // 선의 스타일입니다
      fillColor: "#00a0e9", // 채우기 색깔입니다
      fillOpacity: 0.2, // 채우기 불투명도입니다
    });

    var radius = Math.round(circle.getRadius()), // 원의 반경 정보를 얻어옵니다
      content = getTimeHTML(radius); // 커스텀 오버레이에 표시할 반경 정보입니다

    // 반경정보를 표시할 커스텀 오버레이를 생성합니다
    var radiusOverlay = new kakao.maps.CustomOverlay({
      content: content, // 표시할 내용입니다
      position: rClickPosition, // 표시할 위치입니다. 클릭한 위치로 설정합니다
      xAnchor: 0,
      yAnchor: 0,
      zIndex: 1,
    });

    // 원을 지도에 표시합니다
    circle.setMap(map);

    // 선을 지도에 표시합니다
    polyline.setMap(map);

    // 반경 정보 커스텀 오버레이를 지도에 표시합니다
    radiusOverlay.setMap(map);

    // 배열에 담을 객체입니다. 원, 선, 커스텀오버레이 객체를 가지고 있습니다
    var radiusObj = {
      polyline: polyline,
      circle: circle,
      overlay: radiusOverlay,
    };

    // 배열에 추가합니다
    // 이 배열을 이용해서 "모두 지우기" 버튼을 클릭했을 때 지도에 그려진 원, 선, 커스텀오버레이들을 지웁니다
    circles.push(radiusObj);

    // 그리기 상태를 그리고 있지 않는 상태로 바꿉니다
    drawingFlag = false;

    // 중심 좌표를 초기화 합니다
    centerPosition = null;

    // 그려지고 있는 원, 선, 커스텀오버레이를 지도에서 제거합니다
    drawingCircle.setMap(null);
    drawingLine.setMap(null);
    drawingOverlay.setMap(null);
  }
});

// 지도에 표시되어 있는 모든 원과 반경정보를 표시하는 선, 커스텀 오버레이를 지도에서 제거합니다
function removeCircles() {
  for (var i = 0; i < circles.length; i++) {
    circles[i].circle.setMap(null);
    circles[i].polyline.setMap(null);
    circles[i].overlay.setMap(null);
  }
  circles = [];
}

// 마우스 우클릭 하여 원 그리기가 종료됐을 때 호출하여
// 그려진 원의 반경 정보와 반경에 대한 도보, 자전거 시간을 계산하여
// HTML Content를 만들어 리턴하는 함수입니다
function getTimeHTML(distance) {
  // 도보의 시속은 평균 4km/h 이고 도보의 분속은 67m/min입니다
  var walkkTime = (distance / 67) | 0;
  var walkHour = "",
    walkMin = "";

  // 계산한 도보 시간이 60분 보다 크면 시간으로 표시합니다
  if (walkkTime > 60) {
    walkHour =
      '<span class="number">' + Math.floor(walkkTime / 60) + "</span>시간 ";
  }
  walkMin = '<span class="number">' + (walkkTime % 60) + "</span>분";

  // 자전거의 평균 시속은 16km/h 이고 이것을 기준으로 자전거의 분속은 267m/min입니다
  var bycicleTime = (distance / 227) | 0;
  var bycicleHour = "",
    bycicleMin = "";

  // 계산한 자전거 시간이 60분 보다 크면 시간으로 표출합니다
  if (bycicleTime > 60) {
    bycicleHour =
      '<span class="number">' + Math.floor(bycicleTime / 60) + "</span>시간 ";
  }
  bycicleMin = '<span class="number">' + (bycicleTime % 60) + "</span>분";

  // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
		  var content = '<ul class="info">';
		  content += "    <li>";
		  content +=
		    '        <span class="label">총거리</span><span class="number">' +
		    distance +
		    "</span>m";
		  content += "    </li>";
		  content += "    <li>";
		  content += '        <span class="label">도보</span>' + walkHour + walkMin;
		  content += "    </li>";
		  content += "    <li>";
		  content +=
		    '        <span class="label">자전거</span>' + bycicleHour + bycicleMin;
		  content += "    </li>";
		  content += "</ul>";

  return content;
}

function getLocation() {
  if (navigator.geolocation) {
    // GPS를 지원하면
    navigator.geolocation.getCurrentPosition(
      function (position) {
        console.log(position.coords.latitude + " " + position.coords.longitude);
        document.getElementById("x").value = position.coords.latitude;
        document.getElementById("y").value = position.coords.longitude;
        map.setCenter(
          new kakao.maps.LatLng(
            document.getElementById("x").value,
            document.getElementById("y").value
          )
        );
      },
      function (error) {
        console.error(error);
      },
      {
        enableHighAccuracy: false,
        maximumAge: 0,
        timeout: Infinity,
      }
    );
  } else {
    console.log("GPS를 지원하지 않습니다");
  }
}
getLocation();

function locationSelected() {
  if (circles.length === 0) {
    alert("먼저 지역을 선택해주세요");
    return;
  }

  if (circles.length > 1) {
    alert("한 개의 지역만 선택 가능합니다?");
    removeCircles();
    return;
  }

  let x = circles[0].circle.getPosition().Ga;
  let y = circles[0].circle.getPosition().Ha;
  let range = circles[0].polyline.getLength();

  let ob = new Object();
  ob.x = x;
  ob.y = y;
  ob.range = range;
  alert(
    "선택하신 결과입니다. 경도x: " +
      ob.x +
      "  위도y: " +
      ob.y +
      "   범위range(m): " +
      ob.range
  );
  window.opener.document.getElementById("x").value = x;
  window.opener.document.getElementById("y").value = y;
  window.opener.document.getElementById("range").value = range;
  window.opener.document.getElementById('locationSpan').style.display="initial";
  window.close();
}

function degreesToRadians(degrees) {
  return (degrees * Math.PI) / 180;
}

function distanceInKmBetweenEarthCoordinates(lat1, lon1, lat2, lon2) {
  var earthRadiusKm = 6371;

  var dLat = degreesToRadians(lat2 - lat1);
  var dLon = degreesToRadians(lon2 - lon1);

  lat1 = degreesToRadians(lat1);
  lat2 = degreesToRadians(lat2);

  var a =
    Math.sin(dLat / 2) * Math.sin(dLat / 2) +
    Math.sin(dLon / 2) * Math.sin(dLon / 2) * Math.cos(lat1) * Math.cos(lat2);
  var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
  return earthRadiusKm * c;
}
