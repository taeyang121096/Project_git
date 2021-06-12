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
	
		<div class="site-wrapper">

			<div class="site-wrapper-inner">

				<div class="cover-container">
					<%@include file="header_admin.jsp"%>



					<h1 class="display-3">추천 사항</h1>

				</div>

				<div class="cover-container-header">
					<div class="cover-container-header">
						<form name="newRecommand" action="./processRecommand.jsp"
							class="form-horizontal" method="post"
							>
							<div class="form-group row">
								<label class="col-sm-2">추천 산책 횟수</label>
								<div class="col-sm-1">
									<input type="text" name="walk" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2">추천 목욕 횟수</label>
								<div class="col-sm-1">
									<input type="text" name="bath" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2">행동 대처 방법</label>
								<div class="col-sm-1">
									<textarea name="how" cols="50" rows="4" class="form-control"></textarea>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2">추천 야채</label>
								<div class="col-sm-1">
									<input type="text" name="veg" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<label class="col-sm-2">추천 과일</label>
								<div class="col-sm-1">
									<input type="text" name="fru" class="form-control">
								</div>
							</div>
							<div class="form-group row">
								<div class="col-sm-offset-2 col-sm-10">
									<input type="submit" class="btn btn-default"
										value="등록" >
								</div>

							</div>

						</form>
					</div>
				</div>
				<%@ include file="footer.jsp"%>
			</div>
		</div>





</body>
</html>