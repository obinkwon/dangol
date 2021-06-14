<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방문내역</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="/css/template.css" />
 <script type="text/javascript">
 	function commentWrite(dnum){// 리뷰 작성하기
 		alert(dnum + ' 리뷰 작성 완료');
 	}
 	function storeView(snum){// 상세보기
		location.href='storeView.do?snum='+snum;
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
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">방문내역</h2>
			</div>
			<input id="hisMid" type="hidden" name="mid" value="${mid}">
			<div class="historyList">
			<c:forEach var="history" items="${historylist}">
				<ul>
					<li>
						<c:if test="${history.simage eq null}"><img src="/image/image_ready2.png" class="img140"></c:if>
						<c:if test="${history.simage ne null}"><img src="downloadSImage.do?snum=${history.snum}" class="img140"></c:if>
					</li>
					<li>
						<span class="storeSpan">가게명 : </span>${history.sname}
						<span class="storeSpan">가게주소 : </span>${history.saddress} ${history.sdetailaddr}
					</li>
					<li>
						<span class="storeSpan">방문날짜 : </span>
						<span>${history.ddate}
							<fmt:parseDate var="dtime" value="${history.dtime}"  pattern="HHmm"/>
							<fmt:formatDate value="${dtime}"  pattern="HH:mm"/>
						</span>
						<span class="storeSpan">방문종류 : </span>
						<c:if test="${history.dtype == 'Y'}">예약 방문</c:if>
						<c:if test="${history.dtype != 'Y'}">직접 방문</c:if><br/>
					</li>
					<li>
						<span class="storeSpan">메뉴 : </span>${history.dmenu}
						<span class="storeSpan">인원 : </span>${history.dperson}명
						<span class="storeSpan">요구사항 : </span>${history.dask}<br/>
					</li>
					<li>
						<div class="btn-wrap" style="margin-bottom:0px;">
							<button class="btn-view w100 mt20" type="button" onClick="storeView('${history.snum}')">상세보기</button>
							<button class="btn-view w100 mt20" type="button" onClick="commentWrite('${history.dnum}}')">리뷰작성</button>
						</div>
					</li>
				</ul>
			</c:forEach>
			</div>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp" />
</body>
