<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>즐겨찾기</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/template.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
	function historyLike(mid,snum,glike){// 즐겨찾기 변경
		location.href='historyLike.do?mid='+mid+'&snum='+snum+'&glike='+glike;
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
				<li class="active"><a class="nav" href="bookmark.do">즐겨찾기</a></li>
				<li class="nav"><a class="nav" href="historyList.do">방문내역</a></li>
				<li class="nav"><a class="nav" href="reserveState.do">예약현황</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">(${mid})&nbsp;단골님의 단골집</h2>
			</div>
			<div class="bookmarkList">
				<c:forEach var="bookmark" items="${bookmarkList}">
					<ul>
						<li>
							<c:if test="${bookmark.simage eq null}"><img src="/image/image_ready2.png" class="img100"></c:if>
							<c:if test="${bookmark.simage ne null}"><img src="downloadSImage.do?snum=${bookmark.snum}" class="img100"></c:if>
						</li>
						<li>
							<span class="storeSpan">${bookmark.sname}</span><br/>
							<span class="storeSpan">${bookmark.saddress} ${bookmark.sdetailaddr}</span><br/>
							<button class="btn-view w100 mt20" type="button" onClick="storeView('${bookmark.snum}')">상세보기</button>
						</li>
						<li>
							<span class="storeSpan">
								<c:if test="${bookmark.glevel == 0}">범골</c:if>
								<c:if test="${bookmark.glevel == 1}">진골</c:if>
								<c:if test="${bookmark.glevel == 2}">성골</c:if>
								<c:if test="${bookmark.glevel == 3}">단골</c:if>
							</span>
							<br/>
							<c:if test="${bookmark.glike == 1}">
								<button class="imgBtn m0" onclick="historyLike('${mid}','${bookmark.snum}','0')">
									<img class="img50" src="/image/likes.png">
								</button>
							</c:if>
						</li>
					</ul>
				</c:forEach>
			</div>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp" />
</body>
</html>