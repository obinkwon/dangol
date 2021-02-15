<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>추천태그_관리자화면</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	div.notice{
		border : 1px solid #000000;
		padding : 10px;
		padding-left : 100px;
	}
	div.main{
		display : inline;
		width : 100%;
	}
	div.nav{
		margin-top: 50px;
		float: left;
		width: 13%;
		margin-left: 50px;
	}
	div.section{
		margin-top : 50px;
		float : right;
		width : 60%;
		margin-right : 200px;
	}
	li.nav_active {
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
	.w300 {
	    width: 300px;
	}
	.btn-view {
	    width: 200px;
	    font-size: 1.4rem;
	    background-color: #fff;
	    color: #000000;
	    height: 4rem;
	    line-height: 3.9rem;
	    font-weight: 600;
	    letter-spacing: 0.5px;
	    transition-duration: .5s;
	    border: 0.1rem solid #66ccff;
	}
</style>

<script type="text/javascript">
	function applyTag(type){ // 태그 적용
		if(type == 1){ //main1
			location.href="selectMain.do?atype=main1&avalue="+$('#select_main1').val();
		}else{ //main2
			location.href="selectMain.do?atype=main2&avalue="+$('#select_main2').val();
		}
	}
</script>
</head>
<body>
<div class="notice">
	<h1>관리자 페이지입니다.</h1>
</div>
<div class="main">
	<!-- 사장님 네비게이션 -->
	<div class="nav">
		<ul class="nav nav-pills nav-stacked">
			<li class="navTitle"><a class="navTitle">화면이동</a></li>
			<li class="nav_active"><a href="adminRecommandTag.do" class="nav">추천태그</a></li>
			<li class="nav"><a href="adminThemeTag.do" class="nav">테마별 태그</a></li>
			<li class="nav"><a href="adminFoodTag.do" class="nav">업종별 태그</a></li>
			<li class="nav"><a href="adminTasteTag.do" class="nav">맛별 태그</a></li>
			<li class="nav"><a href="selectAllInquirys.do" class="nav">1:1문의</a></li>
			<li class="nav"><a href="logout.do" class="nav"><button>로그아웃</button></a></li>
		</ul>
	</div>
	<div class="section">
		<div class="page_title">
			<h3>추천태그 설정</h3>
		</div>
		<table class="table">
		<!-- 추천1 부분 -->
		<c:if test="${themesCnt > 0}">
		<tr>
			<td>추천1</td>
			<td>${main1.avalue}</td>
			<td><!-- 테마태그 드롭다운 버튼 -->
				<select id="select_main1" class="inputText w300" name="main1" >
					<c:forEach var="theme" items="${themes}" varStatus="status">
						<option value="${theme.avalue}" <c:if test="${main1.avalue eq theme.avalue}"> selected</c:if>>${theme.avalue}</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<button class="btn-view" type="button" onclick="applyTag(1); return false;">적용하기</button>
			</td>
		</tr>
		<!-- 추천2 부분 -->
		<tr>
			<td>추천2</td>
			<td>${main2.avalue}</td>
			<td>
				<!-- 테마태그 드롭다운 버튼 -->
				<select id="select_main2"  class="inputText w300" name="main2" >
					<c:forEach var="theme" items="${themes}" varStatus="status">
						<option value="${theme.avalue}" <c:if test="${main2.avalue eq theme.avalue}">selected</c:if>>${theme.avalue}</option>
					</c:forEach>
				</select>
			</td>
			<td>
				<button class="btn-view" type="button" onclick="applyTag(2); return false;">적용하기</button>
			</td>
		</tr>
		</c:if>
		<c:if test="${themesCnt == 0}">
		<tr>
			<td>등록된 태그가 없습니다. 태그를 먼저 등록 해주세요</td>
		</tr>
		</c:if>
	</table>
	</div>
</div>
</body>
</html>