<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb/member/logout.jsp</title>
</head>
<body>
<%
// 세션내장객체 전체 삭제
session.invalidate();
%>

<script type="text/javascript">
	alert("로그아웃");
	location.href="../main/main.jsp";
</script>
</body>
</html>