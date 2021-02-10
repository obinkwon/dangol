<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>맛태그_관리자화면</title>
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
		$(document).on("click","input.btn_del_TasteTag", function(){
			if (confirm("정말로 삭제하시겠습니까?")) {
				location.href="deleteTasteTag.do?anum="+$(this).siblings("input.del_TasteTag").val();			
			}
		});
		
		$(document).on("click","input.add_TasteTag", function(){
			if($("input.tasteTagText").val() == ''){
				alert("추가할 태그를 입력하세요");
			}else{
				location.href="insertTasteTag.do?keyword="+$("input.tasteTagText").val();		
			}
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
			<li class="nav"><a href="adminRecommandTag.do" class="nav">추천태그</a></li>
			<li class="nav"><a href="adminThemeTag.do" class="nav">테마별 태그</a></li>
			<li class="nav"><a href="adminFoodTag.do" class="nav">업종별 태그</a></li>
			<li class="nav_active"><a href="adminTasteTag.do" class="nav">맛별 태그</a></li>
			<li class="nav"><a href="selectAllInquirys.do" class="nav">1:1문의</a></li>
			<li class="nav"><a href="logout.do" class="nav"><button>로그아웃</button></a></li>
		</ul>
	</div>
	<div class="section">
		<div class="page_title">
			<h3>맛태그 설정</h3>
		</div>
		<table class="table">
			<tr>
				<th>테마</th>
				<th>삭제</th>
			</tr>
				<c:forEach var="tasteTag" items="${tasteTags}">
					<tr>
						<td>${tasteTag.avalue}</td>
						<td>
							<input type="button" class="btn_del_TasteTag" value="x">
							<input type="hidden" class="del_TasteTag" value="${tasteTag.anum}">
						</td>
					</tr>
				</c:forEach>
		</table>
		<hr></hr>
		<form action="insertTasteTag.do" method="get">
			<input type="text" name="keyword" class="tasteTagText" placeholder="추가할 태그를 입력하세요">
			<input type="button" value="추가하기" class="add_TasteTag">
		</form>
	</div>
</div>
</body>
</html>