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
<style type="text/css">
div.infoStoreBotTitle{
	display : inline-block; 
	width : 100%;
}
		div.infoStoreBoard{
			width : 100%;
			height : 310px;
			overflow: auto;
			border : 1px solid #d9d9d9;
		}
		div.card-body{
			height : 200px;
		}
		div.row{
			margin-left : 5px;
		}
		select.infoStoreBottom{
			width : 100px;
			height : 30px;
			float : right;
			margin-top : 50px;
		} 
</style>
<script type="text/javascript">
		$(document).ready(function(){
			$("#selectAddress").change(function(){
				location.href="infoStore.do?address="+this.value;
			});
			switch ('${param.address}') {//선택 지역 유지
			case "서울":
				$('#address2').prop('selected','true');
				break;
			case "인천":
				$('#address3').prop('selected','true');
				break;
			case "대전":
				$('#address4').prop('selected','true');
				break;
			case "광주":
				$('#address5').prop('selected','true');
				break;
			case "대구":
				$('#address6').prop('selected','true');
				break;
			case "울산":
				$('#address7').prop('selected','true');
				break;
			case "부산":
				$('#address8').prop('selected','true');
				break;
			case "경기":
				$('#address9').prop('selected','true');
				break;
			case "강원":
				$('#address10').prop('selected','true');
				break;
			case "충청":
				$('#address11').prop('selected','true');
				break;
			case "전라":
				$('#address12').prop('selected','true');
				break;
			case "경상":
				$('#address13').prop('selected','true');
				break;
			case "제주":
				$('#address14').prop('selected','true');
				break;
			case "세종":
				$('#address15').prop('selected','true');
				break;
			default:
				$('#address1').prop('selected','true');
				break;
			}
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
			<div style="text-align:center;">
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
			<div class="infoStoreBottom" style="margin-top : 50px;">
				<div class="infoStoreBotTitle">
					<h3>단골의 희열 가맹점 정보</h3>
					<select class="infoStoreBottom" name="address" id="selectAddress">
						<option id="address1" value="전체">전체</option>
						<option id="address2" value="서울">서울특별시</option>
						<option id="address3" value="인천">인천광역시</option>
						<option id="address4" value="대전">대전광역시</option>
						<option id="address5" value="광주">광주광역시</option>
						<option id="address6" value="대구">대구광역시</option>
						<option id="address7" value="울산">울산광역시</option>
						<option id="address8" value="부산">부산광역시</option>
						<option id="address9" value="경기">경기도</option>
						<option id="address10" value="강원">강원도</option>
						<option id="address11" value="충청">충청도</option>
						<option id="address12" value="전라">전라도</option>
						<option id="address13" value="경상">경상도</option>
						<option id="address14" value="제주">제주도</option>
						<option id="address15" value="세종">세종특별자치시</option>
					</select>
				</div>
				<div class="infoStoreBoard">
					<table class="table" style="text-align:center;">
						<colgroup>
							<col width="10%">
							<col width="*">
							<col width="20%">
							<col width="20%">
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
								<td>${store.saddress}</td>
								<td>${storeMemberCount[status.index]}명</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
				<div style="text-align : center;">
				<c:if test="${viewInfo.start ne 1}">
					<input type="button" value="처음" onclick="location.href='infoStore.do??page=1&address=${param.address}'">
					<input type="button" value="이전" onclick="location.href='infoStore.do?page=${viewInfo.start-1}&address=${param.address}'">
				</c:if>
				<c:forEach begin="${viewInfo.start}" end="${viewInfo.end<viewInfo.last?viewInfo.end:viewInfo.last}" var="i">
					<c:choose>
						<c:when test="${i==viewInfo.current}">
							[${i}]
						</c:when>
						<c:otherwise>
							<a href="infoStore.do?page=${i}&address=${param.address}">[${i}]</a>	
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${viewInfo.end < viewInfo.last}">
					<input type="button" value="다음" onclick="location.href='infoStore.do?page=${viewInfo.end+1}&address=${param.address}'">
					<input type="button" value="마지막" onclick="location.href='infoStore.do?page=${viewInfo.last}&address=${param.address}'">
				</c:if>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp"/>
</body> 
</html>