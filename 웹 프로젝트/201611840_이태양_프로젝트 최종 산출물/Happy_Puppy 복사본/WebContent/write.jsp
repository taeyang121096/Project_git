<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>
<jsp:useBean id="user" class="user.user" scope="page" />

<jsp:setProperty name="user" property="id" />

<jsp:setProperty name="user" property="pw" />

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

<link href="./resources/css/bootstrap.min.css" rel="stylesheet">

<link href="./resources/css/cover.css" rel="stylesheet">

<script src="../../assets/js/ie-emulation-modes-warning.js"></script>
</head>

<body>

	<%
		//로긴한사람이라면    userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값

	String userID = null;

	if (session.getAttribute("id") != null) {

		userID = (String) session.getAttribute("id");

	}

	String adminID = null;
	if (session.getAttribute("admin_id") != null) {
		adminID = (String) session.getAttribute("admin_id");

	}
	%>








	<div class="site-wrapper">

		<div class="site-wrapper-inner">

			<div class="cover-container">

				<%@ include file="header_user.jsp"%>
				<!-- 게시판 -->

				<div class="container">

					<div class="container-fluid">

						<form method="post" action="writeAction.jsp">

							<table class="table" style="text-align: center;">

								<thead>

									<tr>

										<th colspan="2"
											style="background-color: #eeeeee; text-align: center;">게시판
											</th>

									</tr>

								</thead>

								<tbody>

									<tr>

										<td><input type="text" class="form-control"
											placeholder="글 제목" name="bbsTitle" maxlength="50" /></td>

									</tr>
									<tr>

										<td><textarea class="form-control" placeholder="글 내용"
												name="bbsContent" maxlength="2048" style="height: 350px;"></textarea></td>

									</tr>

								</tbody>

							</table>

							<input type="submit" class="btn btn-light pull-right" value="글쓰기" />

						</form>

					</div>

				</div>
				<%@ include file="footer.jsp"%>



			</div>

		</div>

	</div>























	<!-- 애니매이션 담당 JQUERY -->

	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

	<!-- 부트스트랩 JS  -->

	<script src="js/bootstrap.js"></script>



</body>

</html>


