<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지 - 예약현황</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/template.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
function cancelReserve(dnum){//예약 췩소
	if(confirm('예약을 취소 하시겠습니까?')){
		location.href='cancelReserve.do?dnum='+dnum;
	}
}
</script>
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
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">(${mid}) 단골님의 예약현황</h2>
			</div>
			<table class="table">
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="6%">
					<col width="*">
					<col width="*">
					<col width="10%">
				</colgroup>
				<tbody>
				<tr class="info">
					<th>날짜</th>
					<th>예약시간</th>
					<th>인원</th>
					<th>메뉴</th>
					<th>가게</th>
					<th>취소</th>
				</tr>
				<c:forEach var="reserve" items="${reserveList}">
					<tr>
						<td>${reserve.ddate}</td>
						<td>
							<fmt:parseDate var="dtime" value="${reserve.dtime}"  pattern="HHmm"/>
							<fmt:formatDate value="${dtime}"  pattern="HH:mm"/>
						</td>
						<td>${reserve.dperson} 명</td>
						<td>${reserve.dmenu}</td>
						<td>
							<c:if test="${reserve.simage eq null}"><img src="image_ready2.png" class="img50"></c:if>
							<c:if test="${reserve.simage ne null}"><img src="downloadSImage.do?snum=${reserve.snum}" class="img50"></c:if>
							${reserve.sname}
						</td>
						<td>
							<button class="btn-view w100" type="button" onclick="cancelReserve('${reserve.dnum}')">취소</button>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty reserveList}">
					<tr>
						<td colspan="6" style="text-align:center;">예약한 이력이 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
<jsp:include page="../jsp/footer.jsp" />
</body>
</html>