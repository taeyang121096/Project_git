<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dto.Puppy"%>
<%@ page import="java.util.ArrayList"%>

<%@ page import="dao.PuppyRepository"%>
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

	<div class="site-wrapper">

		<div class="site-wrapper-inner">

			<div class="cover-container">

				<%@ include file="header.jsp"%>

				<div class="inner cover">
					<%
						PuppyRepository dao = PuppyRepository.getInstance();
					ArrayList<Puppy> listOfPuppies = dao.getAllPuppies();
					%>
					<%
						Puppy puppy = listOfPuppies.get(0);
					%>
					<img src="./resources/images/<%=puppy.getFilename()%>"
						style="width: 50%">
					<h1 class="cover-heading">Happy Puppy에 관하여</h1>
					<p class="lead"><h3>저희는 여러분의 반려동물을 위한 건강 및 행동에 대한 이해를 위한 정보를 제공하는
						것에 중점을 두고 있습니다. 또한 반려동물의 건강을 위한 전문가들이 상시 대기하고 있습니다, 궁금한점이 있다면 언제나
						질문해주세요!! 저희와 함께하는 반려동물을 위해 최선을 다하겠습니다!!
					</h3>
					</p>
					<h1 class="cover-heading">전문가 & 개발자</h1>
					<div class="container">
						<div class="row" align="center">

							<div class="col-md-4">
								<h3>
									<p>이름 : sun</p>
								</h3>
								<h3>
									<p>직무 : 개발자</p>
								</h3>
								
									<p>이메일 : taeyang121096@naver.com</p>
							
							</div>
							<div class="col-md-4">
								<h3>
									<p>이름 : taeyang</p>
								</h3>
								<h3>
									<p>직무 : 수의사</p>
								</h3>
								
									<p>이메일 : taeyang121096@naver.com</p>
								
							</div>
						</div>
					</div>
					

				</div>



				<%@ include file="footer.jsp"%>

			</div>

		</div>

	</div>


</body>
</html>

