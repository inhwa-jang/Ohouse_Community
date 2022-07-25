<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.text.DateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="member.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%

BoardDAO boardDAO = new BoardDAO();

List<BoardDTO> boardList = boardDAO.getBoardList(1, 16);

// 배열 List => JSONArray
SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
JSONArray jsonArray = new JSONArray();
for(int i= 0; i < boardList.size(); i++){
	BoardDTO dto = boardList.get(i);
	// MemberDTO => JSONObject
	JSONObject jsonObject = new JSONObject();
	jsonObject.put("num", dto.getNum());
	jsonObject.put("subject", dto.getSubject());
	jsonObject.put("name", dto.getName());
	jsonObject.put("date", dateFormat.format(dto.getDate()));
	jsonObject.put("readcount", dto.getReadcount());
	
	// JSONArray 한칸에 JSONObject 저장
	jsonArray.add(jsonObject);
	
}

%>
<%=jsonArray %>