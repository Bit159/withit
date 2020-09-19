
//POST방식으로 json 객체를 전송하는 options를 생성해주는 함수입니다.
function myOptions(ob) {
	let options = {
		method: "POST",
		headers: {
			'X-CSRF-TOKEN': document.getElementById('csrf').content,
			Accept: "application/json",
			"Content-Type": "application/json; charset=utf-8",
		},
		body: JSON.stringify(ob),
	};
	
	return options;
}

function myOptionsNotJSON(body) {
	let options = {
					method: "POST",
					headers: {'X-CSRF-TOKEN': document.getElementById('csrf').content},
					body: body,
				};
	return options;
}