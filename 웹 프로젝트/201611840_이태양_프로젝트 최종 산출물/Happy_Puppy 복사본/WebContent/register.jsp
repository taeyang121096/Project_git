<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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

	<div class="site-wrapper">

		<div class="site-wrapper-inner">

			<div class="cover-container">

				<h1>회원가입</h1>
				<form action="register_check.jsp" method="post"
					onsubmit="return input_check_func()">
					
						
							<p><th>Id</th>
							<td><input id="JOIN_id" name="JOIN_id"></td>
					
							<p><th>Pw</th>
							<td><input id="JOIN_pw" name="JOIN_pw"></td>
						
							<p><th>전화번호</th>
							<td><input id="JOIN_phone" name="JOIN_phone"></td>
				
					<p><button class="btn btn-secondary">가입하기</button>
				</form>

				<script>
    // input_check_func는 회원가입에 필요한 3가지 문항을 전부다 채워 넣었는지 check 해준다
    // 이는 form onsubmit에 의해 발동되며 return 값이 false 일 경우 페이지의 데이터가 action= 좌표로 넘어가지 않게된다
    function input_check_func() {
        var id = document.getElementById('JOIN_id').value;
        var pw = document.getElementById('JOIN_pw').value;
        var hobby = document.getElementById('JOIN_phone').value;
        
        if(id == null || pw == null || hobby == null ||
         id == ""   || pw == ""   || hobby == "") {
            alert("공백은 허용치 않는다");
            return false;
        } else {
            // 모든조건이 충족되면 true를 반환한다 이는 현재 페이지의 정보를 action= 좌표로 넘긴다는것을 의미
            return true;
        }
    }    
    </script>

			</div>

		</div>

	</div>


</body>
</html>

