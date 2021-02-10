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
		width : 50%;
	}
	div.alert-info{
		text-align : center;
	}
	div.infoBenefit{
		text-align : center;
	}
	div.infoBenefit2{
		border : 1px solid #cccccc;
		margin-top : 50px;
		margin-bottom : 50px;
		height : 100PX;
		color : #000000;
		border-radius: 4px;
	}
	img.infoBenefit{
		margin-top : 20px;
		width : 600px;
		height : 500px;
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
	td.infoBenefit{
		padding-left : 20px;
		padding-right : 19px;
	}
	table.infoBenefit{
		height : 100PX; 
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
				<li class="nav"><a class="nav" href="infoService.do">서비스 소개</a></li>
				<li class="active"><a class="nav" href="infoBenefit.do">등급별 혜택</a></li>
				<li class="nav"><a class="nav" href="infoStore.do">가맹점 현황</a></li>
			</ul>
		</div>
		<div class="section">
			<div class="alert alert-info" role="alert">
				<p><b>등급이 올라갈 수록 혜택도 UP!</b></p>
				<p><b>로그인하시면 매장별 등급과 혜택을 확인하실 수 있습니다.</b></p>
			</div>
			<div class="infoBenefit">
				<img src="gradeImg.png" class="infoBenefit">
			</div>
			<div class="infoBenefit2">
				<table class="infoBenefit">
					<tr>
						<td class="infoBenefit" colspan="2" rowspan="2"><h3>멤버쉽 안내</h3></td>
						<td class="infoBenefit">1. 멤버십은 매장별 이용횟수로 산출됩니다.</td>
						<td class="infoBenefit">2. 멤버십은 1년마다 초기화됩니다.</td>
					</tr>
					<tr>
						<td class="infoBenefit">3. 총 구매건수는 리뷰작성 기준입니다.</td>
						<td class="infoBenefit">4. 혜택은 매장 별로 다를 수 있습니다.</td>
					</tr>
				</table>
			</div>
			<div class="alert alert-danger">
				<table>
					<tr>
						<td class="infoBenefit">
							<h4>
								<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
								예약시 주의사항
							</h4>
						</td>
						<td class="infoBenefit">
							<p>당일 예약취소시  패널티</p>
							<p>예약후 노쇼시  패널티</p>
							<p>1달 기준 3회 패널티시 전체 가게 등급 강등</p>
							<p>(1달 후 초기화)</p>
						</td>
					</tr>
				</table>
			</div>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp"/>
</body> 
</html>