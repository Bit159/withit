document.getElementById("topButton").addEventListener("click", () => {
  scrollTo(0, 0);
});

document.getElementById("loginButton").addEventListener("click", () => {
  location.href = "login.html";
});

window.onscroll = () => {
  let target = document.querySelector(".nav");
  let ham = document.querySelectorAll(".line");
  let val = window.scrollY;
  let topButton = document.querySelector("#topButton");
  if (val === 0) {
    target.style.backgroundColor = "transparent";
    ham[0].style.borderBottomColor = "white";
    ham[1].style.borderBottomColor = "white";
    ham[2].style.borderBottomColor = "white";
    topButton.style.opacity = "0";
  } else {
    target.style.backgroundColor = "white";
    ham[0].style.borderBottomColor = "black";
    ham[1].style.borderBottomColor = "black";
    ham[2].style.borderBottomColor = "black";
    topButton.style.opacity = "1";
  }
};

function mobileMenu() {
  let val = document.querySelector(".mobileMenu").style.right;
  if (val === "0px") {
    document.querySelector(".mobileMenu").style.right = "-100%";
  } else {
    document.querySelector(".mobileMenu").style.right = "0px";
  }
}
