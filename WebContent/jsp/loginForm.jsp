<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.loginTitle {
	text-align : center;
	margin-top: 30px; 
	font-size : 25px;
	line-height: 2em;
}

#center {
	margin-top: 30px;
}

.loginBtn {
	position: relative;
	margin-top: 15px;
	background-color: #66ccff;
	border: none;
	color: white;
	width: 365px;
	height: 50px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 18px;
	cursor: pointer;
}

.input-icons i {
	position: absolute;
}

.input-icons {
	margin-top: 10px;
	width: 365px;
	height: 45px;
}

.icon {
	padding: 10px;
	color: grey;
	min-width: 30px;
	text-align: center;
}

.inputField {
	width: 365px;
	height: 45px;
	padding: 10px;
	text-align: center;
	font-size: 15px;
}

.findId {
	margin-top: 10px; 
	margin-left : 50px;
	font-size : 15px;
	text-decoration: underline;
	color: black;
	line-height: 6em;
	font-size: 15px;
}
div.main{
	height : 500px;
}
</style>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<br>
	<div class="main">
	<p class="loginTitle">로그인</p>
	<form action="login.do" id="center">
		<table align="center">
			<tr>
				<td>
					<input type="radio" name="loginUser" value="user" checked="checked">사용자
				</td>
				<td>
					<input type="radio" name="loginUser" value="boss">사장님
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<div class="input-icons">
						<i class="fa fa-user icon"></i> 
						<input class="inputField" type="text" name="id" placeholder="아이디">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div class="input-icons">
						<i class="fa fa-key icon"></i> 
						<input class="inputField" type="password" name="pwd" placeholder="비밀번호">
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<input type="submit" value="로그인" class="loginBtn">
				</td>
			</tr>
			<tr>
				<td>
					<a class="findId" href="findIdPwForm.do">ID/PW찾기</a>
				</td>
				<td>
					<a class="findId" href="signUpForm.do">회원가입</a>
				</td>
			</tr>

		</table>
	</form>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>