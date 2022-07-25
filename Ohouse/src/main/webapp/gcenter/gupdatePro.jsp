<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>fcenter/fupdatePro.jsp</title>
</head>
<body>
<%
// request 한글처리
// request.setCharacterEncoding("utf-8");

//객체생성하면서 파일업로드 함
// webapp폴더안에 upload 폴더만들기 => 업로드폴더경로 : 물리적인 경로 
String uploadPath=request.getRealPath("/upload");
// 파일크기  10M
int maxSize=10*1024*1024;

//MultipartRequest multi=
// new MultipartRequest(request,업로드폴더경로,파일크기,한글처리,파일이름변경);
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// request num name subject content 파라미터값 가져오기
int num = Integer.parseInt(multi.getParameter("num"));
String name = multi.getParameter("name");;
String subject = multi.getParameter("subject");
String content = multi.getParameter("content");
// 파일 파라미터값 가져오기
String file = multi.getFilesystemName("file");

// 파일 파라미터가 없으면 (null이면) => oldfile 파라미터 가져오기
if(file == null){
	file = multi.getParameter("oldfile");
}

// BoardDTO 객체생성
BoardDTO boardDTO = new BoardDTO();

// set메서드 호출 파라미터값 저장
boardDTO.setNum(num);
boardDTO.setName(name);
boardDTO.setSubject(subject);
boardDTO.setContent(content);
// 파일 set메서드 호출 파라미터값 저장
boardDTO.setFile(file);

//BoardDAO 객체생성
BoardDAO boardDAO = new BoardDAO();
//리턴할형없음 updateBoard(BoardDTO boardDTO) 메서드 정의 
//subject content 수정  , 조건 num=?
//updateBoard(boardDTO)  메서드 호출
boardDAO.updateBoard(boardDTO);

//notice.jsp  이동
response.sendRedirect("gnotice.jsp");
%>

</body>
</html>