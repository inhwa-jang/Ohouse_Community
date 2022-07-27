<%@page import="java.util.List"%>
<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="board.CommentDTO"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>center/write.jsp</title>
<link href="../css/default.css?after2" rel="stylesheet" type="text/css">
<link href="../css/subpage.css?after" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page ="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../center/notice.jsp">온라인 집들이</a></li>
<li><a href="../fcenter/fnotice.jsp">사진 다운로드</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 게시판 -->
<%
// content.jsp?num = 1
// request에서 num 가져오기
int num = Integer.parseInt(request.getParameter("num"));

// BoardDAO 객체생성
BoardDAO boardDAO = new BoardDAO();

// 게시판 글 조회수 1 증가
// 리턴할형 없음 updateReadcount(int num) 메서드 정의
// update board set readcount = readcount + 1 where num = ?
// updateReadcount(int num)메서드 호출
boardDAO.updateReadcount(num);

// 리턴할형 BoardDTO getBoard(int num) 메서드 정의 
// BoardDTO boardDTO = getBoard(num) 메서드 호출
BoardDTO boardDTO = boardDAO.getBoard(num);
%>
<article>
<h1>온라인 집들이 게시판</h1>
<table id="notice">
<tr><td>글번호</td><td><%=boardDTO.getNum() %></td>
	<td>등록일</td><td><%=boardDTO.getDate() %></td></tr>
<tr><td>글쓴이</td><td><%=boardDTO.getName() %></td>
	<td>조회수</td><td><%=boardDTO.getReadcount() %></td></tr>
<tr><td>글제목</td><td colspan="3"><%=boardDTO.getSubject() %></td></tr>
<tr><td>글내용</td><td colspan="3"><%=boardDTO.getContent() %></td></tr>
</table>

<div id="table_search">

<%
// 로그인, 글쓴이 일치하면 => 글수정, 글삭제 버튼 보이기
// String id = 세션값 가져오기
String id = (String)session.getAttribute("id");

// 세션값 null이 아니면 
if(id != null) {
	// 로그인 글쓴이 비교
	if(id.equals(boardDTO.getName())) {
		%>
		<input type="button" value="글수정" class="btn" onclick="location.href='update.jsp?num=<%= boardDTO.getNum() %>'" />
		<input type="button" value="글삭제" class="btn" onclick="location.href='delete.jsp?num=<%= boardDTO.getNum() %>'" />
		<%
	}	
}

%>
<input type="button" value="글목록" class="btn" onclick="location.href='notice.jsp'" />
</div>

<div class="clear"></div>

</article>
<!-- 댓글쓰기창 -->
<%
CommentDTO commentDTO = boardDAO.getComment();

List<CommentDTO> commentList = boardDAO.getCommentList(num);

 if(id != null ){
	 %>
	<article>
	<form action="cmtwrite.jsp" method="post" name="cmtFr">
	<table>
	<tr><td><input type="hidden" name="num" value="<%=boardDTO.getNum() %>" /></td></tr>
	<tr><td>댓글작성자</td><td><input type="text" name="id" value="<%=id %>" readonly></td></tr>
	<tr><td>댓글내용</td><td><textarea name="content" placeholder="댓글을 입력해주세요"></textarea></td></tr>
	</table>
	<input type="submit" value="댓글작성" class="btn"/>
	</form>
	
<!-- 	댓글목록 -->
	<table>
	 <% 
	 for(int i = 0; i<commentList.size(); i++){
		commentDTO = commentList.get(i);
		if(commentDTO != null) {
			%>
			<tr><td><input type="hidden" name="c_num" value="<%=commentDTO.getC_num() %>"/></td></tr>
			<tr><td>댓글작성자 <%=commentDTO.getId() %></td></tr>
			<tr><td>댓글내용 <%=commentDTO.getContent() %></td></tr>
			<tr><td><%=commentDTO.getDate() %></td></tr>
			<%
			if(id.equals(commentDTO.getId())){
				%>
				<tr><td><input type="button" value="삭제" class="btn" onclick="location.href='cmtdelete.jsp?c_num=<%= commentDTO.getC_num() %>&num=<%=boardDTO.getNum() %>'" /></td></tr>
				<%
			}
			%>
			<%	
		}
		%>
	 <% 
	 }
	%>
	</table>
	<%
 }
%>



</article>
<!-- 댓글 -->

<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page ="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>