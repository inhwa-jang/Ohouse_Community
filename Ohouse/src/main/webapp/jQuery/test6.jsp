<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test6.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// 자바스크립트 배열변수
		var arr = [
			{"id" : "kim", "name" : "김길동"},
			{"id" : "lee", "name" : "이길동"},
			{"id" : "hong", "name" : "홍길동"},
		];
		
		// jQuery each() 반복함수
		$.each(arr, function(index,item){
// 			alert(index);
// 			alert(item.id);
// 			alert(item.name);
//			기존태그에 내용을 뒤부분에 추가 append()
			$('#div1').append(item.id+":"+item.name+"<br>");
		});
		
		// id="btn" click() 클릭했을때 arr배열변수에 반복문을 통해서 접근 each()
		// id="table1" 테이블태그 뒤부분에 추가 append()
		// "<tr><td>"+item.id+"</td><td>"+item.name+"</td></tr>""
		$('#btn').click(function(){
			$.each(arr, function(index,item){
				$('#table1').append("<tr><td>"+item.id+"</td><td>"+item.name+"</td></tr>");
			});
		});
	});
</script>
</head>
<body>
<div id="div1"></div>
<input type="button" value="버튼" id="btn">
<table id ="table1" border="1">
<tr><td>아이디</td><td>이름</td></tr>

</table>
</body>
</html>