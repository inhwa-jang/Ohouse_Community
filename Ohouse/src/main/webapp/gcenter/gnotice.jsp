<%@page import="java.text.SimpleDateFormat"%>
<%@page import="board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<style type="text/css">
	#rr{
	color: red;
	}
</style>
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
<jsp:include page="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../gcenter/gnotice.jsp">사진 모아보기</a></li>
<!-- <li><a href="#">Public News</a></li> -->
<li><a href="../fcenter/fnotice.jsp">사진 다운로드</a></li>
<!-- <li><a href="#">Service Policy</a></li> -->
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 게시판 -->
<%
// BoardDAO 객체 생성
BoardDAO boardDAO=new BoardDAO();
// 한페이지에 보여줄 글개수 지정
int pageSize=15;

//http://localhost:8080/FunWeb/center/notice.jsp
//http://localhost:8080/FunWeb/center/notice.jsp?pageNum=2
// 페이지 번호 가져오기 
String pageNum=request.getParameter("pageNum");
// 페이지 번호가 없으면 "1"페이지 지정
if(pageNum==null){
	pageNum="1";
}
// pageNum   pageSize 조합해서 => startRow 시작하는 행번호 구하기 => 식(알고리즘)
// pageNum => 문자열 정수형 변경 
int currentPage=Integer.parseInt(pageNum);
// pageNum pageSize  => startRow
//    1       10     =>    (1-1)*10+1=> 0*10+1=> 0+1=>1
//    2       10     =>    (2-1)*10+1=> 1*10+1=>10+1=>11
//    3       10     =>    (3-1)*10+1=> 2*10+1=>20+1=>21
int startRow =(currentPage-1)*pageSize+1; 

// startRow pageSize 조합해서 => endRow 끝나는 행번호 구하기 => 식(알고리즘)
// startRow pageSize  => endRow
//    1        10     =>   10
//    11       10     =>   20
//    21       10     =>   30
int endRow=startRow+pageSize-1;


// 리턴할형 List   getBoardList()메서드 정의
// BoardDTO 여러개를 담을수 있는 자바 배열형태의 내장객체List에 담아서 리턴받아옴
// List<BoardDTO> boardList = getBoardList() 메서드 호출
// List<BoardDTO> boardList=boardDAO.getBoardList();
// List<BoardDTO> boardList=boardDAO.getBoardList(시작하는 행번호,한페이지 보여줄글개수);
// select * from board order by num desc limit 시작하는 행번호-1,한페이지 보여줄글개수
List<BoardDTO> boardList=boardDAO.getBoardList(startRow, pageSize);

//날짜 => 문자열(원하는 포맷) 변경
SimpleDateFormat dateFormat=new SimpleDateFormat("yyyy.MM.dd");
%>
<article>
<h1>사진 모아보기</h1>
<table id="notice">
<!-- <tr><th class="tno">No.</th> -->
<!--     <th class="ttitle">Title</th> -->
<!--     <th class="twrite">Writer</th> -->
<!--     <th class="tdate">Date</th> -->
<!--     <th class="tread">Read</th></tr> -->
    <tr>
    <%
    // 배열크기 : boardList.size()
    for(int i=0;i<boardList.size();i++){
    	//배열 한칸 데이터 가져올때 boardList.get()
    	// 모든형 => 자식형 형변화(다운캐스팅)
//     	BoardDTO boardDTO=(BoardDTO)boardList.get(i);
    	// List<BoardDTO> 데이터 타입으로 가져오면 형변환없이 사용가능
    	BoardDTO boardDTO=boardList.get(i);
    	%>
 
     <td class="left">
     <%= i+1 %><br>
     <a  href="gcontent.jsp?num=<%=boardDTO.getNum()%>">
     <img src="../upload/<%=boardDTO.getFile()%>" width="200" height="200">
     </a><br>
     <%=boardDTO.getSubject() %><br>
     <%=boardDTO.getName() %><br>
     <%=dateFormat.format(boardDTO.getDate())%><br>
     <%=boardDTO.getReadcount() %>
    </td>
    
    	<%
    	if((i+1)%3 == 0) {
    		%>
<!--        다음줄로 내림 -->
    		</tr><tr>
    		<%
    	}
    }
    %>
      </tr>   	
</table>
<div id="table_search">
<input type="text" name="search" class="input_box">
<input type="button" value="search" class="btn">
</div>
<%
// String id = 세션값을 가져오기 
String id=(String)session.getAttribute("id");
// 세션값이 있으면 글쓰기 버튼 보이기
if(id!=null){
	%>
<div id="table_search">
<input type="button" value="글쓰기" class="btn" 
    onclick="location.href='gwrite.jsp'">
</div>
	<%
}
%>
<div class="clear"></div>
<div id="page_control">
<%
// 1~10 11~20 페이지번호 구하기
// 한화면에 보여줄 페이지개수 설정
int pageBlock=10;
// 시작하는 페이지 번호
// pageNum(currentPage) pageBlock =>  startPage
//        1~10(0~9)         10    =>  (currentPage-1)/10*10+1 => 0*10+1=>0+1=>1
//        11~20(10~19)      10    =>  (currentPage-1)/10*10+1=> 1*10+1=>10+1=>11
//        21~30(20~29)      10    =>  (currentPage-1)/10*10+1=> 2*10+1=>20+1=>21
int startPage=(currentPage-1)/pageBlock*pageBlock+1;
// 끝나는 페이지 번호
// startPage pageBlock => endPage
//       1        10    =>   10
//      11        10    =>   20
//      21        10    =>   30
int endPage=startPage+pageBlock-1;
// 구한 끝나는 페이지번호 10 , 실제 페이지 번호(전체페이지개수) 2

//글개수 구하기 
// 리턴할형int  getBoardCount() 메서드 정의  select count(*) from board
// int count= getBoardCount() 메서드 호출
int count=boardDAO.getBoardCount();

// 전체 페이지 개수 구하기 => 글개수 50 , 한화면에 보여줄 글개수 10 => 페이지개수 5 +0 => 5
// 전체 페이지 개수 구하기 => 글개수 57 , 한화면에 보여줄 글개수 10 => 페이지개수 5 +1 => 6
int pageCount= count/pageSize+ (count%pageSize==0?0:1);

if(endPage > pageCount){
	endPage=pageCount;
}
%>
<%
if(startPage > pageBlock){
	%><a href="gnotice.jsp?pageNum=<%=startPage-pageBlock %>">Prev</a><%
}

for(int i=startPage;i<=endPage;i++){
	if(i==currentPage){
		%>
		<span id="rr"><%=i %></span>
		<%
	}else{
		%>
		<a href="gnotice.jsp?pageNum=<%=i %>"><%=i %></a>
		<%
	}
	
}

if(endPage < pageCount){
	%>
	<a href="gnotice.jsp?pageNum=<%=startPage+pageBlock %>">Next</a>
	<%
}
%>

</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>