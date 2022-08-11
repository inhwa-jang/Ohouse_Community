<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb/member/update.jsp</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
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
 <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 <script type="text/javascript">
 function findPostCode() {
	    new daum.Postcode({
	        oncomplete: function(data) {
	            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	            var addr = ''; // 주소 변수


	            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                addr = data.roadAddress;
	            } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                addr = data.jibunAddress;
	            }

	            // 우편번호와 주소 정보를 해당 필드에 넣는다.
	            document.getElementById("postcode").value = data.zonecode;
	            document.getElementById("address").value = addr;
	            // 커서를 상세주소 필드로 이동한다.
	            document.getElementById("detailadd").focus();
	        }
	    }).open();
	}
 </script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page ="../inc/top.jsp"></jsp:include>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="../member/join.jsp">가입하기</a></li>
<li><a href="../main/main.jsp">홈</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<%
// String id = 세션값 가져오기
String id = (String)session.getAttribute("id");
// MemberDAO 객체생성
MemberDAO memberDAO = new MemberDAO();
// public 리턴할형 MemberDTO 함수이름 getMember(String id) 메서드 정의
// MemberDTO memberDTO = getMember(id) 메서드 호출
MemberDTO memberDTO = memberDAO.getMember(id);
%>
<article>
<h1>회원 정보 수정</h1>
<form action="updatePro.jsp" id="join" method="post">
<fieldset>
<legend>Basic Info</legend>
<label>User ID</label>
<input type="text" name="id" class="id" value="<%=memberDTO.getId() %>" readonly>
<input type="button" value="dup. check" class="dup"><br>
<label>Password</label>
<input type="password" name="pass"><br>
<label>Retype Password</label>
<input type="password" name="pass2"><br>
<label>Name</label>
<input type="text" name="name" value="<%=memberDTO.getName() %>"><br>
<label>E-Mail</label>
<input type="email" name="email" value="<%=memberDTO.getEmail() %>"><br>

</fieldset>

<fieldset>
<legend>Optional</legend>
<!-- <label>Address</label> -->
<%-- <input type="text" name="address" value="<%=memberDTO.getAddress() %>"><br> --%>
<label>Postcode</label>
<input type="text" name="postcode" value="<%=memberDTO.getPostcode() %>" id="postcode">
<input type="button" class ="dup" onclick="findPostCode()" value="우편번호 찾기"><br>
<label>Address</label>
<input type="text" id="address" name="address" value="<%=memberDTO.getAddress() %>"><br>
<label>Address-detail</label>
<input type="text" id="detailadd" name="address2" value="<%=memberDTO.getAddress2() %>"><br>
<label>Phone Number</label>
<input type="text" name="phone" value="<%=memberDTO.getPhone() %>"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile" value="<%=memberDTO.getMobile() %>"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons">
<input type="submit" value="Submit" class="submit">
<input type="reset" value="Cancel" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page ="../inc/bottom.jsp"></jsp:include>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>
</html>