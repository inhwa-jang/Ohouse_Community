<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jQuery/test7.jsp</title>
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	// 버튼 클릭 했을 때
	$('#btn').click(function(){
// 		alert("클릭");
		// test7_json.jsp에 가서 json(자바스크립트 배열) 데이터 가져와서 ajax
		// 반복 each() 테이블태그 뒤부분에 추가 append()
		$.ajax({
			url: 'test7_json.jsp',
			dataType: 'json',
			success : function(rdata){
				// rdata : json(배열변수)
				$.each(rdata,function(index,item){
					$('#table1').append("<tr><td>"+item.id+"</td><td>"+item.name+"</td></tr>");
				});
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
<tr><td>아이디</td><td>이름</td></tr>
</table>
</body>
</html>