<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQery/test5.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// ajax() 함수
// 		Ajax란 Asynchronous JavaScript and XML의 약자입니다.
// 		Ajax는 빠르게 동작하는 동적인 웹 페이지를 만들기 위한 개발 기법의 하나입니다.
// 		Ajax는 웹 페이지 전체를 다시 로딩하지 않고도, 웹 페이지의 일부분만을 갱신할 수 있습니다.
//  	즉 Ajax를 이용하면 백그라운드 영역에서 서버와 통신하여, 그 결과를 웹 페이지의 일부분에만 표시할 수 있습니다.

		// id="btn" 클릭했을 때
		// 버튼 클릭했을 때 id값을 넘겨서 아이디 중복체크해서 오기
		$('#btn').click(function(){
			$.ajax({
				url:'test5_idcheck.jsp',
				data:{'id':$('#id').val()},
				success: function(rdata){
					// id="iddiv"에 들고온 데이터 rdata를 내용 넣기
					$('#iddiv').html(rdata);
				}
			});
		});
		
	});
</script>
</head>
<body>
<form action="a.jsp" method="post">
<input type="text" name="id" id="id">
<input type="button" value="아이디 중복체크" id="btn">
<div id="iddiv"></div>
</form>
</body>
</html>