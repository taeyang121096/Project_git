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
					<h1>반려동물 추천 사항</h1>
				</div>
				<%@include file="dbconn.jsp"%>
				<%
							PreparedStatement pstmt = null;
						ResultSet rs = null;
						String sql = "select * from recommand ";
						pstmt = conn.prepareStatement(sql);
						rs = pstmt.executeQuery();
						while (rs.next()) {
						%>
				<div class="col-md-4">
					<p>
						반려동물 추천 산책 횟수 :
						<%=rs.getString("walk")%>
					<p>
						반려동물 추천 목욕 회수 :
						<%=rs.getString("bath")%>
					<p>
						반려동물의 행동에 대처하는 방법 :
						<%=rs.getString("how")%>
					<p>
						반려동물에게 좋은 야채 :
						<%=rs.getString("veg")%>
					<p>
						반려동물에게 좋은 과일 :
						<%=rs.getString("fru")%>
					<p>
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

