<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<meta charset="UTF-8">
<style type="text/css">
	div.main{
		margin-top: 50px;
		width : 100%;
	}
	div.title{
		text-align : center;
		margin-left : 38%;
		margin-bottom : 20%;
	}
 	p.Title {
 		text-align : center;
		line-height: 2em;
		font-size: 32px;
	} 
	.img{
		margin-top:30px;
		width:180px;
		height:180px;
	}
	table.user {
		float: left;
	}
	table.boss {
		float: left;
		margin-left: 10%;
	}
	.text{
		font-size: 20px;
		text-align: center;
	}
</style>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<div class="main">
		<p class="Title"><b>회원가입</b></p>
		<div class="title">
			<table class="user">
				<tr>
					<td><a href="signUpMembersForm.do"><img src="jsp/myPage.png" class="img"></a></td>
				</tr>
				<tr>
					<td class="text"><b>일반</b></td>
				</tr>
			</table>
			<table class="boss">
				<tr>
					<td><a href="signUpBossForm.do"><img src="jsp/ceo.png" class="img"></a></td>
				</tr>
				<tr>
					<td class="text"><b>가맹점주</b></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="footer.jsp"/>
</body>
</html>