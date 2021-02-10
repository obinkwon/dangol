<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>추천별</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">
	div.main{
		margin : auto;
		display : block;
		width : 100%;
		padding-top : 50px;
	}
	div.recommendSortTop {
		margin: auto;
		width: 660px;
	}
	div.recommendSortBottom {
		margin-top : 20px;
		text-align: center;
		margin-left: 150px;
	}
	div.recommendSortTag {
		display: inline-block;
		margin-top: 30px;
	}
	div.storeList {
		display: inline-block;
		width: 100%;
		margin: auto;
	}
	div.storeOne {
		width: 300px;
		height: 400px;
		margin-right: 50px;
		margin-bottom: 50px;
		display: block;
		float: left;
		border: 1px solid #d9d9d9;
		border-bottom: 2px solid #d9d9d9;
	}
	div.storeOne:hover {
		border: 2px solid #66ccff;
		cursor: pointer;
	}
	select.sortSelect {
		float: right;
		margin-right: 200px;
		margin-bottom: 60px;
		width: 80px;
		height: 30px;
	}
	p.recommendSortTop {
		width: 100%;
		text-align: center;
		font-size: 30px;
		font-weight: bold;
		font-family: '맑은 고딕';
	}
	p.recommendSortTag {
		width: 100%;
		text-align: center;
		font-size: 25px;
		font-family: '맑은 고딕';
		margin-bottom : 40px;
	}
	p.recommendTxt {
		width: 100%;
		text-align: center;
		font-size: 13px;
		font-family: '맑은 고딕';
	}
	img.storeOne {
		margin-top: 15px;
		width: 250px;
		height: 200px;
	}
	a.storeOne {
		margin-left: 15px;
		font-size: 15px;
		color: #ff4d4d;
	}
	a.storeOneA {
		margin-left: 15px;
		margin-top: 10px;
		font-size: 15px;
		color: #ff4d4d;
	}
	a.storeOneB {
		margin-left: 15px;
		margin-top: 10px;
		font-size: 15px;
		color: #00cc00;
	}
	a.recommendSortTag {
		font-size: 13px;
		color: #999999;
		display : none;
	}
	
	p.storeOneA {
		margin-top: 10px;
		font-size: 20px;
	}
	
	p.storeOneB {
		margin-top: 10px;
		font-size: 15px;
	}
	
	p.hashTag {
		margin-top: 10px;
		font-size: 15px;
	}
	
	a.storeOneA:hover {
		text-decoration: none;
		font-size: 20px;
		color: #ff4d4d;
		font-weight: bold;
	}
	
	a.storeOneB:hover {
		text-decoration: none;
		font-size: 20px;
		color: #00cc00;
		font-weight: bold;
	}
	a.recommendTag{
		margin-right : 20px;
		font-size : 20px;
		text-decoration: none;
	}
	a.recommendTag:hover{
		text-decoration: none;
	}
	
	span.glyphicon-star, span.glyphicon-user {
		margin-top: 15px;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		for(var i=0;i<3;i++){
			var rColor = "#"+(parseInt(Math.random()*0xffff)).toString(16)+"00";
			$('a.recommendTag:eq('+i+')').css({'color':rColor});
		}
		$('span#question').hover(function(){
			$('a#tooltip').css({'display' : 'inline'});
		},function(){
			$('a#tooltip').css({'display' : 'none'});
		});
		$('div.storeOne').click(function(){
			var snum = $(this).find('input[type=hidden]#storeNum').val();
			location.href="storeView.do?snum="+snum;
		});
	});
</script>
</head>
<body>
	<jsp:include page="../jsp/header.jsp" />
	<div class="main">
		<div class="recommendSortTop">
			<p class="recommendSortTop">추천별</p>
			<div class="recommendSortTag">
				<p class="recommendSortTag">
					<b style="text-decoration : underline;">${mid}</b>님을 위한 추천
					<span class="glyphicon glyphicon-question-sign" id="question"></span>
					<a id="tooltip" class="recommendSortTag">선호지역과 해시태그를 바탕으로 검색한 추천리스트입니다.</a>
				</p>
				<c:forEach var="admin" items="${mtagList}">
					<a class="recommendTag">
						#${admin.avalue}
					</a>
				</c:forEach>
			</div>
		</div>
		<div class="recommendSortBottom">
			<div class="storeList">
				<c:forEach var="storeMap" items="${storeMapList}">
					<div class="storeOne">
						<input id="storeNum" type="hidden" value="${storeMap.snum}">
						<c:choose>
							<c:when test="${storeMap.simage != null}">
								<img class="storeOne" src="downloadStoreImg.do?snum=${storeMap.snum}">
							</c:when>
							<c:otherwise>
								<img class="storeOne" src="image_ready2.png">
							</c:otherwise>
						</c:choose>
						<p class="storeOneA">
							<b>${storeMap.sname}</b>
						</p>
						<p class="storeOneB">${storeMap.saddress}</p>
						<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
						<a class="storeOneA">${storeMap.commentCount}점</a><br> <span
							class="glyphicon glyphicon-user" aria-hidden="true"></span> <a
							class="storeOneB">${storeMap.userCount}명</a>
						<p class="hashTag">
							<c:if test="${storeMap.stag1!=null}">
								<a>#${storeMap.stag1}</a>
							</c:if>
							<c:if test="${storeMap.stag2!=null}">
								<a>#${storeMap.stag2}</a>
							</c:if>
							<c:if test="${storeMap.stag3!=null}">
								<a>#${storeMap.stag3}</a>
							</c:if>
						</p>
					</div>
				</c:forEach>
			</div>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp" />
</body>
</html>