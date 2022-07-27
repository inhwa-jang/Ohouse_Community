<%@page import="board.BoardDAO"%>
<%@page import="board.CommentDTO"%>
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
//request 한글처리
request.setCharacterEncoding("utf-8");

// id comment 파라미터 가져오기
String id = request.getParameter("id");
String content = request.getParameter("content");
int num = Integer.parseInt(request.getParameter("num"));

//패키지 board 파일 CommentDTO
//멤버변수 정의, set get메서드 정의
//CommentDTO 객체생성
CommentDTO commentDTO = new CommentDTO();

//set 메서드 호출 파라미터값 저장
commentDTO.setId(id);
commentDTO.setContent(content);
commentDTO.setNum(num);

//패키지 board 파일 BoardDAO
BoardDAO boardDAO = new BoardDAO();
//BoardDAO 객체생성
//리턴할형 없음 insertBoard(BoardDTO boardDTO) 메서드 정의
//insertBoard(boardDTO 주소값) 호출
boardDAO.insertComment(commentDTO);
//content?.jsp 이동
response.sendRedirect("notice.jsp");
%>
<!-- <script type="text/javascript"> -->
<%-- 	alert("<%=id%>"); --%>
<%-- 	alert("<%=comment %>"); --%>
<%-- 	alert("<%=num %>"); --%>
<!-- </script> -->
</body>
</html>