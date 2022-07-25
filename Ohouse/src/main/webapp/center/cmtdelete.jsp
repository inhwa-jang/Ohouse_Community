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
int num = Integer.parseInt(request.getParameter("num"));

BoardDAO boardDAO = new BoardDAO();

// boardDAO.deleteComment(num);
%>
</body>
</html>