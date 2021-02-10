<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="icon" href="favicon.png">
	<meta charset="UTF-8">
	<title>회사소개</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
	<style type="text/css">
		div.main{
			display : inline;
			width : 100%;
		}
		div.nav {
			margin-top: 50px;
			float: left;
			width: 10%;
			margin-left: 50px;
		}
		div.section{
			float : left;
			margin-left : 10%;
			margin-top : 50px;
			width : 50%;
		}
		div.infoStoreTop,div.infoStoreBotTitle{
			display : inline-block; 
		}
		div.infoStoreTop{
			width : 100%;
			text-align: center;
		}
		div.infoStoreBotTitle{
			width : 100%;
		}
		div.infoStoreList{
			margin : auto;
			float : left;
			width : 310px;
			height : 230px;
			font-size : 17px;
			padding-top : 30px;
			border : 1px solid #d9d9d9;
			border-bottom : 3px solid #d9d9d9;
			border-radius: 4px;
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
		table.table-condensed,th.infoStore{
			margin-bottom : 0px;
			text-align : center;
		}
		th.infoStore{
			background-color : #d9d9d9;
			width : 400px;
			position : inherit;
		}
		a.nav:hover,a.nav_active:hover,a.navTitle:hover{
			text-decoration : none;
			color : #404040;
			cursor: pointer;
		}
		li.navTitle {
			background-color: #d9d9d9;
		}
		li.nav:hover{
			background-color: #e6e6e6;	
		}
		li.nav_active {
			background-color: #66ccff;
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
		li.nav_active {
			background-color: #66ccff;
		}
		img.infoStore{
			width : 100px;
			height : 100px;
		}
		h3.infoStore{
			float : left;
			margin-top : 50px;
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
	<jsp:include page="../jsp/header.jsp"/>
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
				<p><b>숫자로 보는 단골의 희열</b> &nbsp;&nbsp;${year} 년 ${month} 월 기준</p>
			</div>
			<div class="infoStoreTop">
				<div class="infoStoreList">
					<p><b>&nbsp;등록 가맹점 수</b></p>
					<img class="infoStore" src="shop.png">
					<p class="ftco-animated">&nbsp;&nbsp;${storeCount}개</p>
				</div>
				<div class="infoStoreList">
					<p><b>&nbsp;&nbsp;가입회원 수</b></p>
					<img class="infoStore" src="team.png">
					<p class="ftco-animated">&nbsp;&nbsp;${userCount}명</p>
				</div>
				<div class="infoStoreList">
					<p><b>&nbsp;&nbsp;누적 리뷰 수</b></p>
					<img class="infoStore" src="rating.png">
					<p class="ftco-animated">&nbsp;&nbsp;${reviewCount}개</p>
				</div>
			</div>
			<div class="infoStoreBottom">
				<div class="infoStoreBotTitle">
					<h3 class="infoStore">단골의 희열 가맹점 정보</h3>
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
				<table class="table table-condensed">   
					<colgroup>
						<col width="13%">
						<col width="42%">
						<col width="17%">
						<col width="20%">
					</colgroup>                             
	                <tr>
	                    <th class="infoStore">가맹점번호</th>
						<th class="infoStore">매장명</th>
						<th class="infoStore">지역</th>
						<th class="infoStore">단골 수</th>
	                </tr>    
            	</table> 
				<div class="infoStoreBoard">
					<table class="table table-condensed">
						<colgroup>
							<col width="15%">
							<col width="45%">
							<col width="20%">
							<col width="20%">
						</colgroup>
						<c:forEach var="store" items="${storeList}" varStatus="status">
							<tr>
								<td>${store.snum}</td>
								<td class="storeName">${store.sname}</td>
								<td>${store.saddress}</td>
								<td>${storeMemberCount[status.index]}명</td>
							</tr>
						</c:forEach>
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
	<jsp:include page="../jsp/footer.jsp"/>
</body> 
</html>