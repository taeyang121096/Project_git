<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>

<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>JoinCheck</title>
</head>
<body>
	<%@ include file="dbconn.jsp"%>

	<%
		// JOIN.jsp input 에서 입력한 회원가입에 필요한 값들을 변수에 담아준다
	String his_id = request.getParameter("JOIN_id");
	String his_pw = request.getParameter("JOIN_pw");
	String his_phone = request.getParameter("JOIN_phone");

	try {

		Statement st = conn.createStatement();
		String sql = "INSERT INTO member VALUES ('" + his_id + "','" + his_pw + "','" + his_phone + "')";
		st.executeUpdate(sql);

		// 회원가입에 성공하였으면 첫 페이지로 보낸다
		response.sendRedirect("login_user.jsp");

	} catch (Exception e) {
		out.println("DB 연동 실패");
	} finally {
		
		if (conn != null)
			conn.close();

	}
	%>

</body>
</html>


