<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript"></script>
<style type="text/css">
div.main {
	display: block;
	width: 100%;
	margin-top: 50px;
	margin-bottom:100px;
}

div.nav {
	margin-top: 50px;
	float: left;
	width: 10%;
	margin-left: 50px;
}

li.navTitle {
	background-color: #d9d9d9;
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

li.active {
	background-color: #66ccff;
}

p.historyTitle {
	position: relative;
	margin-left: 15px;
	margin-bottom: 20px;
	font-size: 24px;
	font-weight: bold;
}

div.historyContent {
	position: relative;
	margin-left: 22%;
}

table.historyList {
	position: relative;
	margin-top: 17px;
	width: 80%;
	height: 140px;
	border: 1px #d9d9d9;
	
}
table.historyList th,td{
text-align: center;
}
table.historyList th{
background-color: #d9d9d9;
height: 30px;
}
table.historyList td{
height: 100px;
}
table.historyList tr{
border: 1px solid #d9d9d9;
}
</style>

</head>
<body>
	<jsp:include page="../jsp/header.jsp" />
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">마이페이지</a></li>
				<li class="nav"><a class="nav" href="myPage.do">회원정보</a></li>
				<li class="nav"><a class="nav" href="bookmark.do">즐겨찾기</a></li>
				<li class="active"><a class="nav" href="historyList.do">방문내역</a></li>
				<li class="nav"><a class="nav" href="reserveState.do">예약현황</a></li>
			</ul>
		</div>
		<div class="historyContent">
			<p class="historyTitle">(${sname})&nbsp;의 방문내역</p>

			<table class="historyList">
				<tr>
					<th width="18%">날짜</th>
					<th width="10%">등급</th>
					<th width="15%">혜택</th>
					<th width="10%">인원</th>
					<th width="23%">메뉴</th>
					<th width="12%">구분</th>
					<th width="12%">후기</th>
				</tr>
				<c:forEach var="historyview" items="${historyview}">
					<tr>
						<td>${historyview.ddate}</td>
						<td>${historyview.level}</td>
						<td>${historyview.sratelv}&nbsp;%할인</td>
						<td>${historyview.dperson}</td>
						<td>${historyview.dmenu}</td>
						<td>
						<c:choose>
								<c:when test="${historyview.dtype== 'yes'}">
									예약
								</c:when>
								<c:otherwise>
								미예약
							</c:otherwise>
							</c:choose>
						</td>
						<td><c:choose>
								<c:when test="${historyview.comment == '작성'}">
									<input type="button" value="작성" onclick="location.href='createCommentForm.do?dnum=${historyview.dnum}&snum=${historyview.snum}'">
								</c:when>
								<c:otherwise>
									<input type="button" value="수정" onclick="location.href='modifyCommentForm.do?dnum=${historyview.dnum}'">
								</c:otherwise>
							</c:choose></td>

					</tr>
				</c:forEach>
			</table>

		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp" />
</body>
</html>