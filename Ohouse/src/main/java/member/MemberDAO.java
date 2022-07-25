package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	public Connection getConnection() throws Exception {
		// throws Exception : 예외처리는 함수호출하는 곳에서 하겠다
		
		// Connection Pool : 미리 디비연결을 서버에서 하고 디비연결 자원을 불러다가 사용
		// 				   : 서버에서 하나만 정의하고 자원의 이름을 불러다가 사용, 수정 최소화
				
		Context init = new InitialContext(); 
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		Connection con = ds.getConnection();
		return con;
	}

	// 회원가입하는 기능 => 함수정의
	// 리턴할 형 없음
	// 전달받은 값을 저장하는 변수=>매개변수
//	public void insertMember(String id,String pass,String name) {
	// MemberDTO 주소를 저장하는 변수
	public void insertMember(MemberDTO memberDTO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			// 1, 2 단계 디비연결 메서드 호출
			con = getConnection();
				
			// 3단계  연결정보를 이용해서 sql구문 만들기 =>  PreparedStatement
			// String sql="insert into 테이블이름(열이름,열이름) values(값,'값')";
			// String sql="insert into member(id,pass,name,email,address,phone,mobile) 
			// 													values(?,?,?,?,?,?,?)";
			String sql="insert into member(id,pass,name,date,email,address,phone,mobile,postcode,address2) values(?,?,?,now(),?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			// 객체생성 후 첫번째 ? 정수형 num 값 넣기, 두번째 ? 문자열 name 값 넣기
			pstmt.setString(1, memberDTO.getId());
			pstmt.setString(2, memberDTO.getPass());
			pstmt.setString(3, memberDTO.getName());
			pstmt.setString(4, memberDTO.getEmail());
			pstmt.setString(5, memberDTO.getAddress());
			pstmt.setString(6, memberDTO.getPhone());
			pstmt.setString(7, memberDTO.getMobile());
			pstmt.setString(8, memberDTO.getPostcode());
			pstmt.setString(9, memberDTO.getAddress2());
				
			//4단계   PrepardStatement sql구문 실행 (insert,update,delete)=>executeUpdate()
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 에러 발생 여부 상관없이 마무리 작업 => 내장객체 기억장소 해제
			if(pstmt != null) try { pstmt.close(); } catch (Exception e2) { 
			}
			if(con != null) try { con.close(); } catch (Exception e2) { 
				
			}
			System.out.println(memberDTO.getPostcode());
			System.out.println(memberDTO.getAddress2());
		}
		
		return;
	} // 회원가입 메서드 끝
	
	// 리턴할형 MemberDTO   userCheck(String id, String pass) 메서드 정의
	public MemberDTO userCheck(String id, String pass) {
		MemberDTO memberDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			// 디비연결
			con = getConnection();
			
			// sql구문
			String sql = "select * from member where id = ? and pass = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			 
			// 실행 => 결과 저장
			rs = pstmt.executeQuery();
			
			// 결과 다음행 이동 => 
			// 데이터 있으면 MemberDTO 객체생성 set메서드 => 열접근해서 값 저장
			if(rs.next()) {
				memberDTO = new MemberDTO();
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setMobile(rs.getString("mobile"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if(rs != null) try { rs.close();} catch (Exception e2) { }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e2) { }
			if(con != null) try { con.close(); } catch (Exception e2) { }
		}
		return memberDTO;
	}// userCheck() 메서드 끝
	
	// public 리턴할형 MemberDTO 함수이름 getMember(String id) 메서드 정의
	public MemberDTO getMember(String id) {
		MemberDTO memberDTO = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			
			String sql = "select * from member where id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				memberDTO = new MemberDTO();
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setMobile(rs.getString("mobile"));
				memberDTO.setPostcode(rs.getString("postcode"));
				memberDTO.setAddress2(rs.getString("address2"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 에러 발생 여부 상관없이 마무리 작업 => 내장객체 기억장소 해제
			System.out.println("마무리작업");
			if(rs != null) try { rs.close(); } catch (Exception e2) {  }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e2) {  }
			if(con != null) try { con.close(); } catch (Exception e2) {  }
		}
		return memberDTO;
	}// getMember() 메서드 끝
	
	// public void updateMember(MemberDTO 주소저장변수) 메서드 정의
	public void updateMember(MemberDTO updateDTO) {
		Connection con = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			
			// name email address phone mobile 수정,  조건 id =?
			String sql = "update member set name =?, email =?, address =?, phone =?, mobile =?, postcode =?, address2 =? where id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, updateDTO.getName());
			pstmt.setString(2, updateDTO.getEmail());
			pstmt.setString(3, updateDTO.getAddress());
			pstmt.setString(4, updateDTO.getPhone());
			pstmt.setString(5, updateDTO.getMobile());
			pstmt.setString(6, updateDTO.getPostcode());
			pstmt.setString(7, updateDTO.getAddress2());
			pstmt.setString(8, updateDTO.getId());
			
			pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 에러 발생 여부 상관없이 마무리 작업 => 내장객체 기억장소 해제
			if(pstmt != null) try { pstmt.close(); } catch (Exception e2) {  }
			if(con != null) try { con.close(); } catch (Exception e2) {  }
		}
	} // updateMember() 메서드 끝
	
	// 리턴할형 List<MemberDTO> getMemberList() 정의
	public List<MemberDTO> getMemberList() {
		List<MemberDTO> memberList = new ArrayList<MemberDTO>();
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			
			String sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO memberDTO = new MemberDTO();
				memberDTO.setId(rs.getString("id"));
				memberDTO.setPass(rs.getString("pass"));
				memberDTO.setName(rs.getString("name"));
				memberDTO.setDate(rs.getTimestamp("date"));
				memberDTO.setAddress(rs.getString("address"));
				memberDTO.setEmail(rs.getString("email"));
				memberDTO.setPhone(rs.getString("phone"));
				memberDTO.setMobile(rs.getString("mobile"));
				memberDTO.setPostcode(rs.getString("postcode"));
				memberDTO.setAddress2(rs.getString("address2"));
				// 배열 한칸에 저장
				memberList.add(memberDTO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			// 에러 발생 여부 상관없이 마무리 작업 => 내장객체 기억장소 해제
			System.out.println("마무리작업");
			if(rs != null) try { rs.close(); } catch (Exception e2) {  }
			if(pstmt != null) try { pstmt.close(); } catch (Exception e2) {  }
			if(con != null) try { con.close(); } catch (Exception e2) {  }
		}
		return memberList;
	}

} // MemberDAO 클래스 끝

