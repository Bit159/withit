console.log("synergymap.js 연결 완료");
function xydbclose() {
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
	let loadingImage = document.getElementById('loading');
	loadingImage.style.display = "initial";
	let url = "/insertMatch";
	let options = {
		method: "POST",
		headers: {
			Accept: "application/json",
			"Content-Type": "application/json; charset=utf-8",
		},
		body: JSON.stringify(ob),
	};
	fetch(url, options).then((res) =>
		res.text().then((text) => {loadingImage.style.display = "none";alert(text);})
	);
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
		Math.sin(dLon / 2) *
		Math.sin(dLon / 2) *
		Math.cos(lat1) *
		Math.cos(lat2);
	var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	return earthRadiusKm * c;
}

function isCloseEnough(line1, line2, distance) {
	console.log(parseFloat(line1) + parseFloat(line2));
	console.log(parseFloat(distance * 1000));
	var result = false;
	if (
		parseFloat(line1) + parseFloat(line2) >=
		parseFloat(distance * 1000)
	)
		result = true;
	return result;
}


