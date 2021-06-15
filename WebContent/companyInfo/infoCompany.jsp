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
			<li class="active"><a class="nav" href="infoCompany.do">단골의 희열 소개</a></li>
			<li class="nav"><a class="nav" href="infoService.do">서비스 소개</a></li>
			<li class="nav"><a class="nav" href="infoBenefit.do">등급별 혜택</a></li>
			<li class="nav"><a class="nav" href="infoStore.do">가맹점 현황</a></li>
		</ul>
	</div>
	<div class="section">
		<pre>
		<a class="emphasis">단골</a>의 가치를 알고 계신가요?, 1명의 단골은 20명의 신규고객과도 같습니다. 
		더불어 1명의 단골이 7년간 창출하는 부가가치는 연간 600만 원에 해당합니다. 
		물론 기존에도 쿠폰 등 단골 확보를 위한 노력은 있었습니다.
		하지만 단골의 중요성을 인식하지 못해, 쿠폰 고객에게는 불친절하게 응대하거나 
		정량보다 적은 양을 제공하는 등 문제점도 존재했습니다. 
	
		O2O를 넘어 O4O 시대의 지금,
		인터넷의 발달로 온라인 정보의 파급력이 날로 커지고 있습니다.	 
		한 개의 리뷰가 가게를 고르는 기준이 되고, 
		사장님의 재치있는 댓글 하나가 온라인 상에서 화제가 되어 효과적인 마케팅수단이 되기도 합니다.
			
		그래서 우리는,
		<a class="emphasis">하나</a>, 단골손님에 대한 인식을 재정의하여, 단골고객 관리를 통한 자영업 사장님의 영업을 조력하고자 합니다.
		<a class="emphasis">둘</a>, 자영업 사장님과 손님이 쉽고 편하게 소통할 수 있는 플랫폼을 제공하고자 합니다.
		<a class="emphasis">셋</a>, 멤버십 등급 별 리뷰 및 별점 평가를 통해 세분화되고, 객관적인 리뷰를 제공하고자 합니다.
		</pre>
		<div>
			<img src="/image/companyInfo1.png" class="imgInfo">
			<img src="/image/companyInfo2.png" class="imgInfo">
			<img src="/image/companyInfo3.png" class="imgInfo">
		</div>
	</div>
	</div>
	<jsp:include page="/jsp/footer.jsp"/>
</body> 
</html>