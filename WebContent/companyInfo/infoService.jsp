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
				<li class="active"><a class="nav" href="infoService.do">서비스 소개</a></li>
				<li class="nav"><a class="nav" href="infoBenefit.do">등급별 혜택</a></li>
				<li class="nav"><a class="nav" href="infoStore.do">가맹점 현황</a></li>
			</ul>
		</div>
		<div class="section">
			<div style="margin-bottom:100px;">
				<h4><b>단골의 희열 이용 방법</b></h4><br>
				<img src="/image/infoServiceList.png">
			</div>
			<div>
				<h4><b>단골의 희열 주요 서비스</b></h4><br>
				<img src="/image/infoServiceList2.png" class="imgInfoBig">
			</div>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp"/>
</body> 
</html>