<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="bbs.Bbs"%>
<%@ page import="bbs.BbsDAO"%>
<%@ page import="reply.reply"%>
<%@ page import="reply.replyDAO"%>
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

         userID = (String) session.getAttribute("customer_id");
         
      }
      String adminID=null;
      if(session.getAttribute("admin_id")!=null){
         adminID= (String) session.getAttribute("admin_id");

      }

      int bbsID = 0;

      if (request.getParameter("bbsID") != null) {

         bbsID = Integer.parseInt(request.getParameter("bbsID"));

      }

      if (bbsID == 0) {

         PrintWriter script = response.getWriter();

         script.println("<script>");

         script.println("alert('유효하지 않은 글 입니다.')");

         script.println("location.href = 'Board.jsp'");

         script.println("</script>");

      }

      Bbs bbs = new BbsDAO().getBbs(bbsID);

   %>








	<!-- 게시판 -->

	<div class="container" style="background-color: #eeeeee;">

		<div class="row">

			<table class="table table-striped"
				style="text-align: center; border: 1px solid #dddddd">

				<thead>

					<tr>

						<th colspan="3"
							style="background-color: #eeeeee; text-align: center;">글 보기
						</th>

					</tr>

				</thead>

				<tbody>

					<tr>

						<td style="width: 20%;">글 제목</td>

						<td colspan="2"><%= bbs.getBbsTitle() %></td>

					</tr>

					<tr>

						<td>작성자</td>

						<td colspan="2"><%= bbs.getUserID() %></td>

					</tr>

					<tr>

						<td>작성일</td>

						<td colspan="2"><%= bbs.getBbsDate().substring(0, 10) %></td>

					</tr>

					<tr>

						<td>내용</td>

						<td colspan="2" style="min-height: 200px; text-align: left;"><%= bbs.getBbsContent() %></td>

					</tr>


				</tbody>
			</table>

			<%if(session.getAttribute("id") != null){ %>

			<form action='replyAction.jsp' method='POST'>
				<input type="hidden" name="bbsID" value="<%=bbs.getBbsID()%>" />
				<table class="table table-striped" style="border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="3" style="background-color: #eeeeee">댓글</th>
						</tr>
					</thead>
					<tbody>
						<!-- 댓글 -->
						<%
                  replyDAO replyDAO = new replyDAO();
                  ArrayList<reply> replyList = replyDAO.getList(bbs.getBbsID());
                  for(int idx=0; idx<replyList.size(); idx++){
                  %>
						<tr>
							<td><%=replyList.get(idx).getUserID()%></td>
							<td><%=replyList.get(idx).getReplyContent()%> <input
								type='button' class='btn btn-danger'
								style="float: right; cursor: pointer"
								onclick='javascript:deleteReply("<%=replyList.get(idx).getReplyID()%>");'
								value="삭제" /></td>
							<td><%=replyList.get(idx).getReplyDate()%></td>
						</tr>
						<%
                  }
                  %>
						<!-- 댓글쓰기 기능 -->
						<tr>
							<td colspan="3"><textarea name='replyContent' id='reply'
									class='col-md-8'>댓글 내용을 작성해주세요.</textarea> <input type='light'
								value='작성' class='col-md-1 btn btn-light'></td>
						</tr>
					</tbody>
				</table>
			</form>
			<%}else{ %>

			<table class="table table-striped" style="border: 1px solid #dddddd">
				<thead>
					<tr>
						<th colspan="1" style="background-color: #eeeeee">댓글</th>
					</tr>
				</thead>
				<tbody>
					<!-- 댓글 -->
					<%
                  replyDAO replyDAO = new replyDAO();
                  ArrayList<reply> replyList = replyDAO.getList(bbs.getBbsID());
                  for(int idx=0; idx<replyList.size(); idx++){
                  %>
					<tr>
						<td><%=replyList.get(idx).getUserID()%></td>
						<td><%=replyList.get(idx).getReplyContent()%></td>
						<td><%=replyList.get(idx).getReplyDate()%></td>
					</tr>
					<%
                  }
                  %>
				</tbody>
			</table>

			<%} %>

			<%

            //글작성자 본인일시 수정 삭제 가능 

               if(userID != null && userID.equals(bbs.getUserID())){

            %>

			<a href="Update.jsp?bbsID=<%= bbsID %>" class="btn btn-primary">수정</a>

			<a onclick="return confirm('정말로 삭제하시겠습니까?')"
				href="deleteAction.jsp?bbsID=<%= bbsID %>" class="btn btn-light   ">삭제</a>





			<%               

               }

            %>

		</div>
		<a href="Board.jsp" class="btn btn-dark">목록</a>

	</div>
	<%@include file="footer.jsp" %>
	
	</body>