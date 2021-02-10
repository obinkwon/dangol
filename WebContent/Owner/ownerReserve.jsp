<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>예약현황_사장님</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<style type="text/css">
div.main {
	display: block;
	width: 100%;
	margin-top: 50px;
	margin-bottom:100px;
}

div.nav {
	margin-top: 50px;
	float: left;
	width: 10%;
	margin-left: 50px;
}

div.reserveContent {
	position: relative;
	margin-left: 22%;
}

table.reserveList {
	position: relative;
	margin-top: 17px;
	width: 95%;
	height: 140px;
	border: 1px #d9d9d9;
}

table.reserveList th, td {
	text-align: center;
}

table.reserveList th {
	background-color: #d9d9d9;
	height: 30px;
}

table.reserveList td {
	height: 100px;
}

table.reserveList tr {
	border: 1px solid #d9d9d9;
}

/* 달력 */
#calendar {
 boarder: 1px solid;
 vertical-align: center;
 text-align: center;
 align: center;
}

td {
 width: 60px;
 height: 60px;
 text-align: center;
 font-size: 20px;
 font-family: 바탕;
 border:2px solid black;
 border-radius:8px;
}

td:hover {
  color: red;
  text-align: center;
}


/* 회원검색 */
#txt_search_member{
 width: 350px;
 height: 30px;
}

#btn_search_member{
 border-radius: 5px;
 width: 30px;
 height: 30px;
}

#btn_search_member:hover{
 border-color: blue;
}
</style>
	
<!--  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
function search_member() {
	$("#div_manual").show();
	
	$.ajax({
		url : "selectMembersByKeyword.do",
		data :{
			keyword : $("#txt_search_member").val()
		},
		type : "post",
		success : function(data){
			var table = "";
			$('#tbl_membership tr:gt(0)').remove();
			
			for( var key in data.members){
				table += '<tr>';
				table += '<td>' + data.members[key].mid + '</td>';
				table += '<td>' + data.members[key].mphone + '</td>';
					if (data.grades[key] == null) {
						table += '<td>' + '없음' + '</td>';
					}else{
						table += '<td>' + data.grades[key].glevel + '</td>';
					}
					if (data.details[key] == null) {
						table += '<td>' + '없음' + '</td>'; 
					} else {
						table += '<td>' + data.details[key].dcount + '</td>';
					}
					if (data.rates[key] == null) {
						table += '<td>' + '없음' + '</td>'; 
					} else {
						table += '<td>' + data.rates[key] + '%</td>';
					}
				table += '<td><input class="btn_membership" type="button" value="적용"></td>';
				table += '</tr>';
			}
			
			$('#tbl_membership tr:eq(0)').after(table);

			/* 멤버쉽 적용 */
			$(".btn_membership").on("click",function(){
					alert("멤버쉽혜택이 적용되었습니다.");
			});
		},
		error :function(){
			alert("서비스 오류입니다.\n 관리자에게 문의해주세요");
		}
	});
}

$(function(){
	$("#div_manual").hide();
	
	if (${bid != null} && ${Stores == "[]"}) {
		alert("사장님 가게 등록을  먼저 해주세요");
	}
	
	$("#select_store").on("change",function(){
		location.href="selectDetailsBySnum.do?snum="+this.value;
	});
	
	/* 신고기능 */
	$("#btn_report").on("click",function(){
		if (confirm("정말로 신고하시겠습니까?")) {
			alert("신고되었습니다");
/* 			location.href="deleteTag.do?anum="+$("#del_TasteTag").val(); */			
		}
	});
	
});
</script>
<!-- 달력 코드 -->
<script type="text/javascript">
	var today = new Date();
	
	/* 저번 달 구하기 */
	function prevCalendar() {
		 today = new Date(today.getFullYear(), today.getMonth() - 1, today.getDate());
		 buildCalendar();
	}

	/* 다음 달 구하기 */
	function nextCalendar() {
		 today = new Date(today.getFullYear(), today.getMonth() + 1, today.getDate());
		 buildCalendar();
	}
	
	/* 달력 만들기 */
	function buildCalendar() {
		 var nMonth = new Date(today.getFullYear(), today.getMonth(), 1);  // 이번 달의 첫째 날
		 var lastDate = new Date(today.getFullYear(), today.getMonth()+1, 0); // 이번 달의 마지막 날
		 var tblCalendar = document.getElementById("calendar");     // 테이블 달력을 만들 테이블
		 var tblCalendarYM = document.getElementById("calendarYM");    // yyyy년 m월 출력할 곳
		 tblCalendarYM.innerHTML = today.getFullYear() + "년 " + (today.getMonth() + 1) + "월";  // yyyy년 m월 출력
		 
		// 기존 테이블에 뿌려진 줄, 칸 삭제
		 while (tblCalendar.rows.length > 2) {
			  tblCalendar.deleteRow(tblCalendar.rows.length - 1);
		 }
		 
		 var row = null;
		 row = tblCalendar.insertRow();
		 var cnt = 0;
		 
		// 1일이 시작되는 칸을 맞추어 줌
		 for (i=0; i<nMonth.getDay(); i++) {
		  cell = row.insertCell();
		  cnt = cnt + 1;
		 }
		 
		 for (i=1; i<=lastDate.getDate(); i++) { 
		  cell = row.insertCell();
		  cell.innerHTML = i;
		  cnt = cnt + 1;
		  
		  if (cnt%7 == 0)// 1주일이 7일 이므로
		   row = calendar.insertRow();// 줄 추가
		 }
	 
	}
</script>
</head>
<body>
	<jsp:include page="/jsp/header.jsp"/>

<!-- 사장님 메뉴바-->
<div class="main">
	<div class="nav">
		<ul class="nav nav-pills nav-stacked">
			<li class="navTitle"><a class="navTitle" href="ownerInfoForm.do">사장님 페이지</a></li>
			<li class="active"><a class="nav" href="ownerInfoForm.do">내 정보</a></li>
			<li class="nav"><a class="nav" href="ownerStore.do">내 가게</a></li>
			<li class="nav"><a class="nav" href="selectDetailsBySnum.do">예약현황<span class="sr-only">(current)</span></a></li>
		</ul>
	</div>
</div>


<h1>예약현황</h1>

<!-- 달력 -->
<table id="calendar">
	<tr>
		<td><label onclick="prevCalendar()">&lt;</label></td>
	    <td id="calendarYM" colspan="5" align="center" >yyyy년 m월</td>
	    <td><label onclick="nextCalendar()">></label></td>
    </tr>
    <tr class="td_calendarWeek">
	     <td>일</td>
	     <td>월</td>
	     <td>화</td>
	     <td>수</td>
	     <td>목</td>
	     <td>금</td>
	     <td>토</td>
   </tr>
</table>


<!-- 가게선택 단추 -->
<c:if test="${not empty bid}">
	<div>
		가게선택 : 
		<select id="select_store">
					<option id="-1" value="-1">(가게선택)</option>
			<c:if test="${not empty stores}">
					<option id="0" value="0">내 모든 가게</option>
				<c:forEach var="store" items="${stores}">
					<option id="${store.snum}" value="${store.snum}">${store.sname}</option>
				</c:forEach>
			</c:if>
		</select>
	</div>	
</c:if>

<!-- 예약목록 -->
<table class="reserveList">
	<tr>
		<th width="10%">날짜</th>
		<th width="5%">ID</th>
		<th width="10%">핸드폰</th>
		<th width="5%">인원</th>
		<th width="30%">메뉴</th>
		<th width="30%">요청사항</th>
		<th>신고하기</th>
	</tr>
	<c:forEach var="detail" items="${details}" varStatus="status">
	<tr>
		<td>${detail.ddate}</td>
		<td>${reservers[status.index].mid}</td>
		<td>${reservers[status.index].mphone}</td>
		<td>${detail.dperson}</td>
		<td>${detail.dmenu}</td>
		<td>${detail.dask}</td>
		<td><input id="btn_report" type="button" value="신고"></td>
	</tr>
	</c:forEach>
</table>

<!-- 예약가능인원 변경 및 확인 -->
<div id="div_reservation">
	<h4>예약 인원 / 예약 가능인원</h4>
	<input id="txt_reserved_member" type="text" value="test2"> / <input id="txt_reserveable_member" type="text" value="test">명
	<input id="btn_update_reserve" type="button" value="수정">
</div>

<div id="div_search_member">	
	<hr>
	<h1>단골멤버쉽 적용</h1>
	<input id="txt_search_member" type="text" placeholder="검색할 회원의 ID 또는 핸드폰 뒷자리를 입력해주세요">
	<input id="btn_search_member" type="image" src="images/magnifying_glass.jpg" onclick="search_member()"><br>
	 * 핸드폰 번호 및 일치하는 아이디 입력
</div>

<!-- 혜택내역 적용 -->
<div id="div_manual">
	<table id="tbl_membership">
		<tr>
			<th>ID</th>
			<th>핸드폰번호</th>
			<th>등급</th>
			<th>후기</th>
			<th>예상혜택</th>
			<th>멤버쉽</th>
		</tr>
	</table>
</div>

<script type="text/javascript">
buildCalendar();
</script>
</body>
</html>