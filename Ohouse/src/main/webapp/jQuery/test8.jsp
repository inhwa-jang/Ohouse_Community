<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test8.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$('#btn').click(function(){
// 		alert("클릭");
		$.ajax({
			url : 'test8_json.jsp',
			dataType: 'json',
			success : function(rdata) {
				$.each(rdata,function(index,item){
					$('#table1').append("<tr><td>"+item.id+"</td><td>"+item.pass+"</td><td>"+item.name+"</td></tr>");
				})
			}
		});
		// 이벤트 한번만 실행하고 종료
		$(this).unbind();
	});
});
</script>
</head>
<body>
<input type="button" value="버튼" id="btn">
<table id ="table1" border="1">
<tr><td>아이디</td><td>비밀번호</td><td>이름</td></tr>
</table>
</body>
</html>