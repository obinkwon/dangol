<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>즐겨찾기</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript"></script>
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

p.page-header {
	position: relative;
	margin-left: 15px;
	margin-bottom: 20px;
	font-size: 24px;
	font-weight: bold;
}

div.bookmarkContent {
	position: relative;
	margin-left: 22%;
}

table.bookmarkList {
	position: relative;
	margin-top: 17px;
	width: 70%;
	height: 140px;
	border: 1px solid;
}

p.sname {
	font-weight: bold;
}

table td {
	padding: 5px;
}

.right {
	text-align: center;
	color: #ff0000;
	font-size: 15px;
	font-weight: bold;
}

a.viewStore {
	margin-top: 10px;
	color: #666666;
	text-decoration: underline;
	font-weight: bold;
	font-size: 12px;
}

img.likes {
	width: 50px;
	height: 50px;
}

.likesBtn {
	width: 50px;
	height: 50px;
	border: 0px;
	background-color: white;
	outline: 0;
}

a.dcount {
	color: green;
	text-decoration: none;
	pointer-events: none;
	cursor: default;
}

.image {
	position: relative;
	margin-left: 20px;
	width: 140px;
	height: 120px;
}
.storeClick{
	cursor:pointer;
}
</style>
<script type="text/javascript">
 $(document).ready(function(){
	 $(".storeClick").click(function(){	 
		var snum= $(this).closest("tr").find("td:eq(0)").find("input").val();
		 location.href="historyView.do?mid=${mid}&snum="+snum;

	 }) 
	 
	
 })
 </script>
 </head>
<body>
	<jsp:include page="../jsp/header.jsp" />
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">마이페이지</a></li>
				<li class="nav"><a class="nav" href="myPage.do">회원정보</a></li>
				<li class="active"><a class="nav" href="bookmark.do">즐겨찾기</a></li>
				<li class="nav"><a class="nav" href="historyList.do">방문내역</a></li>
				<li class="nav"><a class="nav" href="reserveState.do">예약현황</a></li>
			</ul>
		</div>
		<div class="bookmarkContent">
			<p class="page-header">(${mid})&nbsp;단골님의 단골집</p>
			<c:forEach var="bookmark" items="${bookmarkList}">
				<table class="bookmarkList">
					<tr>
						<td rowspan="4" width=30%><input type="hidden"
							value="${bookmark.snum}"> <c:choose>
								<c:when test="${bookmark.simage==null}">
									<img src="image_ready2.png" class="image">
								</c:when>
								<c:otherwise>
									<img src="downloadSImage.do?snum=${bookmark.snum}" class="image">
								</c:otherwise>
							</c:choose></td>
						<td class="storeClick" width=50%><p class="sname">${bookmark.sname}</p></td>
						<td rowspan="4" width=20% class="right">
						
						<c:if test="${bookmark.glevel==0}">범골<br></c:if>
						<c:if test="${bookmark.glevel==1}">진골<br></c:if>
						<c:if test="${bookmark.glevel==2}">성골<br></c:if>
						<c:if test="${bookmark.glevel==3}">단골<br></c:if>
						
							<button class="likesBtn"
								onclick="location.href='bookmarkLikes.do?mid=${mid}&snum=${bookmark.snum}&glike=0'">
								<img class="likes" src="mypage/likes.png">
							</button> <br> <a href="storeView.do?snum=${bookmark.snum}"
							class="viewStore">가게상세보기</a>
						</td>
					</tr>
					<tr>
						<td>${bookmark.saddress}</td>
					</tr>
					<tr>
						<td>최근방문 &nbsp;&nbsp;${bookmark.ddate}</td>
					</tr>
					<tr>
						<td>남은리뷰 &nbsp;&nbsp;<a class="dcount">${bookmark.dcount}</a></td>
					</tr>
				</table>
			</c:forEach>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp" />
</body>
</html>