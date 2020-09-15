document.querySelectorAll("button.wishdelete").forEach( (e) => {
    e.addEventListener("click", ()=>removeWish(e));
  });

/* 위시 제거 펑션 */ 
function removeWish(btn) {
	if(!confirm('정말 삭제하시겠습니까?')) return;
	console.log(btn);
	let ob = new Object();
	ob.x = btn.parentElement.children[0].value;
	ob.y = btn.parentElement.children[1].value;
	ob.range = btn.parentElement.children[2].value;
	let ar = btn.parentElement.children[3].value.split('   ');
	ob.topic1 = ar[0];
	ob.topic2 = ar[1];
	ob.topic3 = ar[2];
	ar = btn.parentElement.children[4].value.split('   ');
	ob.time1 = ar[0];
	ob.time2 = ar[1];
	ob.time3 = ar[2];
	console.log(btn.parentElement.children[5].value);
	switch(btn.parentElement.children[5].value) {
		case '무관': ob.career = 0; break;
		case '0~2년': ob.career = 2; break;
		case '3~5년': ob.career = 5; break;
		case '5년 이상': ob.career = 6; break;
		case '10년 이상': ob.career = 10; break;
	}
	switch(btn.parentElement.children[6].value) {
		case '무관': ob.people = 0; break;
		case '3명': ob.people = 3; break;
		case '4~6명': ob.people = 4; break;
		case '7~9명': ob.people = 7; break;
		case '10명  이상': ob.people = 10; break;
	}
	console.log(ob)
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
	
	fetch(url, options).then((res) => res.json().then( (json)=> {
		if(json.x === ob.x)	btn.parentElement.remove();
		else alert('삭제 도중 오류가 발생하였습니다');
		}));

}





//-------------------------------------------------
//열고 닫기 할 때 사용할 스위치 요소
let time_sw = false;
let theme_sw = false;
let career_sw = false;
let people_sw = false;
let location_sw = false;
//옵션들 열고 닫기 처리할 요소들
let time_option_array = document.querySelectorAll(".time_options");
let theme_option_array = document.querySelectorAll(".theme_options");
let career_option_array = document.querySelectorAll(".career_options");
let people_option_array = document.querySelectorAll(".people_options");
let location_option_array = document.querySelectorAll(".location_options");
//스크롤 표현할 wrapper 요소들
let time_option_wrapper = document.getElementById("time_option_wrapper");
let theme_option_wrapper = document.getElementById("theme_option_wrapper");
let career_option_wrapper = document.getElementById("career_option_wrapper");
let people_option_wrapper = document.getElementById("people_option_wrapper");
let location_option_wrapper = document.getElementById(
  "location_option_wrapper"
);
//이미 선택되었는지 검증할 배열 객체
let time_array = new Array();
let theme_array = new Array();
let career_array = new Array();
let people_array = new Array();
let location_array = new Array();





//열기 닫기 추가
document.getElementById("time_selection").addEventListener("click", () => {
  open_close(time_option_array, time_option_wrapper, time_sw);
  if (time_sw) time_sw = false;
  else time_sw = true;
});
document.getElementById("theme_selection").addEventListener("click", () => {
  open_close(theme_option_array, theme_option_wrapper, theme_sw);
  if (theme_sw) theme_sw = false;
  else theme_sw = true;
});
document.getElementById("career_selection").addEventListener("click", () => {
  open_close(career_option_array, career_option_wrapper, career_sw);
  if (career_sw) career_sw = false;
  else career_sw = true;
});
document.getElementById("people_selection").addEventListener("click", () => {
  open_close(people_option_array, people_option_wrapper, people_sw);
  if (people_sw) people_sw = false;
  else people_sw = true;
});
document.getElementById("location_selection").addEventListener("click", () => {
  open_close(location_option_array, location_option_wrapper, location_sw);
  if (location_sw) location_sw = false;
  else location_sw = true;
});

//---------------------------------------------------------------------------------------------
//열기 닫기
function open_close(option_array, option_wrapper, sw) {
  if (sw) close_menu(option_array, option_wrapper);
  else open_menu(option_array, option_wrapper);
}

//메뉴 열기
function open_menu(option_array, option_wrapper) {
  console.log("open");
  for (var i = 0; i < option_array.length; i++) {
    option_array[i].style.visibility = "visible";
  }
  option_wrapper.style.top = "0px";
  option_wrapper.style.visibility = "visible";
}
//메뉴 닫기
function close_menu(option_array, option_wrapper) {
  console.log("close");
  for (var i = 0; i < option_array.length; i++) {
    option_array[i].style.visibility = "hidden";
  }
  option_wrapper.style.top = "-20px";
  option_wrapper.style.visibility = "hidden";
}
//메뉴 열고 닫기 추가
//---------------------------------------------------------------------------------------------

//선택시 view에 추가해주는 펑션
function create_selected_option(value, sort) {
  //시간대 선택
  if (sort === "time") {
    if (time_array.indexOf("무관") !== -1) {
      alert("이미 시간대 무관을 선택하셨습니다");
      close_menu(time_option_array, time_option_wrapper);
      time_sw = false;
      return;
    }
    if (value.trim() === "무관") {
      document
        .querySelectorAll("#time_selection_wrapper>span")
        .forEach((element) => element.remove());
      time_array = new Array();
      close_menu(time_option_array, time_option_wrapper);
      time_sw = false;
    }
    if (time_array.length > 2) {
      alert("최대 3개까지 선택 가능합니다.");
      close_menu(time_option_array, time_option_wrapper);
      time_sw = false;
      return;
    }
    if (time_array.indexOf(value.trim()) !== -1) {
      alert("이미 선택된 과목입니다");
      return;
    }
    time_array.push(value.trim());
    if (time_array.length === 3) {
      close_menu(time_option_array, time_option_wrapper);
      time_sw = false;
    }
    document.getElementById("time_selection").removeAttribute("placeHolder");
    //주제 선택
  } else if (sort === "theme") {
    if (theme_array.length === 3) {
      alert("최대 3개까지 선택 가능합니다.");
      close_menu(theme_option_array, theme_option_wrapper);
      return;
    }
    if (theme_array.indexOf(value.trim()) !== -1) {
      alert("이미 선택된 과목입니다");
      return;
    }
    theme_array.push(value.trim());
    if (theme_array.length === 3) {
      close_menu(theme_option_array, theme_option_wrapper);
      theme_sw = false;
    }
    document.getElementById("theme_selection").removeAttribute("placeHolder");
    //경력 선택
  } else if (sort === "career") {
    if (career_array.length === 1) {
      alert("최대 1개까지 선택 가능합니다.");
      close_menu(career_option_array, career_option_wrapper);
      return;
    }
    if (career_array.indexOf(value.trim()) !== -1) {
      alert("이미 선택된 경력입니다");
      return;
    }
    career_array.push(value.trim());
    if (career_array.length === 1) {
      close_menu(career_option_array, career_option_wrapper);
      career_sw = false;
    }
    document.getElementById("career_selection").removeAttribute("placeHolder");
    //인원수 선택
  } else if (sort === "people") {
    if (people_array.length === 1) {
      alert("최대 1개까지 선택 가능합니다.");
      close_menu(people_option_array, people_option_wrapper);
      return;
    }
    if (people_array.indexOf(value.trim()) !== -1) {
      alert("이미 선택된 인원수입니다");
      return;
    }
    people_array.push(value.trim());
    if (people_array.length === 1) {
      close_menu(people_option_array, people_option_wrapper);
      people_sw = false;
    }
    document.getElementById("people_selection").removeAttribute("placeHolder");
  }

  let outer = document.createElement("span");
  outer.className = "selected";
  outer.append(document.createTextNode(value));
  let inner = document.createElement("div");
  inner.className = "deleteBtn";
  inner.append(document.createTextNode("✖"));
  inner.addEventListener("click", () => delete_seleted_option(inner, sort));
  outer.append(inner);
  switch (sort) {
    case "time":
      time_selection_wrapper.append(outer);
      break;
    case "theme":
      theme_selection_wrapper.append(outer);
      break;
    case "career":
      career_selection_wrapper.append(outer);
      break;
    case "people":
      people_selection_wrapper.append(outer);
      break;
  }
}

//x 버튼으로 요소 삭제하기 펑션
function delete_seleted_option(value, sort) {
  value.parentElement.remove();
  //splice(인덱스, 1) 적어주면 해당 인덱스값만 삭제
  switch (sort) {
    case "time":
      time_array.splice(time_array.indexOf(value.previousSibling.data), 1);
      if (time_array.length === 0) {
        document
          .getElementById("time_selection")
          .setAttribute("placeholder", "시간대 ▽");
        close_menu(time_option_array, time_option_wrapper);
        time_sw = false;
      }
      break;
    case "theme":
      theme_array.splice(theme_array.indexOf(value.previousSibling.data), 1);
      if (theme_array.length === 0) {
        document
          .getElementById("theme_selection")
          .setAttribute("placeholder", "주제 ▽");
        close_menu(theme_option_array, theme_option_wrapper);
        theme_sw = false;
      }
      break;
    case "career":
      career_array.splice(career_array.indexOf(value.previousSibling.data), 1);
      if (career_array.length === 0) {
        document
          .getElementById("career_selection")
          .setAttribute("placeholder", "경력 ▽");
        close_menu(career_option_array, career_option_wrapper);
        career_sw = false;
      }
      break;
    case "people":
      people_array.splice(people_array.indexOf(value.previousSibling.data), 1);
      if (people_array.length === 0) {
        document
          .getElementById("people_selection")
          .setAttribute("placeholder", "희망인원 ▽");
        close_menu(people_option_array, people_option_wrapper);
        people_sw = false;
      }
      break;
  }
}

//요소 추가하기 적용
function myEvent(array, sort) {
  for (let i = 0; i < array.length; i++) {
    let value = array[i].firstChild.data;
    array[i].addEventListener("click", () =>
      create_selected_option(value, sort)
    );
  }
}

//각 옵션에 클릭하면 생성되게 이벤트 추가
myEvent(time_option_array, "time");
myEvent(theme_option_array, "theme");
myEvent(career_option_array, "career");
myEvent(people_option_array, "people");

// 클릭하면 메뉴 열리고 닫히게 이벤트 추가

function openMapOnLocationSelect(value) {
  document
    .getElementById("location_selection")
    .removeAttribute("placeHolder", "지역 ▽");
  if (document.querySelector("#location_selection+span") !== null)
    document.querySelector("#location_selection+span").remove();
  if (value === "온라인") {
    document.getElementById("x").value = 0;
    document.getElementById("y").value = 0;
    document.getElementById("range").value = 0;
    close_menu(location_option_array, location_option_wrapper);
    location_sw = false;
    return;
  }
	document.getElementById('myLocation').value=value;
	close_menu(location_option_array, location_option_wrapper);
	location_sw = false;
  window.open(
    "/myLocation.jsp",
    "매칭지역설정",
    "top=100,width=100,width=1000,height=540"
  );

  let outer = document.createElement("span");
  outer.className = "selected";
  outer.id = "locationSpan";
  outer.append(document.createTextNode("선택완료"));
  let inner = document.createElement("div");
  inner.className = "deleteBtn";
  inner.append(document.createTextNode("✖"));
  inner.addEventListener("click", function () {
    this.parentElement.remove();
    document
      .getElementById("location_selection")
      .setAttribute("placeHolder", "지역 ▽");
  });
  outer.append(inner);
  outer.style.display="none";
  location_selection_wrapper.append(outer);
}

location_option_array.forEach((e) => {
  e.addEventListener("click", () => openMapOnLocationSelect(e.innerText));
});







//-----------------------------------등록하기-----------------------------------------

let x = document.getElementById("x");
let y = document.getElementById("y");
let range = document.getElementById("range");
let btn = document.getElementById('insert_match_button');

btn.addEventListener('click', ()=>nullValidator());

//등록하기 버튼 눌렀을 때 실행될 메소드
function nullValidator() {
  msg.style.transition = "all 0s";
  msg.style.opacity = "0";
  msg.style.fontWeight = "550";
  msg.innerText = "";
  msg.style.opacity = "1";
  if (myLocation.value === "") {
    msg.innerText = "지역을 선택해주세요";
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (time_array.length === 0) {
    msg.innerText = "시간대를 선택해주세요";
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (theme_array.length === 0) {
    msg.innerText = "주제를 선택해주세요";
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (career_array.length === 0) {
    msg.innerText = "경력을 선택해주세요";
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (people_array.length === 0) {
    msg.innerText = "희망인원을 선택해주세요";
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
  if (x.value === "" || y.value === "" || range.value === "") {
    msg.innerText = "지역 선택 후 범위를 설정해주세요";
    location_selection.focus();
    setTimeout(() => {
      msg.style.transition = "all .5s";
      msg.style.opacity = "0";
    }, 1500);
    return;
  }
	btn.disabled='disabled';
	let ob = new Object();
	ob.x = x.value;
	ob.y = y.value;
	ob.range = range.value;
	ob.time = time_array[0];
	ob.topic = theme_array[0];
	switch(career_array[0]){
		case "0~2년": ob.career = 2; break;
		case "3~5년": ob.career = 5; break;
		case "5년 이상": ob.career = 6; break;
		case "10년 이상": ob.career = 10; break; 
	}
	switch(people_array[0]){
		case "~ 3명": ob.people = 3; break;
		case "4 ~ 6명": ob.people = 4; break;
		case "7 ~ 9명": ob.people = 7; break;
		case "10명 이상": ob.people = 10; break; 
	}
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
	/*
						<li class="wishes">
						<input class="wishlist_area" type="text" value="${dto.x}" readonly /> 
						<input type="hidden" value="${dto.y}" readonly /> 
						<input type="hidden" value="${dto.range}" readonly /> 
						<input class="wishlist_time" type="text" value="${dto.time1}  ${dto.time2}  ${dto.time3}" readonly /> 
						<input class="wishlist_topic" type="text" value="${dto.topic1}  ${dto.topic2}  ${dto.topic3}" readonly /> 
						<input class="wishlist_career" type="text"	value="<c:choose><c:when test="${dto.career eq 0 }">무관</c:when><c:when test="${dto.career eq 2 }">0~2년</c:when><c:when test="${dto.career eq 5 }">3~5년</c:when><c:when test="${dto.career eq 6 }">5년 이상</c:when><c:when test="${dto.career eq 10 }">10년  이상</c:when></c:choose>" readonly />
						<input class="wishlist_people" type="text" value="<c:choose><c:when test="${dto.people eq 0 }">무관</c:when><c:when test="${dto.people eq 3 }">3명</c:when><c:when test="${dto.people eq 4 }">4~6명</c:when><c:when test="${dto.people eq 7 }">7~9명</c:when><c:when test="${dto.people eq 10 }">10명  이상</c:when></c:choose>" readonly />
						<button type="button" class="wishdelete">삭제</button>
					</li>
	*/
	
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
									document.querySelectorAll('span.selected').forEach((e)=>e.remove());
									myLocation.value="";
									if(document.getElementById('theme_option_wrapper').style.visibility === "visible")
									document.getElementById('theme_selection').click();
									if(document.getElementById('time_option_wrapper').style.visibility === "visible")
									document.getElementById('time_selection').click();
									let li = document.createElement('li');
									li.append(x, y, range, div1, div2, div3, div4, div5, deldiv);
									document.querySelector('ul').append(li);
									alert('등록 완료!');								
								}
						)
	);
      document.getElementById("location_selection").setAttribute("placeHolder", "지역 ▽");
      document.getElementById("time_selection").setAttribute("placeHolder", "시간대 ▽");
      document.getElementById("theme_selection").setAttribute("placeHolder", "주제 ▽");
      document.getElementById("career_selection").setAttribute("placeHolder", "경력 ▽");
      document.getElementById("people_selection").setAttribute("placeHolder", "희망인원 ▽");

	time_array = new Array();
	theme_array = new Array();
	career_array = new Array();
	people_array = new Array();
	document.getElementById('insert_match_button').disabled=false;
}
//등록하기 버튼 눌렀을 때 실행될 메소드








