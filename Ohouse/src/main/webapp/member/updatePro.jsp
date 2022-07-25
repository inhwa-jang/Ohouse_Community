<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>WebFun/member/updatePro.jsp</title>
</head>
<body>
<%
// request 한글처리
request.setCharacterEncoding("utf-8");

// request에 저장된 id pass name email address phone mobile 파라미터 값 가져오기
String id = request.getParameter("id");
String pass = request.getParameter("pass");
String name = request.getParameter("name");
String email = request.getParameter("email");
String address = request.getParameter("address");
String phone = request.getParameter("phone");
String mobile = request.getParameter("mobile");
String postcode = request.getParameter("postcode");
String address2 = request.getParameter("address2");

// id pass 일치 여부 확인
// MemberDAO 객체생성
MemberDAO memberDAO = new MemberDAO();
// MemberDTO memberDTO = userCheck(id, pass) 메서드 호출
MemberDTO memberDTO = memberDAO.userCheck(id, pass);

if(memberDTO != null){
	// memberDTO 데이터 있으면 (null이 아니면) 아이디 비밀번호 일치
	//			=> 수정작업
	// 수정할 정보를 MemberDTO에 저장
	// MemberDTO updateDTO 객체생성
	MemberDTO updateDTO = new MemberDTO();
	
	// set호출 id pass name email address phone mobile 저장
	updateDTO.setId(id);
	updateDTO.setPass(pass);
	updateDTO.setName(name);
	updateDTO.setEmail(email);
	updateDTO.setAddress(address);
	updateDTO.setPhone(phone);
	updateDTO.setMobile(mobile);
	updateDTO.setPostcode(postcode);
	updateDTO.setAddress2(address2);
	
	// public void updateMember(MemberDTO 주소저장변수) 메서드 정의
	// name email address phone mobile 수정,  조건 id =?
	// MemberDAO 파일 안에 있는 updateMember(MemberDTO 주소)메서드 호출
	memberDAO.updateMember(updateDTO);
	
	//			=> main.jsp 이동
	response.sendRedirect("../main/main.jsp");
} else {
	%>
	<script type="text/javascript">
		// if memberDTO null이면 => 아이디 비밀번호 틀림 출력 , 뒤로 이동
		alert("아이디 비밀번호 틀림");
		history.back();
	</script>
	<%
}
%>
 
		
</body>
</html>