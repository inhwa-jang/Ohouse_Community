package member;

import java.sql.Timestamp;

public class MemberDTO {
	// Data Transfer Object : 데이터를 저장해서 전달해주는 자바파일
	// DB가 기준
	// 멤버변수 정의 => DB열 이름과 일치
	// private : 외부에서 접근하지 못함 => 은닉 
	private String id;
	private String pass;
	private String name;
	Timestamp date; 
	// 추가
	private String email;
	private String address;
	private String phone;
	private String mobile;
	// 추가 우편변호검색 우편번호 postcode,  상세주소 address2 : DB도 열이름 맞추기
	private String postcode;
	private String address2;
	
	// 멤버함수 메서드 정의 
	// 멤버변수를 외부에서 접근할 수 있게 메서드 정의 set() , get()
	// alt + shift + s -> r
	
	public String getId() {
	return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Timestamp getDate() {
		return date;
	}
	public void setDate(Timestamp date) {
		this.date = date;
	}
	public String getPostcode() {
		return postcode;
	}
	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	
	
}
