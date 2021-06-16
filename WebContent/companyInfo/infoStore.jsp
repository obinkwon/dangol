<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/image/favicon.png">
<meta charset="UTF-8">
<title>회사소개</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/template.css" />
<script type="text/javascript">
	function infoStore(page,address){//페이지 이동
		location.href='infoStore.do?page='+page+'&address='+address;
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#selectAddress").change(function(){
			location.href="infoStore.do?address="+this.value;
		});
	});
</script>
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">회사소개</a></li>
				<li class="nav"><a class="nav" href="infoCompany.do">단골의 희열 소개</a></li>
				<li class="nav"><a class="nav" href="infoService.do">서비스 소개</a></li>
				<li class="nav"><a class="nav" href="infoBenefit.do">등급별 혜택</a></li>
				<li class="active"><a class="nav" href="infoStore.do">가맹점 현황</a></li>
			</ul>
		</div>
		<div class="section">
			<div class="alert alert-info" role="alert">
				<p><b style="margin-right:20px">숫자로 보는 단골의 희열</b> ${year} 년 ${month} 월 기준</p>
			</div>
			<div class="contents-wrap" style="height:150px;text-align:center;">
				<div class="infoBox">
					<p><b>등록 가맹점 수</b></p>
					<img class="img100" src="/image/shop.png">
					<p class="ftco-animated">${storeCount}개</p>
				</div>
				<div class="infoBox">
					<p><b>가입회원 수</b></p>
					<img class="img100" src="/image/team.png">
					<p class="ftco-animated">${userCount}명</p>
				</div>
				<div class="infoBox">
					<p><b>누적 리뷰 수</b></p>
					<img class="img100" src="/image/rating.png">
					<p class="ftco-animated">${reviewCount}개</p>
				</div>
			</div>
			<div class="contents-wrap" style="height:100%;">
				<div class="contentsTitGroup" style="margin-top:100px;">
					<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">단골의 희열 가맹점 정보</h2>
				</div>
				<div class="toggle-wrap" style="margin-left:700px;">
					<select class="inputText w200" name="address" id="selectAddress">
						<option id="address1" value="전체" <c:if test="${infoView.saddress == ''}">selected</c:if>>전체</option>
						<option id="address2" value="서울" <c:if test="${infoView.saddress == '서울'}">selected</c:if>>서울특별시</option>
						<option id="address3" value="인천" <c:if test="${infoView.saddress == '인천'}">selected</c:if>>인천광역시</option>
						<option id="address4" value="대전" <c:if test="${infoView.saddress == '대전'}">selected</c:if>>대전광역시</option>
						<option id="address5" value="광주" <c:if test="${infoView.saddress == '광주'}">selected</c:if>>광주광역시</option>
						<option id="address6" value="대구" <c:if test="${infoView.saddress == '대구'}">selected</c:if>>대구광역시</option>
						<option id="address7" value="울산" <c:if test="${infoView.saddress == '울산'}">selected</c:if>>울산광역시</option>
						<option id="address8" value="부산" <c:if test="${infoView.saddress == '부산'}">selected</c:if>>부산광역시</option>
						<option id="address9" value="경기" <c:if test="${infoView.saddress == '경기'}">selected</c:if>>경기도</option>
						<option id="address10" value="강원" <c:if test="${infoView.saddress == '강원'}">selected</c:if>>강원도</option>
						<option id="address11" value="충청" <c:if test="${infoView.saddress == '충청'}">selected</c:if>>충청도</option>
						<option id="address12" value="전라" <c:if test="${infoView.saddress == '전라'}">selected</c:if>>전라도</option>
						<option id="address13" value="경상" <c:if test="${infoView.saddress == '경상'}">selected</c:if>>경상도</option>
						<option id="address14" value="제주" <c:if test="${infoView.saddress == '제주'}">selected</c:if>>제주도</option>
						<option id="address15" value="세종" <c:if test="${infoView.saddress == '세종'}">selected</c:if>>세종특별자치시</option>
					</select>
				</div>
				<div>
					<table class="table">
						<colgroup>
							<col width="10%">
							<col width="*">
							<col width="30%">
							<col width="10%">
						</colgroup>
						<tbody>
		                <tr>
		                    <th>가맹점번호</th>
							<th>매장명</th>
							<th>지역</th>
							<th>단골 수</th>
		                </tr>    
						<c:forEach var="store" items="${storeList}" varStatus="status">
							<tr>
								<td>${store.snum}</td>
								<td class="storeName">${store.sname}</td>
								<td>${store.saddress} ${store.sdetailaddr}</td>
								<td>${store.dancnt}명</td>
							</tr>
						</c:forEach>
						<c:if test="${empty storeList}">
							<tr><td colspan="4" style="text-align:center;">해당하는 지점이 없습니다</td></tr>
						</c:if>
						</tbody>
					</table>
				</div>
				<div style="text-align : center;">
					<c:if test="${infoVO.startPage ne 1}">
						<input type="button" value="처음" onclick="infoStore('1','${infoVO.saddress}')">
						<input type="button" value="이전" onclick="infoStore('${infoVO.startPage-1}','${infoVO.saddress}')">
					</c:if>
					<c:forEach var="i" begin="${infoVO.startPage}" end="${infoVO.endPage < infoVO.lastPage ? infoVO.endPage : infoVO.lastPage}">
						<c:choose>
							<c:when test="${i == infoVO.page}">
								[${i}]
							</c:when>
							<c:otherwise>
								<a href="javascript:infoStore('${i}','${infoVO.saddress}')">[${i}]</a>	
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${infoVO.endPage < infoVO.lastPage}">
						<input type="button" value="다음" onclick="infoStore('${infoVO.endPage + 1}','${infoVO.saddress}')">
						<input type="button" value="마지막" onclick="infoStore('${infoVO.lastPage}','${infoVO.saddress}')">
					</c:if>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp"/>
</body> 
</html>