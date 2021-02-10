<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>회사소개</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	div.main{
		display : inline;
		width : 100%;
	}
	div.nav {
		margin-top: 50px;
		float: left;
		width: 10%;
		margin-left: 50px;
	}
	div.section{
		float : left;
		margin-left : 10%;
		margin-top : 50px;
		width : 60%;
	}
	img.infoService{
		width : 750px;
		height : 50px;
	}
	img.infoService2{
		width : 800px;
		height : 300px;
	}
	a.nav:hover,a.nav_active:hover,a.navTitle:hover{
		text-decoration : none;
		color : #404040;
		cursor: pointer;
	}
	li.navTitle {
		background-color: #d9d9d9;
	}
	li.nav:hover{
		background-color: #e6e6e6;	
	}
	li.nav_active:hover {
		background-color: #66ccff;
	}
	a.navTitle {
		font-size: 15px;
		font-weight: bold;
		color: #000000;
		text-align: center;
	}
	a.nav {
		text-align: center;
		font-size: 14px;
		color: #000000;
	}
	li.nav_active {
		background-color: #66ccff;
	}
	div.infoService,div.infoService2{
		margin-bottom : 100px;
	}
</style>
</head>
<body>
	<jsp:include page="../jsp/header.jsp"/>
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">회사소개</a></li>
				<li class="nav"><a class="nav" href="infoCompany.do">단골의 희열 소개</a></li>
				<li class="active"><a class="nav" href="infoService.do">서비스 소개</a></li>
				<li class="nav"><a class="nav" href="infoBenefit.do">등급별 혜택</a></li>
				<li class="nav"><a class="nav" href="infoStore.do">가맹점 현황</a></li>
			</ul>
		</div>
		<div class="section">
			<div class="infoService">
				<h4><b>단골의 희열 이용 방법</b></h4><br>
				<img src="infoServiceList.png" class="infoService">
			</div>
			<div class="infoService2">
				<h4><b>단골의 희열 주요 서비스</b></h4><br>
				<img src="infoServiceList2.png" class="infoService2">
			</div>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp"/>
</body> 
</html>