<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
<meta name="description" content="">
<meta name="author" content="">
<link rel="icon" href="../../favicon.ico">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="./resources/css/bootstrap.min.css" />

<link href="./resources/css/cover.css" rel="stylesheet">

<script src="../../assets/js/ie-emulation-modes-warning.js"></script>
</head>
<body>
	<div class="site-wrapper">

		<div class="site-wrapper-inner">
			<div class="cover-container">
				<%@ include file="header_user.jsp"%>
				<div class="cover-container">
					<h1>상세정보</h1>
				</div>
				<%
					String user_id = request.getParameter("id");
				%>
				<%@include file="dbconn.jsp"%>
				<%
					PreparedStatement pstmt = null;
				ResultSet rs = null;
				String sql = "select * from puppydb where id ='" + user_id + "'";
				pstmt = conn.prepareStatement(sql);
				rs = pstmt.executeQuery();
				while (rs.next()) {
				%>
				<div class="container">
					<div class="rwo">
						<div class="col-md-5">
							<img src="file:///Users/taeyang/git/happy/Happy_Puppy/WebContent/resources/images/<%=rs.getString("fileName")%>"
								style="width: 100%" />
						</div>
						<div class="col-md-6">
							<h3><%=rs.getString("name")%></h3>
							<p>
							<h4>
								아이디 :
								<%=rs.getString("id")%></h4>
							<p>
								나이 :
								<%=rs.getString("age")%>
							<p>
								성별 :
								<%=rs.getString("sex")%>
							<p>
								생일 :
								<%=rs.getString("birth")%>
							<p>
								몸무게 :
								<%=rs.getString("weight")%>
							<p>
								평균 산책 횟수 :
								<%=rs.getString("walk")%>
							<p>
								목욕 횟수 :
								<%=rs.getString("bath")%>
							<p>
								수면 시간 :
								<%=rs.getString("sleep")%>
							<p>
								사료 종류 :
								<%=rs.getString("feed")%>
							<p>
								알러지 :
								<%=rs.getString("allergy")%>
							<p>
								심박수 :
								<%=rs.getString("heart")%>
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

					</div>
				</div>


				<%@ include file="footer.jsp"%>

			</div>

		</div>
	</div>


</body>
</html>

