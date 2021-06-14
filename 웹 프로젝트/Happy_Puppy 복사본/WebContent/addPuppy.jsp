<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
	<fmt:setLocale value='<%=request.getParameter("language")%>' />
	<fmt:bundle basename="bundle.message">
		<div class="site-wrapper">

			<div class="site-wrapper-inner">

				<div class="cover-container">
					<%@include file="header_user.jsp"%>


					<h1 class="display-3">
						<fmt:message key="title" />
					</h1>

				</div>
				<div class="container">
					<div class="text-right">
						<a href="?language=ko">Korean</a>|<a href="?language=en">English</a>
					</div>
				</div>


				<div class="cover-container-header">
					<div class="cover-container-header">
						<form name="newPuppy" action="./processAddPuppy.jsp"
							class="form-horizontal" method="post"
							enctype="multipart/form-data">
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="Id"/></label>
								<div class="col-sm-1">
									<input type="text" name="Id" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="name"/></label>
								<div class="col-sm-1">
									<input type="text" name="name" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="age"/></label>
								<div class="col-sm-1">
									<input type="text" name="age" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="sex"/></label>
								<div class="col-sm-1">
									<input type="text" name="sex" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="birth"/></label>
								<div class="col-sm-1">
									<input type="text" name="birth" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="weight"/></label>
								<div class="col-sm-1">
									<input type="text" name="weight" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="walk_time"/></label>
								<div class="col-sm-1">
									<input type="text" name="walk_time" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="bath"/></label>
								<div class="col-sm-1">
									<input type="text" name="bath" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="sleep"/></label>
								<div class="col-sm-1">
									<input type="text" name="sleep" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="feed"/></label>
								<div class="col-sm-1">
									<input type="text" name="feed" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="allergy"/></label>
								<div class="col-sm-2">
									<input type="text" name="allergy" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="heart_rate"/></label>
								<div class="col-sm-1">
									<input type="text" name="heart_rate" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2"><fmt:message key="image"/></label>
								<div class="col-sm-3">
									<input type="file" name="puppyImage" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-10">
									<input type="submit" class="btn btn-default" value="<fmt:message key="button"/>">
								</div>

							</div>
						</form>
					</div>
				</div>
				<%@ include file="footer.jsp"%>
			</div>
		</div>
	</fmt:bundle>




</body>
</html>