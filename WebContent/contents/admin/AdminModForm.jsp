<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
</head>
<body>
<%
    request.setCharacterEncoding("UTF-8");

    // 회원정보페이지에서 수정 버튼 클릭시 보내진 id 값 받기
    String id = request.getParameter("id");

    // 객체참조변수 선언
    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // DB 드라이버 로딩
        Class.forName("com.mysql.jdbc.Driver");

        // DB 연결, 객체생성
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/juns_db?characterEncoding=UTF-8&serverTimezone=UTC", "root", "abcd");

        // 쿼리문 준비
        pstmt = conn.prepareStatement("SELECT * FROM user WHERE ID=?");
        pstmt.setString(1, id);

        // 쿼리문 실행
        rs = pstmt.executeQuery();

        // 결과값 사용
        if (rs.next()) {
%>
<h1>회원정보 수정</h1>
<form action="AdminModPro.jsp" method="post">
    UserType <input type="text" name="UserType" value="<%=rs.getString("UserType")%>"><br>
    id <input type="text" name="id" value="<%=rs.getString("ID")%>" readonly><br>
    패스워드 변경 <input type="password" name="pwd" value="<%=rs.getString("PWD")%>"><br>
    이   름  변  경 <input type="text" name="username" value="<%=rs.getString("UserName")%>"><br>
    이 메 일 변 경 <input type="text" name="email" value="<%=rs.getString("Email")%>"><br>
    연 락 처 변 경 <input type="text" name="PhoneNum" value="<%=rs.getString("PhoneNum")%>"><br>
    주   소  변  경 <input type="text" name="address" value="<%=rs.getString("Address")%>"><br>
    <input type="submit" value="수정">
</form>
<%
        }
    } catch (Exception e) {
        e.printStackTrace(); // 적절한 예외 처리 (로깅 또는 오류 페이지 표시)
    } finally {
        try {
            // 리소스 닫기
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace(); // 적절한 예외 처리 (로깅 또는 오류 페이지 표시)
        }
    }
%>
</body>
</html>
