<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test2.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		// 대상.attr(태그속성, 값)
		$('#img1').attr('width', 500);
		$('#img1').attr('border',4);
		$('#img1').attr('src','2.jpg');
		
		// 대상.html() => 대상에 html 값 넣기(기존 내용 없어짐)
		$('h1').html("내용넣기");
		$('#dd').html("아이디 중복");
	});
</script>
</head>
<body>
<h1>head-0</h1>
<div id="dd"></div>

<img src="1.jpg" id="img1">
</body>
</html>