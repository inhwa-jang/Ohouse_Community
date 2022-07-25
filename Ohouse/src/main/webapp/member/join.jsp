<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>FunWeb/member/join.jsp</title>
<link href="../css/default.css?after" rel="stylesheet" type="text/css">
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
<script type="text/javascript" src="../script/jquery-3.6.0.js"></script>
<script type="text/javascript">
	$(document).ready(function(){
		// id = "join" submit() 이벤트
		$('#join').submit(function(){
// 			alert("이벤트");
			if($('#id').val()=="") {
				alert("아이디를 입력하세요");
				$('#id').focus();
				return false;
			}
			// pass pass2 name email email2
			if($('#pass').val()=="") {
				alert("비밀번호를 입력하세요");
				$('#pass').focus();
				return false;
			}
			if($('#pass2').val()=="") {
				alert("비밀번호 확인란을 입력하세요");
				$('#pass2').focus();
				return false;
			}
			if($('#pass').val() != $('#pass2').val()) {
				alert("비밀번호가 일치하지 않습니다");
				$('#pass').focus();
				return false;
			}
			if($('#name').val()=="") {
				alert("이름을 입력하세요");
				$('#name').focus();
				return false;
			}
			if($('#email').val()=="") {
				alert("이메일을 입력하세요");
				$('#email').focus();
				return false;
			}
			if($('#email2').val()=="") {
				alert("이메일 확인란을 입력하세요");
				$('#email2').focus();
				return false;
			}
			if($('#email').val() != $('#email2').val()) {
				alert("이메일이 일치하지 않습니다");
				$('#email').focus();
				return false;
			}
		});
	});
	
	$(document).ready(function(){
		// id="dup" 클릭했을 때 dupcheck2.jsp 페이지에 id="id" val() 값을 가지고 가서
		// 아이디 중복체크한 출력결과를 가져와서 id="dupdiv"에 출력
		$('#dup').click(function(){
			$.ajax({
				url:'dupcheck2.jsp',
				data:{'id':$('#id').val()},
				success: function(rdata){
					// id="iddiv"에 들고온 데이터 rdata를 내용 넣기
					$('#dupdiv').html(rdata);
				}
			});
		});
	});
</script>

<!-- 다음 주소 api  -->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
 
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page ="../inc/top.jsp"></jsp:include>

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

<!-- </script> -->

<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<nav id="sub_menu">
<ul>
<li><a href="#">가입하기</a></li>
<li><a href="../main/main.jsp">홈</a></li>
</ul>
</nav>
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<h1>멤버쉽</h1>
<form action="joinPro.jsp" id="join" name="fr" method="post">
<fieldset>
<legend>회원가입</legend>
<!-- 아이디 -->
<label>User ID</label>
<input type="text" name="id" class="id" id="id">
<!-- <input type="button" value="아이디 중복확인" class="dup" onclick="dupcheck()"><br> -->
<input type="button" value="아이디 중복확인" class="dup" id="dup"><br>
<label></label>
<div id="dupdiv"></div><br>
<!-- 아이디 -->
<label>Password</label>
<input type="password" name="pass" id="pass"><br>
<label>Retype Password</label>
<input type="password" name="pass2" id="pass2"><br>
<label>Name</label>
<input type="text" name="name" id="name"><br>
<label>E-Mail</label>
<input type="email" name="email" id="email"><br>
<label>Retype E-Mail</label>
<input type="email" name="email2" id="email2"><br>
</fieldset>
<fieldset>
<legend>선택사항</legend>
<label>Postcode</label>
<input type="text" name="postcode" placeholder="우편번호" id="postcode">
<input type="button" class ="dup" onclick="findPostCode()" value="우편번호 찾기"><br>
<label>Address</label>
<input type="text" id="address" name="address" placeholder="주소"><br>
<label>Address-detail</label>
<input type="text" id="detailadd" name="address2" placeholder="상세주소"><br>
<label>Phone Number</label>
<input type="text" name="phone"><br>
<label>Mobile Phone Number</label>
<input type="text" name="mobile"><br>
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