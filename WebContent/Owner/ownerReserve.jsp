<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약현황_사장님</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel='stylesheet prefetch' href='http://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css'>
<link rel="stylesheet" href="/css/calendar.css">
<link rel="stylesheet" href="/css/template.css" />
<link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="/js/calendar.js"></script>
<script type="text/javascript">
//회원 정보 조회
function search_member() {
	var keyword = $("#txt_search_member").val();
	if(keyword != ''){
		$("#div_manual").show();
		
		$.ajax({
			url : "selectMembersByKeyword.do",
			data :{
				keyword : keyword
			},
			type : "post",
			success : function(data){
				var table = "";
				$('#tbl_membership tr:gt(0)').remove();
				
				data.forEach (function (el, index) {
					table += '<tr>';
					table += '<td>' + el.mid + '</td>';
					table += '<td>' + el.mphone + '</td>';
					table += '<td><button class="btn-view w100" type="button" onclick="memberShip('+el.dnum+')">적용</button></td>';
					table += '</tr>';
				});
				
				$('#tbl_membership tr:eq(0)').after(table);
			},
			error :function(){
				alert("서비스 오류입니다.\n 관리자에게 문의해주세요");
			}
		});
	}else{
		alert('전화번호를 입력해주세요');
	}
}

function report(){//신고하기 (ing)
	if (confirm("정말로 신고하시겠습니까?")) {
		alert("신고되었습니다");
	}
}

function memberShip(dnum){//멤버쉽 적용 (ing)
	if(dnum > 0){
		if (confirm("적용하시겠습니까?")) {
			$.ajax({
				url : "memberShipAply.do",
				data :{
					dnum : dnum
				},
				type : "post",
				success : function(data){
					if(data){
						alert("멤버쉽혜택이 적용되었습니다");
					}else{
						alert("서비스 오류입니다.\n 관리자에게 문의해주세요");
					}
				},
				error :function(){
					alert("서비스 오류입니다.\n 관리자에게 문의해주세요");
				}
			});
		}
	}else{
		alert("서비스 오류입니다.\n 관리자에게 문의해주세요");
	}
}

$(function(){
	$("#select_store").on("change",function(){
		location.href="reserveOwner.do?snum="+this.value;
	});
});
</script>
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">사장님 페이지</a></li>
				<li><a class="nav" href="ownerInfoForm.do">내 정보</a></li>
				<li><a class="nav" href="ownerStore.do">내 가게</a></li>
				<li class="active"><a class="nav" href="reserveOwner.do">예약현황</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">예약현황</h2>
			</div>
			<!-- 가게선택 단추 -->
			<div class="toggle-wrap">
				<h4 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">가게선택</h4>
				<select class="inputText w300" id="select_store">
					<option value="0" <c:if test="${snum == 0}">selected</c:if>>내 모든 가게</option>
					<c:forEach var="store" items="${storeList}">
						<option value="${store.snum}" <c:if test="${store.snum == snum}">selected</c:if>>${store.sname}</option>
					</c:forEach>
				</select>
			</div>	
			<!-- calendar -->
			<div class="contents-wrap">
				<div id="calendar">
					<div id="calendar_header">
						<i class="icon-chevron-left"></i>          
						<h1></h1>
						<i class="icon-chevron-right"></i>         
					</div>
					<div id="calendar_weekdays"></div>
					<div id="calendar_content"></div>
				</div>
			</div>
			
			<!-- 예약목록 -->
			<table class="table">
				<colgroup>
					<col width="10%"/>
					<col width="5%"/>
					<col width="10%"/>
					<col width="5%"/>
					<col width="*"/>
					<col width="*"/>
					<col width="*"/>
					<col width="10%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>날짜</th>
						<th>ID</th>
						<th>핸드폰</th>
						<th>인원</th>
						<th>가게</th>
						<th>메뉴</th>
						<th>요청사항</th>
						<th>변경</th>
						<th>신고</th>
						<th>멤버쉽</th>
					</tr>
					<c:forEach var="detail" items="${detailList}" varStatus="status">
					<tr>
						<td>${detail.ddate}</td>
						<td>${detail.mid}</td>
						<td>${detail.mphone}</td>
						<td>${detail.dperson} 명</td>
						<td>${detail.sname} 명</td>
						<td>${detail.dmenu}</td>
						<td>${detail.dask}</td>
						<td><button class="btn-view w100" type="button" onclick="updateReserve('${detail.dnum}')">변경</button></td>
						<td><button class="btn-view w100" type="button" onclick="report()">신고</button></td>
						<td><button class="btn-view w100" type="button" onclick="memberShip('${detail.dnum}')">적용</button></td>
					</tr>
					</c:forEach>
					<c:if test="${empty detailList}">
					<tr>
						<td colspan="10" style="text-align:center;">예약이 없습니다</td>
					</tr>
					</c:if>
				</tbody>
			</table>

			<!-- 회원 조회 -->
			<div class="btn-wrap">
				<h4 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0); float:left; margin-right:20px;">단골멤버쉽 적용</h4>
				<input class="inputText w300" id="txt_search_member" type="text" placeholder="검색할 회원의 핸드폰 뒷자리를 입력해주세요">
				<button class="btn-view w100 " type="button" onClick="search_member();" style="float:left;">검색</button>
			</div>
			<!-- 혜택내역 적용 -->
			<div class="w50Form" id="div_manual" style="display:none;">
				<table class="table" id="tbl_membership">
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
						<col width="15%"/>
					</colgroup>
					<tbody>
						<tr>
							<th>ID</th>
							<th>핸드폰번호</th>
							<th>멤버쉽 적용</th>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp"/>
</body>
</html>