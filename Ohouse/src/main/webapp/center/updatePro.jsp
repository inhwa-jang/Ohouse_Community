<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");

// request num name subject content 파라미터값 가져오기
int num = Integer.parseInt(request.getParameter("num"));
String name = request.getParameter("name");
String pass = request.getParameter("pass");
String subject = request.getParameter("subject");
String content = request.getParameter("content");

// BoardDTO 객체생성
BoardDTO boardDTO = new BoardDTO();

// set메서드 호출 파라미터값 저장
boardDTO.setNum(num);
boardDTO.setName(name);
boardDTO.setSubject(subject);
boardDTO.setContent(content);

//BoardDAO 객체생성
BoardDAO boardDAO = new BoardDAO();
//리턴할형없음 updateBoard(BoardDTO boardDTO) 메서드 정의 
//subject content 수정  , 조건 num=?
//updateBoard(boardDTO)  메서드 호출
boardDAO.updateBoard(boardDTO);

//notice.jsp  이동
response.sendRedirect("notice.jsp");
%>

</body>
</html>