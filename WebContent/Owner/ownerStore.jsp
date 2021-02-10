<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 가게_사장님</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style type="text/css">
		.ownerNav {
		  margin: 30px;
		  float: left;
		  position: sticky;
		  border: solid;
		  border-color: LightSeaGreen;
		}
		
		#infoForm {
		}
		
		#updateForm {
		}
		
	</style>
</head>
<body>
	<jsp:include page="/jsp/header.jsp"/>
	
<!-- 사장님 메뉴바-->
<div class="main">
	<div class="nav">
		<ul class="nav nav-pills nav-stacked">
			<li class="navTitle"><a class="navTitle" href="ownerInfoForm.do">사장님 페이지</a></li>
			<li class="active"><a class="nav" href="ownerInfoForm.do">내 정보</a></li>
			<li class="nav"><a class="nav" href="ownerStore.do">내 가게<span class="sr-only">(current)</span></a></li>
			<li class="nav"><a class="nav" href="selectDetailsBySnum.do">예약현황</a></li>
		</ul>
	</div>
</div>

<h1>${boss.bid}님의 가게 등록 현황</h1>
<input type="button" value="추가">

	<table>
		<tr>
			<th>구분</th>
			<th>이름</th>
			<th>주소</th>
			<th>전화번호</th>
			<th>수정</th>
			<th>삭제</th>
		</tr>
			<c:forEach var="store" items="${stores}">
				<tr>
					<td>${store.stype}</td>
					<td>${store.sname}</td>
					<td>${store.saddress}</td>
					<td>${store.sdetailaddr}</td>
					<td>${store.sphone}</td>
					<td><input type="button" value="수정"></td>
					<td><input type="button" value="삭제"></td>
				</tr>
			</c:forEach>
	</table>
</body>
</html>