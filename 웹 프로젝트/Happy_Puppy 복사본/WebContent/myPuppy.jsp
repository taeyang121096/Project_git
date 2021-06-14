<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="dto.Puppy"%>

<%@ page import="dao.PuppyRepository"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">

<title>Protect Health</title>

<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />

<link href="./resources/css/cover.css" rel="stylesheet">

<script src="../../assets/js/ie-emulation-modes-warning.js"></script>

</head>

<body>

	<div class="site-wrapper">

		<div class="site-wrapper-inner">

			<div class="cover-container">

				<%@ include file="header_user.jsp"%>
				<div class="cover-header">
					<h1>반려동물 정보</h1>
				</div>
				<div class="container">
					<div class="text-right">
						<a href="delPuppy.jsp" class="btn btn-light">삭제</a>
						
						
					</div>
				</div>

				<%
							String user_id = (String) session.getAttribute("id");
						
						%>
				<%@include file="dbconn.jsp"%>
				<%
							PreparedStatement pstmt = null;
						ResultSet rs = null;
						String sql = "select * from puppydb where id ='"+user_id+"'";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						if(rs.isBeforeFirst()==false)
							response.sendRedirect("addPuppy.jsp");
						while (rs.next()) {
						%>
				<div class="col-md-4">
					<img src="file:///Users/taeyang/git/happy/Happy_Puppy/WebContent/resources/images/<%=rs.getString("fileName")%>"
						style="width: 100%">
					<p>
						아이디 :
						<%=rs.getString("id")%>
					<p>
						이름 :
						<%=rs.getString("name")%>
					<p>
						성 :
						<%=rs.getString("sex")%>
					<p>
						나이 :
						<%=rs.getString("age")%>
					<p>
						생일 :
						<%=rs.getString("birth")%>
					<p>
						<a href="./myPuppy_info.jsp?id=<%=rs.getString("id")%>"
							class="btn btn-default" role="button">상세 정보 &raquo;></a>
				</div>
				<%
							}
						%>
				<%
							if (rs != null)
							rs.close();
						if (pstmt != null)
							pstmt.close();
						if (conn != null)
							conn.close();
						%>



				<%@ include file="footer.jsp"%>


			</div>

		</div>

	</div>
</body>
</html>

