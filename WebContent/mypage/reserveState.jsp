<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
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
	
	p.reserveTitle {
		position: relative;
		margin-left: 15px;
		margin-bottom: 20px;
		font-size: 24px;
		font-weight: bold;
	}
	
	div.reserveContent {
		position: relative;
		margin-left: 22%;
	}
	
	table.reserveList {
		position: relative;
		margin-top: 17px;
		width: 95%;
		height: 140px;
		border: 1px #d9d9d9;
	}
	
	table.reserveList th, td {
		text-align: center;
	}
	
	.image {
		width: 60px;
		height: 60px;
	}
	
	table.reserveList th {
		background-color: #d9d9d9;
		height: 30px;
	}
	
	table.reserveList td {
		height: 100px;
	}
	
	table.reserveList tr {
		border: 1px solid #d9d9d9;
	}
	
	.image {
		position: relative;
		margin-left: 20px;
		width: 100px;
		height: 90px;
	}
</style>
<body>


	<jsp:include page="../jsp/header.jsp" />

	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">마이페이지</a></li>
				<li class="nav"><a class="nav" href="myPage.do">회원정보</a></li>
				<li class="nav"><a class="nav" href="bookmark.do">즐겨찾기</a></li>
				<li class="nav"><a class="nav" href="historyList.do">방문내역</a></li>
				<li class="active"><a class="nav" href="reserveState.do">예약현황</a></li>
			</ul>
		</div>
		<div class="reserveContent">
			<p class="reserveTitle">(${mid})&nbsp;단골님의 예약현황</p>

			<table class="reserveList">
				<tr>
					<th width="10%">날짜</th>
					<th width="10%">예약시간</th>
					<th width="6%">등급</th>
					<th width="8%">혜택</th>
					<th colspan="2">가게</th>
					<th width="6%">인원</th>
					<th width="14%">메뉴</th>
					<th width="10%">취소</th>
					<th width="14%">요구사항</th>
				</tr>
				<c:forEach var="reservation" items="${reservationList}">
					<tr>
						<td>${reservation.ddate}</td>
						<td>${reservation.dtime}</td>
						<td><c:if test="${reservation.glevel ==0}">범골</c:if> <c:if
								test="${reservation.glevel ==1}">진골</c:if> <c:if
								test="${reservation.glevel ==2}">성골</c:if> <c:if
								test="${reservation.glevel ==3}">단골</c:if></td>
						<td><c:if test="${reservation.glevel ==0}">${reservation.sratelv0}%할인</c:if>
							<c:if test="${reservation.glevel ==1}">${reservation.sratelv1}%할인</c:if>
							<c:if test="${reservation.glevel ==2}">${reservation.sratelv2}%할인</c:if>
							<c:if test="${reservation.glevel ==3}">${reservation.sratelv3}%할인</c:if>
						</td>
						<td width="11%"><c:choose>
								<c:when test="${reservation.simage==null}">
									<img src="image_ready2.png" class="image">
								</c:when>
								<c:otherwise>
									<img src="downloadSImage.do?snum=${reservation.snum}"
										class="image">
								</c:otherwise>
							</c:choose></td>
						<td width="11%">${reservation.sname}</td>
						<td>${reservation.dperson}</td>
						<td>${reservation.dmenu}</td>
						<td><input type="button" value="취소"
							onclick="location.href='cancelReserve.do?dnum=${reservation.dnum}'"></td>
						<td>${reservation.dask}</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp" />
</body>
</html>