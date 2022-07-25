<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Ohouse</title>
<link href="../css/default.css?after2" rel="stylesheet" type="text/css">
<link href="../css/front.css?after" rel="stylesheet" type="text/css">

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
<!-- 헤더파일들어가는 곳 -->
<jsp:include page ="../inc/top.jsp"></jsp:include>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><img src="../images/main_home.jpg"
 width="971" height="282"></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<div id="solution">
<div id="hosting">
<h3>오늘의 스토리</h3>
<p>우드와 화이트 톤으로 따뜻하게<br>
미니멀 무드로 더 건강하게!<br>
부분 시공과 스타일링만으로 완성</p>
</div>
<div id="security">
<h3>오늘의 기획전</h3>
<p>여름 가전 페스타 ~68% 특가 <br>
 5월호 월간 키친 베스트 ~88% 특가 <br>
 한정수량 프리미엄 특가</p>
</div>
<div id="payment">
<h3>오늘의 시공리뷰</h3>
<p>초록뷰 구축빌라 🌳</br> 우리에게 딱맞게 고치기</br></br>
  여러집에 살았던 경험을 담은</br>클래식한 하우스 🏠</p>
</div>
</div>
<%
BoardDTO boardDTO = new BoardDTO();
BoardDAO boardDAO=new BoardDAO();
int pageSize = 5;

String pageNum=request.getParameter("pageNum");

if(pageNum == null){
	pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage-1)*pageSize+1; 
int endRow = startRow+pageSize - 1;

List<BoardDTO> boardList = boardDAO.getBoardList(startRow, pageSize);
List<BoardDTO> boardList2 = boardDAO.getBestBoardList(startRow, pageSize);

SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy.MM.dd");
%>
<div class="clear"></div>

<div id="sec_news">
<h3 class="orange">인기글 바로가기</h3>
<table>
<% 
for(int i=0; i<boardList2.size(); i++){
	boardDTO=boardList2.get(i);
	%>
	<tr>
	<td class="contxt"><a href="../center/content.jsp?num=<%=boardDTO.getNum()%>"><%=boardDTO.getSubject() %></a></td>
    <td>조회수 <%=boardDTO.getReadcount() %></td>
	</tr>
	<%
	}
	%>
</table>
</div>

<div id="news_notice">
<h3 class="brown">최신글 바로가기</h3>
<table>
<% 
for(int i=0; i<boardList.size(); i++){
	boardDTO=boardList.get(i);
	%>
	<tr>
	<td class="contxt"><a href="../center/content.jsp?num=<%=boardDTO.getNum()%>"><%=boardDTO.getSubject() %></a></td>
    <td><%=dateFormat.format(boardDTO.getDate())%></td>
	</tr>
	<%
	}
	%>

</table>
</div>

</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page ="../inc/bottom.jsp"></jsp:include>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>