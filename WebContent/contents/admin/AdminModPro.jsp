<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	// 파라미터 가져오기
	String UserType = request.getParameter("UserType");
	String id = request.getParameter("id"); // "ID" 대신 "id"로 변경
	String pwd = request.getParameter("pwd"); // "PWD" 대신 "pwd"로 변경
	String username = request.getParameter("username"); // "UserName" 대신 "username"으로 변경
	String email = request.getParameter("email"); // "Email" 대신 "email"로 변경
	String PhoneNum = request.getParameter("phoneNum"); // "PhoneNum" 대신 "phoneNum"으로 변경
	String address = request.getParameter("address");

	Connection conn = null;
	PreparedStatement pstmt = null;

	try {
		// JDBC 드라이버 로드
		Class.forName("com.mysql.cj.jdbc.Driver"); // "com.mysql.jdbc.Driver"에서 "com.mysql.cj.jdbc.Driver"로 변경

		// 데이터베이스 연결
		String DB_URL = "jdbc:mysql://localhost:3306/juns_db?characterEncoding=UTF-8&serverTimezone=UTC";
		String DB_USER = "root";
		String DB_PASSWORD= "abcd";
		conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);

		// 사용자 정보 업데이트
		pstmt = conn.prepareStatement("UPDATE user SET UserType=?, PWD=?, UserName=?, Email=?, PhoneNum=?, Address=? WHERE ID=?");
		pstmt.setString(1, UserType);
		pstmt.setString(2, pwd);
		pstmt.setString(3, username);
		pstmt.setString(4, email);
		pstmt.setString(5, PhoneNum);
		pstmt.setString(6, address);
		pstmt.setString(7, id);

		// 업데이트 실행
		pstmt.executeUpdate();
		System.out.println("수정 완료.");
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		// 리소스 닫기
		try {
			if (pstmt != null) pstmt.close();
			if (conn != null) conn.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	// 리다이렉트
	response.sendRedirect("AdminUserList.jsp");
%>
