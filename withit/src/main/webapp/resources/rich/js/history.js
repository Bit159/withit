let times = document.querySelectorAll(".time>h4");


  //관리자 로그인했을 때 커서를 포인터로 변경하고 클릭해서 수정할 수 있게 해주는 함수
  function setCursor() {
    let btn = document.getElementById("historyButton");
    btn.style.display = "initial";
    btn.addEventListener("click", () => createHistory());

    let deleteButtons = document.querySelectorAll(".deleteHistory");
    deleteButtons.forEach((e) => (e.style.display = "initial"));
    let times = document.querySelectorAll(".time");

    let total = document.querySelectorAll(
      ".content>h3,.content>p,.time>h4"
    );
    total.forEach((e) => {
      e.style.cursor = "pointer";
      e.addEventListener("click", function () {
        console.log(this.tagName);
        updateHistory(this);
      });
    });
  }

  function updateHistory(elem) {
    switch (elem.tagName) {
      case "H3":
        Swal.fire({
          icon: `info`,
          showCancelButton: `true`,
          cancelButtonText: `취소`,
          confirmButtonText: `완료`,
          html:
            `<h3>제목 수정</h3>` +
            `<input type="text" style="width:70%;height:40px;font-size:20px;" value="${elem.innerText}"></input>`,
        });
        break;
      case "P":
        Swal.fire({
          icon: `info`,
          showCancelButton: `true`,
          cancelButtonText: `취소`,
          confirmButtonText: `완료`,
          html:
            `<h3>내용 수정</h3>` +
            `<textarea style="width:100%;height:200px;font-size:20px;" >${elem.innerText}</textarea>`,
        });
        break;
      case "H4":
        Swal.fire({
          icon: `info`,
          showCancelButton: `true`,
          cancelButtonText: `취소`,
          confirmButtonText: `완료`,
          html:
            `<h4>날짜 수정하기</h4>` +
            `<input type="date" value="${dateToInput(
              new Date()
            )}" style="width:70%;height:40px;font-size:20px;" value="${
              elem.innerText
            }"></input>`,
        });
        break;
    }
  }

  function createHistory() {
    Swal.fire({
      title: `타임라인 추가`,
      icon: `info`,
      showCancelButton: `true`,
      cancelButtonText: `취소`,
      confirmButtonText: `완료`,
      html:
        `<input type="text" style="width:100%;height:40px;font-size:20px;text-align:center;" placeholder="제목을 입력하세요"></input>` +
        `<textarea style="margin-top:15px;margin-bottom:15px;width:100%;height:200px;font-size:20px;text-align:center;" placeholder="내용을 입력하세요"></textarea>` +
        `<input type="date" style="width:100%;height:40px;font-size:20px;text-align:center;"></input>`,
    });
  }

  function getDayInKorean(day) {
    let result = undefined;
    switch (day) {
      case 0:
        result = "일";
        break;
      case 1:
        result = "월";
        break;
      case 2:
        result = "화";
        break;
      case 3:
        result = "수";
        break;
      case 4:
        result = "목";
        break;
      case 5:
        result = "금";
        break;
      case 6:
        result = "토";
        break;
    }
    return result;
  }

  function dateToInput(myDate) {
    let year = myDate.getFullYear();
    let month = myDate.getMonth() + 1;
    if (month < 10) month = "0" + month;
    let date = myDate.getDate();
    return `${year}-${month}-${date}`;
  }