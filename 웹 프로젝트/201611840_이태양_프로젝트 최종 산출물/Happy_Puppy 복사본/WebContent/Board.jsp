<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.PrintWriter"%>

<%@ page import="bbs.BbsDAO"%>

<%@ page import="bbs.Bbs"%>

<%@ page import="java.util.ArrayList"%>
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


<title>Protect Health</title>

<link href="./resources/css/bootstrap.min.css" rel="stylesheet">

<link href="./resources/css/cover.css" rel="stylesheet">

<script src="../../assets/js/ie-emulation-modes-warning.js"></script>

</head>

<body>
	<%
		int pageNumber = 1; //기본 페이지 넘버
	//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값

	String userID = null;

	if (session.getAttribute("id") != null) {

		userID = (String) session.getAttribute("id");
	}

	String adminID = null;
	if (session.getAttribute("admin_id") != null) {
		adminID = (String) session.getAttribute("admin_id");

	}
	//페이지넘버값이 있을때

	if (request.getParameter("pageNumber") != null) {

		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));

	}
	%>

	<!-- 네비게이션  -->



	<div class="site-wrapper">

		<div class="site-wrapper-inner">

			<div class="cover-container">

				<%@ include file="header_user.jsp"%>
				<!-- 게시판 -->

				<div class="container" style="background-color: #eeeeee;">

					<div class="table">

						<table class="table table-striped"
							style="text-align: center; border: 1px solid #dddddd">

							<thead>

								<tr>

									<th style="background-color: #eeeeee; text-align: center;">번호</th>

									<th style="background-color: #eeeeee; text-align: center;">제목</th>

									<th style="background-color: #eeeeee; text-align: center;">작성자</th>

									<th style="background-color: #eeeeee; text-align: center;">작성일</th>

								</tr>

							</thead>

							<tbody>
								<%
									BbsDAO bbsDAO = new BbsDAO();

								ArrayList<Bbs> list = bbsDAO.getList(pageNumber);

								for (int i = 0; i < list.size(); i++) {
								%>

								<tr>

									<td><%=list.get(i).getBbsID()%></td>

									<td><a href="view.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a></td>

									<td><%=list.get(i).getUserID()%></td>

									<td><%=list.get(i).getBbsDate().substring(0, 10)%></td>



								</tr>



								<%
									}
								%>



							</tbody>

						</table>



						<!-- 회원만넘어가도록 -->





					</div>


				</div>
				<%
							//if logined userID라는 변수에 해당 아이디가 담기고 if not null

						if (session.getAttribute("id") != null) {
						%>

				<a href="write.jsp" class="btn btn-light pull-right">글쓰기</a>

				<%
							} else {

						}
						%>
				<%@ include file="footer.jsp"%>


			</div>

		</div>

	</div>








</body>

</html>

