function myGroupMap(group, mapdiv) {

	let arr = group;
	
	var mapContainer = mapdiv, // 지도를 표시할 div
		mapOption = {
			center: new kakao.maps.LatLng(arr[0].x, arr[0].y), // 지도의 중심좌표
			level: 7, // 지도의 확대 레벨
		};
	
	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	for(let i =0; i <arr.length; i++) {
		drawCircle(arr[i].x, arr[i].y, arr[i].range);
	}
	drawInfo();

	function drawInfo() {
		let circles = document.querySelectorAll(`#map${arr[0].gno} ellipse`);
	
		circles.forEach(function(e, index){
			getInfo(e, index);
		});
		
		circles.forEach(function(e, index){
			e.addEventListener('mouseover', function(e){
				let top = this.getBoundingClientRect().top;
				let left = this.getBoundingClientRect().left;
				document.querySelectorAll(`#map${arr[0].gno} ul.info`)[index].style.top = (top-75)+'px';
				document.querySelectorAll(`#map${arr[0].gno} ul.info`)[index].style.left = left+'px';
				document.querySelectorAll(`#map${arr[0].gno} ul.info`)[index].style.display = "initial";
			});
			e.addEventListener('mouseout', function(){
				document.querySelectorAll(`#map${arr[0].gno} ul.info`)[index].style.display = "none";
				});
		});
	}

	function getInfo(ellipse, index) {
		let aa = new Date(arr[index].created.time);
		let month = '0';
		if((aa.getMonth()+1) < 10) month = '0'+(aa.getMonth()+1);
		else month = (aa.getMonth()+1);
		let minutes = '0';
		if((aa.getMinutes()) < 10) minutes = '0'+(aa.getMinutes());
		else minutes = (aa.getMinutes());
		let seconds = '0';
		if((aa.getSeconds()) < 10) seconds = '0'+(aa.getSeconds());
		else seconds = (aa.getSeconds());
		let created = aa.getFullYear()+'.'+month+'.'+aa.getDate()+' '+aa.getHours()+':'+minutes+':'+seconds;
		
		let ul = document.createElement('ul');
		ul.className = 'info';
		
		let li1 = document.createElement('li');
		let span1 = document.createElement('span');
		span1.className = 'label';
		span1.appendChild(document.createTextNode('닉네임  '));
		let span2 = document.createElement('span');
		span2.className = 'number';
		span2.append(document.createTextNode(arr[index].nickname));
		li1.append(span1, span2);
		
		let li2 = document.createElement('li');
		let span3 = document.createElement('span');
		span3.append(document.createTextNode('주제  '));
		span3.className = 'label';
		let span4 = document.createElement('span');
		span4.className = 'number';
		span4.append(document.createTextNode(arr[index].topic));
		li2.append(span3, span4);
		
		let li3 = document.createElement('li');
		let span5 = document.createElement('span');
		span5.className = 'label';
		span5.append(document.createTextNode('시간대'));
		let span6 = document.createElement('span');
		span6.append(document.createTextNode(arr[index].time));
		li3.append(span5, span6);
		
		let li4 = document.createElement('li');
		let span7 = document.createElement('span');
		span7.className = 'label';
		span7.append(document.createTextNode('생성일'));
		let span8 = document.createElement('span');
		span8.append(document.createTextNode(created));
		li4.append(span7, span8);
		
		ul.append(li1, li2, li3, li4);
		mapdiv.append(ul);
	}



	// 지도에 표시할 원을 생성합니다
	function drawCircle(y, x, range) {
		var circle = new kakao.maps.Circle({
			center: new kakao.maps.LatLng(y, x), // 원의 중심좌표 입니다
			radius: range, // 미터 단위의 원의 반지름입니다
			strokeWeight: 3, // 선의 두께입니다
			strokeColor: "#32be78", // 선의 색깔입니다
			strokeOpacity: 1, // 선의 불투명도 입니다 1에서 0 사이의 값이며 0에 가까울수록 투명합니다
			strokeStyle: "solid", // 선의 스타일 입니다
			fillColor: "#CFE7FF", // 채우기 색깔입니다CFE7FF
			fillOpacity: 0.4, // 채우기 불투명도 입니다
		});
	
		// 지도에 원을 표시합니다
		circle.setMap(map);
	}
}