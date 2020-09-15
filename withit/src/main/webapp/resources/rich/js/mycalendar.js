//notify 테이블에서 가져온 값들을 담아둘 배열 선언
let myData = new Array();
//FullCalendar에 events 속성에 전달할 배열 객체 선언
let schedules = new Array();
//FullCalendar 함수 재사용을 위한 필드 선언
let calendar = undefined;

/*Read : 페이지 로드했을 때 db에서 값 가져와서 달력그리기 */
document.addEventListener("DOMContentLoaded", function () {
  //fetch로 notify 테이블의 모든 값 가져와서 myData에 저장 및 schedules 배열 준비
  let url = "/getSchedules";
  let options = {
    method: "POST",
    headers: {
      "X-CSRF-TOKEN": document.getElementById("csrf").content,
      Accept: "application/json",
      "Content-Type": "application/json; charset=utf-8",
      SameSite: false,
    },
  };

  //notify 테이블에서 값들을 가져와서 FullCalendar에서 사용할 수 있는 schedules 배열로 변환하는 함수입니다.
  fetch(url, options)
    .then((res) =>
      res.json().then((json) => {
        myData = json;

        myData.forEach((e) => {
          let event = new Object();
          let _start = new Date(e.start.time);
          let _end = new Date(e.end.time);
          event.start = `${dateFormatter(_start)}T${timeFormatter(_start)}`;
          event.end = `${dateFormatter(_end)}T${timeFormatter(_end)}`;
          event.no = e.no;
          event.group = e.group;
          event.username = e.username;
          event.myStart = e.start;
          event.myEnd = e.end;
          event.title = e.title;
          event.place = e.place;
          event.content = e.content;
          event.allDay = false;
          schedules.push(event);
        });
      })
    )
    //준비된 schedules 배열을 이용해 FullCalendar를 render하는 코드입니다.
    .then(() => renderCalendar());
});

//달력을 렌더링하는 함수입니다.
function renderCalendar() {
  var calendarEl = document.getElementById("calendar");

  var calendar = new FullCalendar.Calendar(calendarEl, {
    headerToolbar: {
      left: "prevYear,prev,next,nextYear today",
      center: "title",
      right: "dayGridMonth,timeGridWeek,timeGridDay,listMonth",
    },
    initialDate: new Date(),
    locale: "ko",
    navLinks: true, // can click day/week names to navigate views
    businessHours: true, // display business hours
    editable: true,
    selectable: true,
    selectMirror: true,
    select: function (arg) {
      createSchedule(arg, this);
    },
    eventClick: function (arg) {
      showSchedule(arg);
    },
    editable: true,
    dayMaxEvents: true, // allow "more" link when too many events
    events: schedules,
  });
  calendar.render();
}

// 달력 내 이벤트를 클릭 했을 때 호출될 함수입니다.
// FullCalendar 의 eventClick 속성에 부여됩니다.
function removeSchedule(arg) {
  console.log(arg);
  Swal.fire({
    title: `일정 삭제`,
    text: `${arg.event._def.title} 일정을 삭제하시겠습니까?`,
    icon: `error`,
    showConfirmButton: true,
    showCancelButton: true,
    confirmButtonText: `삭제`,
    cancelButtonText: `취소`,
  }).then((res) => {
    if (res.isConfirmed) {
      let url = "/removeSchedule";
      let options = {
        method: "POST",
        headers: {
          "X-CSRF-TOKEN": document.getElementById("csrf").content,
          Accept: "application/json",
          "Content-Type": "application/json; charset=utf-8",
        },
        body: arg.event._def.extendedProps.no,
      };
      fetch(url, options).then((res) =>
        res.text().then((text) => {
          if (text === "1") {
            arg.event.remove();
            Swal.fire({
              title: `삭제 완료`,
              text: `삭제가 완료되었습니다`,
              defaultButtonText: `확인`,
              icon: `success`,
            });
          } else {
            Swal.fire(
              "에러",
              `일정 삭제중 에러가 발생하였습니다.<br>관리자에게 문의하세요`,
              "error"
            );
          }
        })
      );
    } else {
      Swal.fire({
        title: `삭제 취소`,
        text: `삭제가 취소되었습니다`,
        defaultButtonText: `확인`,
        icon: `info`,
      });
    }
  });
}

//Date 형식을 yyyy-MM-dd 형식으로 변환해주는 함수입니다.
function dateFormatter(date) {
  let year = date.getFullYear();
  let month =
    date.getMonth() / 10 < 1
      ? "0" + (date.getMonth() + 1)
      : date.getMonth() + 1;
  let _date = date.getDate() / 10 < 1 ? "0" + date.getDate() : date.getDate();
  let result = `${year}-${month}-${_date}`;
  return result;
}

//Date 형식의 입력을 받아서 HH:mm:ss 형식으로 변환해주는 함수입니다.
function timeFormatter(date) {
  let hour = date.getHours() / 10 < 1 ? "0" + date.getHours() : date.getHours();
  let minute =
    date.getMinutes() / 10 < 1 ? "0" + date.getMinutes() : date.getMinutes();
  let second =
    date.getSeconds() / 10 < 1 ? "0" + date.getSeconds() : date.getSeconds();
  let result = `${hour}:${minute}:${second}`;
  return result;
}

//Date 형식의 입력을 받아서 yyyy-MM-dd HH:mm:ss 형식으로 변환해주는 함수입니다.
function dateTimeFormatter(date) {
  let _date = dateFormatter(date);
  let _time = timeFormatter(date);
  result = `${_date} ${_time}`;
  return result;
}

//달력의 일정을 클릭했을 때  일정의 상세 내용과 삭제 메뉴를 보여주는 함수입니다.
function showSchedule(arg) {
  console.log(arg);
  let start = undefined;
  let end = undefined;
  if (arg.event._def.extendedProps.myStart.time === undefined) {
    start = dateTimeFormatter(new Date(arg.event._def.extendedProps.myStart));
    end = dateTimeFormatter(new Date(arg.event._def.extendedProps.myEnd));
  } else {
    start = dateTimeFormatter(
      new Date(arg.event._def.extendedProps.myStart.time)
    );
    end = dateTimeFormatter(new Date(arg.event._def.extendedProps.myEnd.time));
  }

  Swal.fire({
    title: `일정 확인`,
    icon: `info`,
    html:
      `<div>일시 : ${start} ~ ${end}</div>` +
      `<div>제목 : ${arg.event._def.title}</div>` +
      `<div>장소 : ${arg.event._def.extendedProps.place}</div>` +
      `<div>내용 : ${arg.event._def.extendedProps.content}</div>`,
    showConfirmButton: true,
    showDenyButton: true,
    confirmButtonText: `확인`,
    denyButtonText: `제거`,
  }).then((res) => {
    if (res.isDenied) {
      removeSchedule(arg);
    }
  });
}

function setTimeFunction() {
  //시작 시간 중 분을 선택했을 때 이벤트 추가
  document.getElementById("minuteSelect").addEventListener("change", () => {
    //시작 시간 중 시간이 선택되지 않았다면 리턴
    if (document.getElementById("timeSelect").value === "시") return;
    //시와 분이 모두 선택되었다면 종료 시간에 시작시간과 같은 값을 대입
    document.getElementById("timeSelect2").value = document.getElementById(
      "timeSelect"
    ).value;
    document.getElementById("minuteSelect2").value = document.getElementById(
      "minuteSelect"
    ).value;
  });

  //시작 시간 중 시를 선택했을 때 이벤트 추가
  document.getElementById("timeSelect").addEventListener("change", () => {
    //시작 시간 중 분이 선택되지 않았다면 리턴
    if (document.getElementById("minuteSelect").value === "분") return;
    //시와 분이 모두 선택되었다면 종료 시간에 시작시간과 같은 값을 대입
    document.getElementById("timeSelect2").value = document.getElementById(
      "timeSelect"
    ).value;
    document.getElementById("minuteSelect2").value = document.getElementById(
      "minuteSelect"
    ).value;
  });
}

//달력의 빈 곳을 클릭했을 때 호출되어 새로운 일정을 생성해주는 함수입니다.
function createSchedule(arg, calendar) {
  console.log(arg.end);
  let startDate = dateFormatter(arg.start);
  let endDate = arg.end;
  endDate.setDate(endDate.getDate() - 1);
  endDate = dateFormatter(endDate);
  Swal.fire({
    icon: "info",
    title: "일정 추가",
    html:
      `<div id="dateWrapper">날짜 : <span id="startDate">${startDate}</span> ~ <span id="endDate">${endDate}</span></div>` +
      `<div id="timeWrapper"><div>시간 : </div>` +
      `<select name="timeSelect" id="timeSelect">
                    <option disabled selected value="">시</option>
                    <option value="09">09시</option>
                    <option value="10">10시</option>
                    <option value="11">11시</option>
                    <option value="12">12시</option>
                    <option value="13">13시</option>
                    <option value="14">14시</option>
                    <option value="15">15시</option>
                    <option value="16">16시</option>
                    <option value="17">17시</option>
                    <option value="18">18시</option>
                    <option value="19">19시</option>
                    <option value="20">20시</option>
                    <option value="21">21시</option>
                    <option value="22">22시</option>
                </select>
                <select name="minuteSelect" id="minuteSelect">
                    <option disabled selected value="">분</option>
                    <option value="00">0분</option>
                    <option value="10">10분</option>
                    <option value="20">20분</option>
                    <option value="30">30분</option>
                    <option value="40">40분</option>
                    <option value="50">50분</option>
                </select> ~ ` +
      `<select name="timeSelect2" id="timeSelect2">
                    <option disabled selected value="">시</option>
                    <option value="09">09시</option>
                    <option value="10">10시</option>
                    <option value="11">11시</option>
                    <option value="12">12시</option>
                    <option value="13">13시</option>
                    <option value="14">14시</option>
                    <option value="15">15시</option>
                    <option value="16">16시</option>
                    <option value="17">17시</option>
                    <option value="18">18시</option>
                    <option value="19">19시</option>
                    <option value="20">20시</option>
                    <option value="21">21시</option>
                    <option value="22">22시</option>
                </select>
                <select name="minuteSelect2" id="minuteSelect2">
                    <option disabled selected value="">분</option>
                    <option value="00">0분</option>
                    <option value="10">10분</option>
                    <option value="20">20분</option>
                    <option value="30">30분</option>
                    <option value="40">40분</option>
                    <option value="50">50분</option>
                </select>` +
      `</div>` +
      `<div id="titleWrapper"><input type="text" id="title" placeholder="제목을 입력하세요" ></input></div>` +
      `<div id="underlineForTitle"></div>` +
      `<div id="underlineForTitle2"></div>` +
      `<div id="placeWrapper"><input type="text" id="place" placeholder="장소를 입력하세요" /></div>` +
      `<div id="contentWrapper"><textarea id="content" rows="4" placeholder="상세 내용을 입력하세요" ></textarea></div>`,
    showCancelButton: true,
    allowOutsideClick: false,
    confirmButtonText: "등록",
    cancelButtonText: "취소",
    preConfirm: () => {
      console.log(calendar);
      let time1 = document.getElementById("timeSelect").value;
      let minute1 = document.getElementById("minuteSelect").value;
      let time2 = document.getElementById("timeSelect2").value;
      let minute2 = document.getElementById("minuteSelect2").value;
      let title = document.getElementById("title").value;
      let place = document.getElementById("place").value;
      let content = document.getElementById("content").value;
      let startDate = document.getElementById("startDate").innerText;
      let endDate = document.getElementById("endDate").innerText;

      let s = new Date(`${startDate} ${time1}:${minute1}:00`);
      let e = new Date(`${endDate} ${time2}:${minute2}:00`);

      if (
        time1 === "" ||
        minute1 === "" ||
        time2 === "" ||
        minute2 === "" ||
        title === ""
      ) {
        Swal.fire({
          title: "등록 실패",
          text: "시간과 제목은 필수입니다",
          icon: "error",
        }).then(() => {
          arg.end.setDate(arg.end.getDate() + 1);
          createSchedule(arg);
        });
      } else if (s > e) {
        Swal.fire({
          title: `시간 확인`,
          text: `종료 시간을 시작 시간 이후로 입력해주세요`,
          icon: `error`,
          showConfirmButton: true,
          confirmButtonText: `확인`,
        }).then((res) => {
          arg.end.setDate(arg.end.getDate() + 1);
          createSchedule(arg);
        });
      } else {
        let ob = new Object();
        ob.group = `0`;
        ob.username = `jpcnani@naver.com`;
        ob.start = s.getTime();
        ob.end = e.getTime();
        ob.title = title;
        ob.place = place;
        ob.content = content;

        let url = "/createSchedule";
        let options = {
          method: "POST",
          headers: {
            "X-CSRF-TOKEN": document.getElementById("csrf").content,
            Accept: "application/json",
            "Content-Type": "application/json; charset=utf-8",
          },
          body: JSON.stringify(ob),
        };
        let no = undefined;
        fetch(url, options).then((res) =>
          res.json().then((json) => {
            console.log(json);
            no = json.no;
          })
        );

        Swal.fire(
          "결과",
          `시간 : ${startDate}${time1}:${minute1} ~ ${endDate}${time2}:${minute2} <br>제목 : ${title} <br>장소 : ${place} <br>내용 : ${content}`,
          "success"
        ).then(() => {
          let start = `${startDate}T${time1}:${minute1}:00`;
          let end = `${endDate}T${time2}:${minute2}:00`;
          console.log(`start: ${start}, end : ${end}`);
          calendar.addEvent({
            no: no,
            title: title,
            start: start,
            end: end,
            myStart: s,
            myEnd: e,
            place: place,
            content: content,
            allDay: false,
          });
          calendar.unselect();
        });
      }
    },
  });
}
