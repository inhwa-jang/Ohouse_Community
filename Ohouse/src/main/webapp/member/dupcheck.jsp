<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>member/dupcheck.jsp</title>
<script type="text/javascript">
	function resultok() {
		// join.jsp id value값 전달  <=  dupcheck.jsp id value값 찾은 값
		// join.jsp에서 dupcheck.jsp창을 열게 해줌 => join.jsp를 window.opener
		opener.document.fr.id.value = ducument.wfr.id.value;
		// dupcheck.jsp 창닫기
		window.close();
	}
</script>
</head>
<body>
<%
// http://localhost:8080/FunWeb_/member/dupcheck.jsp?id=kim

// id 파라미터 request 가져오기
String id = request.getParameter("id");

// MemberDAO 객체생성
MemberDAO memberDAO = new MemberDAO();
// MemberDTO memberDTO = getMember(id) 메서드 호출
MemberDTO memberDTO = memberDAO.getMember(id);

// memberDTO == null 이면 		=> id없음	=> 아이디 중복 아님	=> "아이디 사용 가능"
// memberDTO == null 아니면		=> id있음	=> "아이디 중복"
if(memberDTO == null) {
	// id없음	=> 아이디 중복 아님	=> "아이디 사용 가능"
		%>아이디 사용 가능<input type="button" value ="아이디사용" onclick="resultok()"><%
			
} else {
	// id있음	=> "아이디 중복"
		%>아이디 중복<%	
}
%>
<br>
<form action="dupcheck.jsp" method="get" name="wfr">
	아이디 : <input type="text" name="id" value="<%=id %>"><br>
	<input type="submit" value="아이디찾기">
</form>
</body>
</html>