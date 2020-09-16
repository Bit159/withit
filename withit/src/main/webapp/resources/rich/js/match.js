//목차
//1. 스윗얼럿
//2. GPS
//3. 지도 그리기
//4. 마커표시
//5. 검색기능
//6. 원 그리기
//7. 오버레이
let options = undefined;

function setOnline(){
	document.getElementById('x').value = 0;
	document.getElementById('y').value = 0;
	document.getElementById('range').value = 0;
}

function insertMatch() {
  Swal.mixin({
    confirmButtonText: "다음 &rarr;",
    cancelButtonText: "취소",
    showCancelButton: true,
    progressSteps: ["1", "2", "3", "4", "5"],
    allowOutsideClick: false,
  })
    .queue([
      {
        title: "지역 선택",
        html:
          `<div>주소 검색 후 좌,우 클릭을 이용해<br> 희망 매칭 반경을 그려주세요</div>` +
          `<div id="map" style="width: 100%; height: 400px; margin-top:10px;"></div>` +
          `<div id ="wrapper">` +
          `<input type="text" id="search" placeholder="희망지역을 검색하세요">` +
          `&emsp;` +
          `<button type="button" id="searchButton">검색</button><br><br>` +
          `&emsp;` +
          `<button type="button" id="onlineButton" onclick="setOnline()">온라인</button><br><br>` +
          `</div>` +
          `<input type="hidden" id="x" />` +
          `<input type="hidden" id="y" />` +
          `<input type="hidden" id="range" />`,
        showCancelButton: true,
        preConfirm: () => {
          let x = document.getElementById("x").value;
          let y = document.getElementById("y").value;
          let range = document.getElementById("range").value;
          if (x === "") {
            Swal.fire(
              "지역 선택",
              "희망 지역을 설정해주세요",
              "error"
            ).then(() => document.getElementById("key").click());
          } else {
            return [
              document.getElementById("x").value,
              document.getElementById("y").value,
              document.getElementById("range").value,
            ];
          }
        },
      },
      {
        title: "시간 선택",
        input: "select",
        inputOptions: {
          "평일 낮": "평일 낮",
          "평일 저녁": "평일 저녁",
          "주말 낮": "주말 낮",
          "주말 저녁": "주말 저녁",
        },
        text: "매칭 희망 시간대를 선택하세요",
        showCancelButton: true,
      },
      {
        title: "주제 선택",
        input: "select",
        inputOptions: {
          모각코: "모각코",
          Algorithm: "Algorithm",
          Java: "Java",
          Python: "Python",
          C: "C",
          "C++": "C++",
          "C#": "C#",
          JavaScript: "JavaScript",
          React: "React",
          Vue: "Vue",
          Spring: "Spring",
          SpringBoot: "SpringBoot",
          SQL: "SQL",
          iOS: "iOS",
          Android: "Android",
          FrontEnd: "FrontEnd",
          BackEnd: "BackEnd",
          "Toy Project": "Toy Project",
        },
        text: "매칭 희망 주제를 선택하세요",
        showCancelButton: true,
      },
      {
        title: "인원 선택",
        input: "select",
        inputOptions: {
          3: "3명",
          6: "4명~6명",
          9: "7명~9명",
          10: "10명 이상",
        },
        text: "매칭 희망 인원을 선택하세요",
        showCancelButton: true,
      },
      {
        title: "경력 선택",
        input: "select",
        inputOptions: {
          '0~2': "0~2년",
          '2~5': "2~5년",
          '5~10': "5~10년",
          '10~': "10년 이상",
        },
        text: "매칭 희망 경력을 선택하세요",
        showCancelButton: true,
      },
    ])
    .then(result => {
      if (result.value) {
        let x = parseFloat(result.value[0][0]).toFixed(2);
        let y = parseFloat(result.value[0][1]).toFixed(2);
        let range = parseFloat(result.value[0][2] / 1000.0).toFixed(2);
        let time = result.value[1];
        let topic = result.value[2];
        let people = result.value[3];
		let career = result.value[4];
        const answers = JSON.stringify(result.value);
		let place = undefined;
		if(x == '0.00') {
			place = `<span>온라인</span>`;
		}else {
			place = `<span>위도: ${x}&emsp;</span><span>경도: ${y}&emsp;</span><span>반경: ${range}km&emsp;</span><br>`;
		}
        Swal.fire({
          title: "등록 확인",
          icon: "info",
          html: 
		  `${place}<p>시간대: ${time}&emsp;</p><p>주제: ${topic}&emsp;</p><p>인원: ${people}명&emsp;</p><p>경력: ${career}년</p>`,
          confirmButtonText: "등록하기",
          cancelButtonText: "취소",
          showCancelButton: true,
        }).then(res => {
          if (res.isConfirmed) {
			let ob = new Object();
			ob.x = result.value[0][0];
			ob.y = result.value[0][1];
			ob.range = result.value[0][2];
			ob.time = result.value[1];
			ob.topic = result.value[2];
			ob.people = result.value[3];
			ob.career = result.value[4].split('~')[0];
			
			console.log(result.value[0][2]);
			let url = "/insertMatch";
			options = myOptions(ob);

			fetch(url, options).then(res=>res.json().then(json=>{
				Swal.fire('등록 완료', '등록을 완료하였습니다', 'success')
				.then(res=>location.href="/match");
			}));

          } else {
            Swal.fire("등록 취소", "등록을 취소하였습니다", "error");
          }
        });
      } else {
        Swal.fire("등록 취소", "등록을 취소하였습니다", "error");
      }
    });
}

function getLocation() {
  if (navigator.geolocation) {
    // GPS를 지원하면
    navigator.geolocation.getCurrentPosition(
      function (position) {
        map.setLevel(5);
        map.setCenter(
          new kakao.maps.LatLng(
            position.coords.latitude,
            position.coords.longitude
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

let infowindow = undefined;
let mapContainer = undefined;
let map = undefined;
let control = undefined;
let ps = undefined;
let marker = undefined;
let markers = new Array();

//스윗 얼럿이 열렸을 때 지도를 그려줄 함수입니다.
function drawMap() {
  // 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
  infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

  (mapContainer = document.getElementById("map")), // 지도를 표시할 div
    (mapOption = {
      center: new kakao.maps.LatLng(36.536826, 127.5786567), // 지도의 중심좌표
      level: 15, // 지도의 확대 레벨
    });

  // 지도를 생성합니다
  map = new kakao.maps.Map(mapContainer, mapOption);

  control = new kakao.maps.ZoomControl();
  map.addControl(control, kakao.maps.ControlPosition.TOPRIGHT);

  // 장소 검색 객체를 생성합니다
  ps = new kakao.maps.services.Places();
}

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
  if (status === kakao.maps.services.Status.OK) {
    // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
    // LatLngBounds 객체에 좌표를 추가합니다
    var bounds = new kakao.maps.LatLngBounds();

    for (var i = 0; i < data.length; i++) {
      displayMarker(data[i]);
      bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
    }

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
  }
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
  // 마커를 생성하고 지도에 표시합니다
  marker = new kakao.maps.Marker({
    map: map,
    position: new kakao.maps.LatLng(place.y, place.x),
  });
  markers.push(marker);

  // 마커에 클릭이벤트를 등록합니다
  kakao.maps.event.addListener(marker, "click", function () {
    // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
    infowindow.setContent(
      '<div style="padding:5px;font-size:12px;">' + place.place_name + "</div>"
    );
    infowindow.open(map, marker);
  });
}

//검색 기능을 연결해주는 함수입니다
function searchFunction() {
  let button = document.getElementById("searchButton");
  let query = document.getElementById("search");
  //검색 버튼에 클릭 이벤트를 연결합니다
  button.addEventListener("click", () => {
    ps.keywordSearch(query.value, placesSearchCB);
    setTimeout(() => {
      markers.forEach((e) => {
        e.setMap(null);
      });
    }, 1000);
  });
  //input 영역에 엔터키 이벤트를 연결합니다.
  query.addEventListener("keydown", () => {
    if (event.keyCode === 13) {
      ps.keywordSearch(query.value, placesSearchCB);
      setTimeout(() => {
        markers.forEach((e) => {
          e.setMap(null);
        });
      }, 1000);
    }
  });
}

//------------------지도 검색까지 완료------------------

//-------------------그림 그리기 시작-----------------
var drawingFlag = false; // 원이 그려지고 있는 상태를 가지고 있을 변수입니다
var centerPosition; // 원의 중심좌표 입니다
var drawingCircle; // 그려지고 있는 원을 표시할 원 객체입니다
var drawingLine; // 그려지고 있는 원의 반지름을 표시할 선 객체입니다
var drawingOverlay; // 그려지고 있는 원의 반경을 표시할 커스텀오버레이 입니다
var drawingDot; // 그려지고 있는 원의 중심점을 표시할 커스텀오버레이 입니다

var circles = []; // 클릭으로 그려진 원과 반경 정보를 표시하는 선과 커스텀오버레이를 가지고 있을 배열입니다

function addDrawFunction() {
  // 지도에 클릭 이벤트를 등록합니다
  kakao.maps.event.addListener(map, "click", function (mouseEvent) {
    //이미 그려진 원이 있다면 제거하기
    if (circles.length !== 0) {
      circles.forEach((e) => {
        e.polyline.setMap(null);
        e.circle.setMap(null);
        e.overlay.setMap(null);
        circles.pop(e);
      });
    }

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
            '<div class="info">반경<span class="number">' +
            radius +
            "</span>m<div>우클릭으로 완료</div></div>";
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
    // 거리와 도보 시간, 자전거 시간을 가지고 HTML Content를 만들어 리턴합니다
    var content = '<ul class="info">';
    content += "<li>";
    content +=
      '<span class="label">위도 &emsp;</span><span class="number">' +
      drawingCircle.getPosition().Ha.toFixed(4) +
      "</span>";
    content += "</li>";
    content += "<li>";
    content +=
      '<span class="label">경도 &emsp;</span><span class="number">' +
      drawingCircle.getPosition().Ga.toFixed(4) +
      "</span>";
    content += "</li>";
    content += "<li>";
    content +=
      '<span class="label">반경 &emsp;</span><span class="number">' +
      (distance / 1000.0).toFixed(2) +
      "</span>&emsp;km";
    content += "</li>";
    content += "</ul>";
    document.getElementById("x").value = drawingCircle.getPosition().Ha;
    document.getElementById("y").value = drawingCircle.getPosition().Ga;
    document.getElementById("range").value = distance;
    return content;
  }
}
