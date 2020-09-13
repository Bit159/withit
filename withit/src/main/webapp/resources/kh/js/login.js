function checkLogin(){
	let id = document.getElementById("username").value;
	let pw = document.getElementById("password").value;
	
	if(id == ''){
		alert('아뒤입력');
		
	} else if (pw == ''){
		alert('비번 입력');
		
	} else {
		document.loginForm.submit();
	}
	
}