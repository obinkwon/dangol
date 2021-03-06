<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사장님_내 가게</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.main {
		margin : auto;
		margin-top: 50px;
		margin-bottom:100px;
		width: 100%;
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
	.btn-view {
	    width: 100px;
        font-size: 1.4rem;
        background-color: #fff;
		color: #000000;
	    height: 4rem;
	    margin: 0 auto;
	    line-height: 3.9rem;
		font-weight: 600;
	    letter-spacing: 0.5px;
	    transition-duration: .5s;
        border: 0.1rem solid #66ccff;
	}
	.btn-mint{
		background-color: #66ccff;
		color: #fff;
	}
	.contentsTitGroup{
		padding-top: 2.0rem;
	    text-align: center;
	    display: block;
	}
	.btn-wrap {
		display: block;
		text-align:right;
	    width: 100%;
	    margin: 0 auto;
	    margin-bottom : 20px;
		padding-top: 4.5rem;
	}
	</style>
	<script type="text/javascript">
		function addStore(){ //가게 추가
			location.href="ownerStoreForm.do?mode=ADD";
		}
		
		function uptStore(snum){ //가게 수정
			location.href="ownerStoreForm.do?mode=MOD&snum="+snum;
		}
		
		function delStore(){ //가게 삭제
			location.href="ownerStoreForm.do";
		}
	</script>
</head>
<body>
	<jsp:include page="/jsp/header.jsp"/>
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">사장님 페이지</a></li>
				<li><a class="nav" href="ownerInfoForm.do">내 정보</a></li>
				<li class="active"><a class="nav" href="ownerStore.do">내 가게</a></li>
				<li><a class="nav" href="selectDetailsBySnum.do">예약현황</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">${boss.bid}님의 가게 등록 현황</h2>
			</div>
			<div class="btn-wrap">
				<button class="btn-view btn-mint" type="button" onClick="addStore();">추가</button>
			</div>
			<table class="table">
				<colgroup>
					<col width="10%"/>
					<col width="20%"/>
					<col width="*"/>
					<col width="15%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>구분</th>
						<th>가게이름</th>
						<th>주소</th>
						<th>전화번호</th>
						<th>수정</th>
						<th>삭제</th>
					</tr>
					<c:forEach var="store" items="${stores}">
					<tr>
						<td>${store.avalue}</td>
						<td>${store.sname}</td>
						<td>${store.saddress} ${store.sdetailaddr}</td>
						<td>${store.sphone}</td>
						<td><button class="btn-view w100" type="button" onClick="uptStore('${store.snum}');">수정</button></td>
						<td><button class="btn-view w100" type="button" >삭제</button></td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="/jsp/footer.jsp"/>
</body>
</html>