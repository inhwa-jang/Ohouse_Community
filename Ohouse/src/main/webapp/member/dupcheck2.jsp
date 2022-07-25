<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// jQuery/test5_idcheck.jsp?id=kim
// 서버 request에 저장, id파라미터 가져오기
String id = request.getParameter("id");

// MemberDAO 객체생성
MemberDAO memberDAO = new MemberDAO();

// MemberDTO memberDTO = getMEmber(id) 메서드 호출
MemberDTO memberDTO = memberDAO.getMember(id);

if(memberDTO == null) {
	// 아이디 없음 => 아이디 사용가능
	%>아이디 사용가능<%
} else {
	// 아이디 있음 => 아이디 중복
	%>아이디 중복<%
}
%>