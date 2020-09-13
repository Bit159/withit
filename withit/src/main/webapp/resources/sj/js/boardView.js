$(document).ready(function(){
	//댓글 쓰기 
	$(document).on("click","#reply_writer_btn",function(){
		var $btnObj = $(this);
		var page = $(this).data('page');
		var range = $(this).data('range');
		var reply = $("#reply_writer_text").val();
		var bno = document.querySelector('div.view_bno').innerText;
		var param = "reply="+reply+"&bno="+bno;
		var csrfHeader = document.getElementById('_csrf_header').content;
		var csrfToken = document.getElementById('_csrf').content;
		console.log(csrfHeader);
		console.log(csrfToken);
		
		if(reply != ""){
			$.ajax({
				type: "post",
				url: "/synergy/board/boardReply",
				beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeader, csrfToken);
		    		
		    	},
				data: param, 
				dataType: 'json',
				success: function(data){
					console.log(data);
					Swal.fire({
							  title: '댓글 등록 완료',
							  text: '댓글이 등록되었습니다.',
							  icon: 'success',
					}).then((res)=>{
						location.href='/synergy/board/'+bno+'?pg='+page+'&range='+range;									
					});
					
					// 비동기 방식
					/*let a = '<li class="reply_group_item"><div class="reply_nickname">'
						    +"nickname"+
						    '</div><div class="reply">'
						    +reply+
						    '</div><div class="reply_button">'
						    +'<button type="button" class="modifyBtn">수정</button><button type="button" class="deleteBtn" data-rno="${ replydto.rno }">삭제</button>'+
						    '</div></li>';
					
					let b = document.querySelector('ul.reply_group');
					
					b.innerHTML = b.innerHTML + a;
					
					$("#reply_writer_text").val('');
					
					let target = document.querySelector('.reply_header');
					let newnum = target.innerText.substring(6);
					newnum++;
					target.innerText = `댓글수 : ${newnum}`;
					
					let target1 = document.querySelector('.view_replys');
					let newnum1 = target1.innerText.substring(6);
					newnum1++;
					target1.innerText = `댓글수 : ${newnum1}`;*/

				},
				error: function(err){
					console.log(err);
				}
			});
		}else{
			Swal.fire({
					  title: '댓글 내용이 없음',
					  text: '댓글 내용을 입력하세요',
					  icon: 'question'
			});
		}
		
	});
	
	//댓글 삭제
	$(document).on("click",".deleteBtn", function(){
		var $btnObj = $(this);
		let rno = $(this).data('rno'); // data-rno
		var bno = document.querySelector('div.view_bno').innerText;
		
		var csrfHeader = document.getElementById('_csrf_header').content;
		var csrfToken = document.getElementById('_csrf').content;
		
		var param = "rno="+rno+"&bno="+bno;
		
		Swal.fire({
			title:`댓글 삭제`,
			text:`정말 삭제하시겠습니까?`,
			icon:`question`,
			confirmButtonText:`확인`,
			showCancelButton:true,
			cancelButtonText:`취소`,
		}).then((res)=>{
			if(res.isConfirmed){
				console.log('승인, 댓글삭제처리가 들어올 곳')
				deleteReply();
			}else {
				console.log('비승인');
				Swal.fire('취소', '댓글 삭제가 취소되었습니다', 'error');
			}
		});
		
		function deleteReply(){
			$.ajax({
				type: 'post',
				url: '/synergy/board/replyDelete',
				beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeader, csrfToken);
		    	},
				data: param,
				success: function(data){
					$btnObj.parent().parent().remove();
					
					let target = document.querySelector('.reply_header');
					let newnum = target.innerText.substring(6);
					newnum--;
					target.innerText = `댓글수 : ${newnum}`;
					
					let target1 = document.querySelector('.view_replys');
					let newnum1 = target1.innerText.substring(6);
					newnum1--;
					target1.innerText = `댓글수 : ${newnum1}`;
					
					Swal.fire({
							  title: '댓글 삭제 완료',
							  text: '댓글이 삭제되었습니다.',
							  icon: 'success'
					});
				},
				error: function(err){
					console.log(err);
					Swal.fire({
							  title: '댓글 삭제 실패',
							  text: '댓글이 삭제 되지 않았습니다',
							  icon: 'error'
					});
					
				}
			});
		}
		
		
		
		/*
		let a = document.querySelectorAll('button .deleteBtn');
		let rno;
		
		for(let i = 0; i<a.length; i++){
			rno = a[i].parentElement.parentElement.children[0].value;
		}
		
		var param = "rno="+rno;
		
		a[i].addEventListener('click', ()=> {
			let result = confirm("정말 삭제하시겠습니까?");
			
			if(result){
				$.ajax({
					type: 'get',
					url: '/synergy/board/replyDelete',
					data: param,
					success: function(data){
						alert("삭제 성공");
						a[i].parentElement.parentElement.remove();
					},
					error: function(err){
						console.log(err);	
					}
				});
				
			}
		});
		*/
	});
	
	//댓글 수정
	$(document).on("click",".modifyBtn", function(){
		var $btnObj = $(this);
		$btnObj.parent().parent().parent().css('display','none');
		$btnObj.parent().parent().parent().parent().children('div.reply_modify_wrapper').css('display','block');
	});
	
	$(document).on("click",".reply_modify_cancel", function(){
		var $btnObj = $(this);
		$btnObj.parent().parent().parent().parent().parent().children('li.reply_group_item2').css('display','flex');
		$btnObj.parent().parent().parent().parent().css('display','none');
	});
	
	$(document).on("click",".reply_modify_button",function(){
		var bno = document.querySelector('div.view_bno').innerText;
		console.log(bno);
		var page = $(this).data('page');
		var range = $(this).data('range');
		let rno = $(this).data('rno') // data-rno
		var reply = $(this).parent().parent().children('textarea.reply_modify_text').val();
		console.log(reply);
		var csrfHeader = document.getElementById('_csrf_header').content;
		var csrfToken = document.getElementById('_csrf').content;
		
		var param = "reply="+reply+"&rno="+rno;
		console.log(param);
		
		Swal.fire({
			title:`댓글 수정`,
			text:`정말 수정하시겠습니까?`,
			icon:`question`,
			confirmButtonText:`확인`,
			showCancelButton:true,
			cancelButtonText:`취소`,
		}).then((res)=>{
			if(res.isConfirmed){
				console.log('승인, 댓글수정처리가 들어올 곳')
				updateReply();
			}else {
				console.log('비승인');
				Swal.fire('취소', '댓글 수정이 취소되었습니다', 'error');
			}
		});
		
		
		
		
		
		function updateReply() {
			$.ajax({
				type: 'post',
				url: '/synergy/board/replyModify',
				beforeSend: function(xhr){
		    		xhr.setRequestHeader(csrfHeader, csrfToken);
		    	},
		    	data: param,
		    	success: function(data){
		    		Swal.fire({
							  title: '댓글 수정 완료',
							  text: '댓글이 수정 되었습니다.',
							  icon: 'success',
							  confirmButtonText: `확인`,
		    		}).then((res)=>{
		    			location.href='/synergy/board/'+bno+'?pg='+page+'&range='+range;
		    		});
		    	},
		    	error: function(err){
					console.log(err);
				}
				
			});
		}
		
	});
	
	
});