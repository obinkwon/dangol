<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>로그인</title>
<style type="text/css">
	div.main {
		margin : auto;
		margin-top: 50px;
		margin-bottom:100px;
		width: 100%;
	}
	table.signForm {	
		margin : auto;		
		font-size: 15px;
	}
	table.signForm td {
		padding : 10px;
		height: 30px;
	}
	.inputText {
		height: 40px;
	    line-height: 40px;
	    color: #7b6e66;
	    padding: 0 7px;
	    border: 1px solid #7b6e66;
	    background-color: transparent;
	    vertical-align: middle;
	    float: left;
	}
	.btn-view {
	    width: 200px;
        font-size: 1.4rem;
        background-color: #fff;
		color: #000000;
	    height: 4rem;
	    margin: 0 auto;
	    line-height: 3.9rem;
		font-weight: 600;
	    letter-spacing: 0.5px;
	    transition-duration: .5s;
        border: 0.1rem solid #66ccff;
	}
	.btn-mint{
		background-color: #66ccff;
		color: #fff;
	}
	.contentsTitGroup{
		padding-top: 2.0rem;
	    text-align: center;
	    display: block;
	}
	.w300{
		width: 300px;
	}
	.inputRadio{
	    margin: 0;
	    width: 15px;
	    height: 15px;
	    border: 0;
	    margin-right: 20px;
	}
	.tcenter{
		text-align: center;
	}
</style>
<script type="text/javascript">
	function login(){ //로그인
		$('#login').submit();
	}
</script>
</head>
<body>
<jsp:include page="header.jsp"/>
	<div class="main">
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">로그인</h2>
			</div>
			<form action="login.do" id="login">
				<table class="signForm">
					<colgroup>
						<col width="50%">
						<col width="50%">
					</colgroup>
					<tbody>
						<tr>
							<td>
								<input class="inputRadio" type="radio" name="loginUser" id="loginUser-u" value="user" checked>
								<label for="loginUser-u">사용자</label>
							</td>
							<td>
								<input class="inputRadio" type="radio" name="loginUser" id="loginUser-b" value="boss">
								<label for="loginUser-b">사장님</label>
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input class="inputText w300 tcenter" type="text" name="id" placeholder="아이디">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input class="inputText w300 tcenter" type="password" name="pwd" placeholder="비밀번호">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="button" class="btn-view btn-mint w300" onclick="login()">로그인</button>
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
					</tbody>
				</table>
			</form>
		</div>
	</div>
<jsp:include page="footer.jsp"/>
</body>
</html>