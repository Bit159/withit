let submitButton = document.getElementById("submitButton");
let myLocation = document.getElementById("myLocation");
let time = document.getElementById("time");
let topic = document.getElementById("topic");
let career = document.getElementById("career");
let people = document.getElementById("people");
let msg = document.getElementById("msg");
let x = document.getElementById("x");
let y = document.getElementById("y");
let form = document.forms[0];

myLocation.addEventListener("change", openMapOnLocationSelect);
submitButton.addEventListener("click", nullValidator);

function openMapOnLocationSelect() {
  let selectedLocation = myLocation.value;
  if (selectedLocation === "온라인") {
    x.value = 0;
    y.value = 0;
    range.value = 0;
    return;
  }
  window.open(
    "myLocation.jsp",
    "매칭지역설정",
    "top=100,width=100,width=1000,height=540"
  );
}


//등록하기 버튼 눌렀을 때 실행될 메소드
function nullValidator() {
  msg.style.transition = "all 0s";
  msg.style.opacity = "0";
  msg.style.color = "#32be78";
  msg.style.fontWeight = "550";
  msg.innerText = "";
  msg.style.opacity = "1";
  if (myLocation.value === "") {
    msg.innerText = "지역을 선택해주세요";
    myLocation.focus();
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (time.value === "") {
    msg.innerText = "시간대를 선택해주세요";
    time.focus();
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (topic.value === "") {
    msg.innerText = "주제를 선택해주세요";
    topic.focus();
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (career.value === "") {
    msg.innerText = "경력을 선택해주세요";
    career.focus();
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (people.value === "") {
    msg.innerText = "희망인원을 선택해주세요";
    people.focus();
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (x.value === "" || y.value === "" || range.value === "") {
    msg.innerText = "지역 선택 후 범위를 설정해주세요";
    myLocation.focus();
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
	document.getElementById('submitButton').disabled='disabled';
	let ob = new Object();
	ob.x = document.getElementById('x').value;
	ob.y = document.getElementById('y').value;
	ob.range = document.getElementById('range').value;
	ob.time = document.getElementById('time').value;
	ob.topic = document.getElementById('topic').value;
	ob.career = document.getElementById('career').value;
	ob.people = document.getElementById('people').value;
	let csrf = document.getElementById('csrf').content;
	let csrf_header = document.getElementById('csrf_header').content;
	let url = "/insert_match_done";
	let options = {
		method: "POST",
		headers: {
			"X-CSRF-TOKEN": document.getElementById('csrf').content,
			Accept: "application/json",
			"Content-Type": "application/json; charset=utf-8",
		},
		body: JSON.stringify(ob),
	};
	fetch(url, options).then((res) =>
		res.json().then((json)=>{
									let x = document.createElement('input');
									let y = document.createElement('input');
									let range = document.createElement('input');
									x.type="hidden";
									y.type="hidden";
									range.type="hidden";
									x.value=json.x;									
									y.value=json.y;									
									range.value=json.range;									
									let div1 = document.createElement('div');
									div1.className="rangedArea";
									let div2 = document.createElement('div');
									let div3 = document.createElement('div');
									let div4 = document.createElement('div');
									let div5 = document.createElement('div');
									div2.appendChild(document.createTextNode(json.time));
									div3.appendChild(document.createTextNode(json.topic));
									div4.appendChild(document.createTextNode(json.career));
									div5.appendChild(document.createTextNode(json.people));
									
									//<div><button class="deleteButtons_in_insert_match" type="button">삭제</button></div>
									let deldiv = document.createElement('div');
									let del = document.createElement('button');
									del.className="deleteButtons_in_insert_match";
									del.type="button";
									del.addEventListener('click', function(){
										let ob = new Object();
										ob.x = this.parentElement.parentElement.children[0].value;
										ob.y = this.parentElement.parentElement.children[1].value;
										ob.range = this.parentElement.parentElement.children[2].value;
										ob.time = this.parentElement.parentElement.children[4].innerText;
										ob.topic = this.parentElement.parentElement.children[5].innerText;
										ob.career = this.parentElement.parentElement.children[6].innerText;
										ob.people = this.parentElement.parentElement.children[7].innerText;
										let url = "/delete_match";
										let options = {
											method: "POST",
											headers: {
												"X-CSRF-TOKEN": document.getElementById('csrf').content,
												Accept: "application/json",
												"Content-Type": "application/json; charset=utf-8",
											},
											body: JSON.stringify(ob),
										};
										
										fetch(url, options).then((res) =>
											res.json().then((json)=>{
												if(confirm("삭제하시겠습니까?")) {
													this.parentElement.parentElement.remove();
													alert('삭제되었습니다');
												} 
													
											}));
									});
									del.appendChild(document.createTextNode('삭제'));
									deldiv.append(del);
									
									let li = document.createElement('li');
									li.append(x, y, range, div1, div2, div3, div4, div5, deldiv);
									document.querySelector('ul').append(li);
									alert('등록 완료!');								
								}
						)
	);

	myLocation.value="";
	time.value="";
	topic.value="";
	career.value="";
	people.value="";
	document.getElementById('submitButton').disabled=false;
}
//등록하기 버튼 눌렀을 때 실행될 메소드


//모든 삭제 버튼에 이벤트 리스너 추가
let delete_Button_Array = document.getElementsByClassName('deleteButtons_in_insert_match');
for(let i=0; i<delete_Button_Array.length; i++) {
	delete_Button_Array[i].addEventListener('click',
		function(){
			let ob = new Object();
			ob.x = this.parentElement.parentElement.children[0].value;
			ob.y = this.parentElement.parentElement.children[1].value;
			ob.range = this.parentElement.parentElement.children[2].value;
			ob.time = this.parentElement.parentElement.children[4].innerText;
			ob.topic = this.parentElement.parentElement.children[5].innerText;
			ob.career = this.parentElement.parentElement.children[6].innerText;
			ob.people = this.parentElement.parentElement.children[7].innerText;
			let url = "/delete_match";
			let options = {
				method: "POST",
				headers: {
					"X-CSRF-TOKEN": document.getElementById('csrf').content,
					Accept: "application/json",
					"Content-Type": "application/json; charset=utf-8",
				},
				body: JSON.stringify(ob),
			};
			
			fetch(url, options).then((res) =>
				res.json().then((json)=>{
					if(confirm("삭제하시겠습니까?")) {
						this.parentElement.parentElement.remove();
						alert('삭제되었습니다');
					} 
						
				}));
		}
	);
}


//버튼 1개에 삭제 기능 넣는 메소드
function injectDeleteFunction() {
	let ob = new Object();
	ob.x = this.parentElement.previousElementSibling;
	ob.y = this.parentElement.parentElement.children[1];
	ob.range = this.parentElement.parentElement.children[2];
	ob.time = this.parentElement.parentElement.children[4];
	ob.topic = this.parentElement.parentElement.children[5];
	ob.career = this.parentElement.parentElement.children[6];
	ob.people = this.parentElement.parentElement.children[7];
	
	let url = "/delete_match";
	let options = {
		method: "POST",
		headers: {
			"X-CSRF-TOKEN": document.getElementById('csrf').content,
			Accept: "application/json",
			"Content-Type": "application/json; charset=utf-8",
		},
		body: JSON.stringify(ob),
	};
	
	fetch(url, options).then((res) =>
		res.json().then((json)=>{
		}));

}