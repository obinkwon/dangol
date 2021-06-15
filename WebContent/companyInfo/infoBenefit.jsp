<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/image/favicon.png">
<meta charset="UTF-8">
<title>회사소개</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/template.css" />
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
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
			<div class="alert alert-info" role="alert" style="text-align : center;">
				<p><b>등급이 올라갈 수록 혜택도 UP!</b></p>
				<p><b>로그인하시면 매장별 등급과 혜택을 확인하실 수 있습니다.</b></p>
			</div>
			<div style="margin-top : 20px;text-align:center;">
				<img src="/image/gradeImg.png" class="imgInfo60">
			</div>
			<div class="alert alert-success">
				<table>
					<tr>
						<td>
							<h4>
								<span class="glyphicon glyphicon-chevron-right" aria-hidden="true" ></span>
								멤버쉽 안내
							</h4>
						</td>
						<td>
							<p>1. 멤버십은 매장별 이용횟수로 산출됩니다.</p>
							<p>2. 멤버십은 1년마다 초기화됩니다.</p>
							<p>3. 총 구매건수는 리뷰작성 기준입니다.</p>
							<p>4. 혜택은 매장 별로 다를 수 있습니다.</p>
						</td>
					</tr>
				</table>
			</div>
			<div class="alert alert-danger">
				<table>
					<tr>
						<td>
							<h4>
								<span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span>
								예약시 주의사항
							</h4>
						</td>
						<td>
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
<jsp:include page="/jsp/footer.jsp"/>
</body> 
</html>