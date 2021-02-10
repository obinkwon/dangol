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
</style>

<script type="text/javascript">
	$(function(){
		/* 메인 추천 1 적용 */
		$('#btn_selectMain1').on("click",function(){
			location.href="selectMain1.do?type=main1&keyword="+
			$("#select_main1 option:selected").val();
			
			$('#select_main1 option:selected').prop('selected','true');
		});

		/* 메인 추천 1 적용 */
		$('#btn_selectMain2').on("click",function(){
			location.href="selectMain2.do?type=main2&keyword="+
			$("#select_main2 option:selected").val();
		});
		
	});
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
		<table class="table_selectMains">
		<!-- 추천1 부분 -->
		<c:if test="${themesCnt > 0}">
		<tr>
			<td>추천1</td>
			<td>${main1.avalue}</td>
			<td><!-- 테마태그 드롭다운 버튼 -->
				<select id="select_main1" name="main1" >
					<c:forEach var="theme" items="${themes}" varStatus="status">
						<option value="${theme.avalue}" <c:if test="${main1.avalue eq theme.avalue}"> selected</c:if>>
							${theme.avalue}
						</option>
					</c:forEach>
				</select>
			</td>
			<td><input type="button" id="btn_selectMain1" value="적용"></td>
		</tr>
		<!-- 추천2 부분 -->
		<tr>
			<td>추천2</td>
			<td>${main2.avalue}</td>
			<td>
				<!-- 테마태그 드롭다운 버튼 -->
				<select id="select_main2" name="main2" >
					<c:forEach var="theme" items="${themes}" varStatus="status">
						<option value="${theme.avalue}" <c:if test="${main2.avalue eq theme.avalue}">selected</c:if>>
							${theme.avalue}
						</option>
					</c:forEach>
					
				</select>
			</td>
			<td><input type="button" id="btn_selectMain2" value="적용"></td>
		</tr>
		</c:if>
		<c:if test="${themesCnt == 0}">
		<tr>
			<td>
				등록된 태그가 없습니다. 태그를 먼저 등록 해주세요
			</td>
		</tr>
		</c:if>
	</table>
	</div>
</div>
</body>
</html>