<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방문내역</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="/css/template.css" />
<style type="text/css">

table.historyList {
	position: relative;
	margin-top: 17px;
	width: 70%;
	height: 140px;
	border: 1px solid;
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

</style>
<script type="text/javascript">
 $(document).ready(function(){
 });
 </script>
 <script type="text/javascript">
 	function historyLike(mid,snum,glike){// 즐겨찾기 변경
 		location.href='historyLike.do?mid='+mid+'&snum='+snum+'&glike='+glike;
 	}
 	
 	function historyView(snum){// 내역 상세보기
 		var mid = $('#hisMid').val();
		location.href='historyView.do?mid='+mid+'&snum='+snum;
 	}
 </script>
</head>
<body>
<jsp:include page="/jsp/header.jsp" />
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
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">(${mid})&nbsp;단골님의 방문내역</h2>
			</div>
			<input id="hisMid" type="hidden" name="mid" value="${mid}">
			<table class="table">
				<colgroup>
					<col width="*"/>
					<col width="70%"/>
					<col width="10%"/>
					<col width="*"/>
				</colgroup>
				<tbody>
				<c:forEach var="history" items="${historylist}">
					<tr>
						<td rowspan="4" style="text-align:center;">
							<a href="javascript:historyView(${history.snum});">
								<c:if test="${history.simage eq null}"><img src="/image/image_ready2.png" class="img140"></c:if>
								<c:if test="${history.simage ne null}"><img src="downloadSImage.do?snum=${history.snum}" class="img140"></c:if>
							</a>
						</td>
						<td class="storeClick" >${history.sname}</td>
						<td rowspan="4" style="text-align:center;">
							<c:if test="${history.glevel==0}">범골<br></c:if>
							<c:if test="${history.glevel==1}">진골<br></c:if>
							<c:if test="${history.glevel==2}">성골<br></c:if>
							<c:if test="${history.glevel==3}">단골<br></c:if>
			
							<c:if test="${history.glike == 1}">
								<button class="imgBtn m0" onclick="historyLike('${mid}','${history.snum}','0')">
									<img class="img50" src="mypage/likes.png">
								</button>
							</c:if>
							<c:if test="${history.glike != 1}">
								<button class="imgBtn m0" onclick="historyLike('${mid}','${history.snum}','1')">
									<img class="img50" src="mypage/dislike.png">
								</button>
							</c:if>
							<br /> 
							<a href="storeView.do?snum=${history.snum}" class="viewStore">가게상세보기</a>
						</td>
					</tr>
					<tr><td>${history.saddress} ${history.sdetailaddr}</td></tr>
					<tr><td>최근방문 ${history.ddate}</td></tr>
					<tr><td>남은리뷰&nbsp;&nbsp;${history.dcount}</td></tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp" />
</body>
