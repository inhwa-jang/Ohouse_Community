<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>cmtdelete</title>
</head>
<body>
<%
int c_num = Integer.parseInt(request.getParameter("c_num"));

BoardDAO boardDAO = new BoardDAO();

boardDAO.deleteComment(c_num);


response.sendRedirect("notice.jsp");
%>
</body>
</html>