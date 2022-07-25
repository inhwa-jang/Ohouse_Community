<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/writePro.jsp</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");

// pass name subject content 파라미터 가져오기
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// num 데이터베이스 최대 num+1 구하기, readcount = 0 설정, date 시스템날짜
int readcount = 0;

// 패키지 board 파일 BoardDTO
// 멤버변수 정의, set get메서드 정의
// BoardDTO 객체생성
BoardDTO boardDTO = new BoardDTO();
// set 메서드 호출 파라미터값 저장
boardDTO.setName(name);
boardDTO.setPass(pass);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
boardDTO.setReadcount(readcount);

// 패키지 board 파일 BoardDAO
BoardDAO boardDAO = new BoardDAO();
// BoardDAO 객체생성
// 리턴할형 없음 insertBoard(BoardDTO boardDTO) 메서드 정의
// insertBoard(boardDTO 주소값) 호출
boardDAO.insertBoard(boardDTO);
// notice.jsp 이동
response.sendRedirect("notice.jsp"); 
%>
</body>
</html>