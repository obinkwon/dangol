<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>단골의 희열</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	div.main{
		width : 100%;
		display : block;
		clear: both; 
	}
	div.bannerText{
		float : left;
		width : 25%;
		padding : 0px;
	}
	img.left{
		float : left;
		margin-left : 30px;
		width : 80px;
		height : 80px;
		cursor: pointer;
		margin-top : 180px;
	}
	img.right{
		float : right;
		width : 80px;
		height : 80px;
		cursor: pointer;
		margin-top : 180px;
	}
	div#banner{
		padding-bottom : 0px;
		height : 450px;
		background-color: #d9d9d9;
		background-repeat: no-repeat;
		background-position : center;
		background-size: 100% 450px; 
	}
	div#banner_bot{
		margin-top : 0px;
		padding-top : 0px;
		display : inline;
		width : 100%;
	}
	div#row{
		width : 100%;
		height : 450px;
	}
	div.bottomDiv{
		margin-top : 150px;
		border-left : 1px solid #d9d9d9;
		border-right : 2px solid #d9d9d9;
		border-bottom : 2px solid #d9d9d9;
	}
	div.mainBottom{
		width : 85%;
		margin :auto;
		margin-bottom : 30px;
	}
	p#banner{
		text-align : center;
		padding-top : 15px;
		height : 50px;
		margin : 0px;
		font-size : 15px;
	}
	p.bottomDiv{
		font-size : 20px;
		font-weight : bold;
		margin-left : 20px;
	}
	img#left:hover, img#right:hover{
		background-color: rgb(140, 140, 140,0.4);
	}
	/* 중복 */
	div.storeList{
		display : inline-block;
		width : 100%;
		margin : auto;
		text-align : center;
	}
	div.storeOne{
		width : 300px;
		height : 400px;
		margin-top : 30px;
		margin-left : 20px;
		margin-right : 30px;
		margin-bottom : 50px;
		display : block;
		float : left;
		border : 1px solid #d9d9d9;
		border-bottom : 2px solid #d9d9d9;
	}
	div.storeOne:hover{
		border : 2px solid #66ccff;
		cursor: pointer;
	}
	select.sortSelect{
		float : right;
		margin-right : 200px;
		margin-bottom : 60px;
		width : 80px;
		height : 30px;
	}
	img.storeOne{
		margin-top : 15px;
		width : 250px;
		height : 200px;
	}
	a.storeOne{
		margin-left : 15px;
		font-size : 15px;
		color : #ff4d4d;
	}
	a.storeOneA{
		margin-left : 15px;
		margin-top : 10px;
		font-size : 15px;
		color : #ff4d4d;
	}
	a.storeOneB{
		margin-left : 15px;
		margin-top : 10px;
		font-size : 15px;
		color : #00cc00;
	}
	p.storeOneA{
		margin-top : 10px;
		font-size : 20px;
	}
	p.storeOneB{
		margin-top : 10px;
		font-size : 15px;
	}
	p.hashTag{
		margin-top : 10px;
		font-size : 15px;
	}
	a.storeOneA:hover{
		text-decoration : none;
		font-size : 20px;
		color : #ff4d4d;
		font-weight : bold;
	}
	a.storeOneB:hover{
		text-decoration : none;
		font-size : 20px;
		color : #00cc00;
		font-weight : bold;
	}
	span.glyphicon-star,span.glyphicon-user{
		margin-top : 15px;
	}
	input.btn {
		float : right;
		margin-right : 20px;
	}
</style>
<script type="text/javascript">
	/* $(document).ready(function(){
		$('p#banner').mousemove(function(){
			var text = $(this).text();
			$('p#banner').attr('class','bg-danger');
			$('p#banner').css({'color':'#000000'});
			if(text == '단골수 매장'){
				$('div#banner').css({'background-image': 'url(downloadStoreImg.do?snum=1)'});
			}else if(text == '이달의 매장'){
				$('div#banner').css({'background-image': 'url(downloadStoreImg.do?snum=1)'});
			}else if(text == '올해의 매장'){
				$('div#banner').css({'background-image': 'url(downloadStoreImg.do?snum=1)'});
			}else if(text == '이벤트/행사'){
				$('div#banner').css({'background-image': 'url(download.do?eid=${eventBanner})'});
			}
			$(this).css({'color':'red'});
			$(this).attr('class','bg-active');
		});
		$('p#banner').mouseout(function(){
			$(this).css({'color':'red'});
		});
		setInterval(function() {
			$('img#right').trigger('click');
			}, 3000);
		$('img#left').click(function(){
			var loc = $('p#banner').index($('p.bg-active'));//현재위치
			var prev = loc-1;
			$('p.bg-active').parent().siblings('div:eq('+prev+')').children('p').trigger('mousemove');
		});
		$('img#right').click(function(){
			var loc = $('p#banner').index($('p.bg-active'));
			if(loc==3){
				$('p.bg-active').parent().siblings('div:eq(0)').children('p').trigger('mousemove');	
			}else{
				$('p.bg-active').parent().next().children('p').trigger('mousemove');	
			}
		});
		$('div#banner_bot').children('div:eq(0)').children('p').trigger('mousemove');
		
		$('input#themeView').click(function(){
			location.href="themeSort.do?anum="+$(this).siblings('input').val();
		});
		
		$('input#newStoreView').click(function(){
			location.href="newStoreAll.do";
		});
		$('div.storeOne').click(function(){
			var snum = $(this).find('input[type=hidden]#storeNum').val();
			location.href="storeView.do?snum="+snum;
		});
		$('#insertStore').click(function(){
			location.href="insertNewStoreDB.do"			
		});
		$('#insertStoreMenu').click(function(){
			location.href="insertStoreMenu.do"			
		});
	}); */
</script>
</head>
<body>
	<jsp:include page="header.jsp"/>
	<div class="main">
		<div id="banner">
			<div class="row" id="row">
				<img class="left" src="left.png" id="left">
				<img class="right" src="right.png" id="right">
			</div>
		</div>
		<div id="banner_bot">
			<div class="bannerText"><p id="banner" class="bg-danger">단골수 매장</p></div>
			<div class="bannerText"><p id="banner" class="bg-danger">이달의 매장</p></div>
			<div class="bannerText"><p id="banner" class="bg-danger">올해의 매장</p></div>
			<div class="bannerText"><p id="banner" class="bg-danger">이벤트/행사</p></div>
		</div>
		<div class="mainBottom">
			<div class="bottomDiv">
				<p class="bottomDiv">새로운 가게들을 소개합니다</p>
				<div class="sortSelect">
					<input id="newStoreView" type="button" class="btn btn-default" value="전체보기">
				</div>
				<div class="storeList">
					<c:forEach var="storeMap" items="${storeNewList}" end="2">
					<div class="storeOne">
						<input id="storeNum" type="hidden" value="${storeMap.snum}">
						<img class="storeOne" src="${storeMap.simage}">
						<p class="storeOneA">
							<img src="new.png" style="width : 30px; heoght : 30px;">
							<b>${storeMap.sname}</b>
						</p>
						<p class="storeOneB">${storeMap.saddress}</p>
						<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
						<a class="storeOneA">${storeMap.commentCount}점</a><br>
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						<a class="storeOneB">${storeMap.userCount}명</a>
						<p class="hashTag">
							<c:if test="${storeMap.stag1!=null}"><a>#${storeMap.stag1}</a></c:if>
							<c:if test="${storeMap.stag2!=null}"><a>#${storeMap.stag2}</a></c:if>
							<c:if test="${storeMap.stag3!=null}"><a>#${storeMap.stag3}</a></c:if>
						</p>
					</div>
					</c:forEach>
				</div>
			</div>
			<div class="bottomDiv">
				<p class="bottomDiv">#${maintag1}</p>
				<div class="sortSelect">
					<input type="hidden" value="${mainnum1}">
					<input id="themeView" type="button" class="btn btn-default" value="전체보기">
				</div>
				<div class="storeList">
					<c:forEach var="storeMap" items="${storeThemeList1}" end="2">
					<div class="storeOne">
						<input id="storeNum" type="hidden" value="${storeMap.snum}">
						<img class="storeOne" src="${storeMap.simage}">
						<p class="storeOneA">
							<img src="new.png" style="width : 30px; heoght : 30px;">
							<b>${storeMap.sname}</b>
						</p>
						<p class="storeOneB">${storeMap.saddress}</p>
						<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
						<a class="storeOneA">${storeMap.commentCount}점</a><br>
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						<a class="storeOneB">${storeMap.userCount}명</a>
						<p class="hashTag">
							<c:if test="${storeMap.stag1!=null}"><a>#${storeMap.stag1}</a></c:if>
							<c:if test="${storeMap.stag2!=null}"><a>#${storeMap.stag2}</a></c:if>
							<c:if test="${storeMap.stag3!=null}"><a>#${storeMap.stag3}</a></c:if>
						</p>
					</div>
					</c:forEach>
				</div>
			</div>
			<div class="bottomDiv">
				<p class="bottomDiv">#${maintag2}</p>
				<div class="sortSelect">
					<input type="hidden" value="${mainnum2}">
					<input id="themeView" type="button" class="btn btn-default" value="전체보기">
				</div>
				<div class="storeList">
					<c:forEach var="storeMap" items="${storeThemeList2}" end="2">
					<div class="storeOne">
						<input id="storeNum" type="hidden" value="${storeMap.snum}">
						<img class="storeOne" src="${storeMap.simage}">
						<p class="storeOneA">
							<img src="new.png" style="width : 30px; heoght : 30px;">
							<b>${storeMap.sname}</b>
						</p>
						<p class="storeOneB">${storeMap.saddress}</p>
						<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
						<a class="storeOneA">${storeMap.commentCount}점</a><br>
						<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
						<a class="storeOneB">${storeMap.userCount}명</a>
						<p class="hashTag">
							<c:if test="${storeMap.stag1!=null}"><a>#${storeMap.stag1}</a></c:if>
							<c:if test="${storeMap.stag2!=null}"><a>#${storeMap.stag2}</a></c:if>
							<c:if test="${storeMap.stag3!=null}"><a>#${storeMap.stag3}</a></c:if>
						</p>
					</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</div>
	<!-- <input id="insertStore" type="button" value="가게 등록">
	<input id="insertStoreMenu" type="button" value="가게 메뉴 등록"> -->
	<jsp:include page="footer.jsp"/>
</body> 
</html>