<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="reply.replyDAO"%>
<%@ page import="java.io.PrintWriter"%>
<%
	request.setCharacterEncoding("UTF-8");
response.setContentType("text/html; charset=UTF-8");
%>

<jsp:useBean id="reply" class="reply.reply" scope="page" />
<jsp:setProperty name="reply" property="bbsID" /><!-- bbs.setBbsTitle(requrst) -->
<jsp:setProperty name="reply" property="replyContent" />

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
		String userID = null;

	if (session.getAttribute("id") != null) {

		userID = (String) session.getAttribute("id");
	}

	String adminID = null;
	if (session.getAttribute("admin_id") != null) {
		adminID = (String) session.getAttribute("admin_id");

	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('잘못된 접근입니다.')");
		script.println("history.back();");
		script.println("</script>");
	} else {
		if (reply.getReplyContent() == null) {
			PrintWriter script = response.getWriter();

			script.println("<script>");
			script.println("alert('내용을 입력해 주세요')");
			script.println("history.back()");
			script.println("</script>");
		} else {

			replyDAO ReplyDAO = new replyDAO();
			int result = ReplyDAO.write(userID, reply.getBbsID(), reply.getReplyContent());

			if (result == -1) {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('댓글쓰기에 실패했습니다')");
		script.println("history.back()");
		script.println("</script>");

			} else {

		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href='view.jsp?bbsID=" + reply.getBbsID() + "'");
		script.println("</script>");
			}
		}
	}
	%>

</body>

</html>

