<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
<link href='http://fonts.googleapis.com/css?family=Lato' rel='stylesheet' type='text/css'>
<script src='http://cdnjs.cloudflare.com/ajax/libs/jquery/2.1.3/jquery.min.js'></script>
<script src="/js/calendar.js"></script>
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
	.contentsTitGroup{
		padding-top: 2.0rem;
	    text-align: center;
	    display: block;
	}
	.inputText {
		height: 40px;
	    line-height: 40px;
	    color: #7b6e66;
	    padding: 0 7px;
	    border: 1px solid #7b6e66;
	    background-color: transparent;
	    float: left;
	}
	.w300 {
	    width: 300px;
	}
	.toggle-wrap {
		width : 100%;
	    margin-bottom : 100px;
	    margin-left :800px;
	    width: 41.1rem;
	    font-size: 1.6rem;
	    display: block;
	}
	.contents-wrap{
		width: 100%;
		height : 600px;
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
</head>
<body>
	<jsp:include page="/jsp/header.jsp"/>
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">사장님 페이지</a></li>
				<li><a class="nav" href="ownerInfoForm.do">내 정보</a></li>
				<li><a class="nav" href="ownerStore.do">내 가게</a></li>
				<li class="active"><a class="nav" href="selectDetailsBySnum.do">예약현황</a></li>
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
					<c:if test="${not empty stores}">
						<option id="0" value="-1">내 모든 가게</option>
						<c:forEach var="store" items="${stores}">
							<option id="${store.snum}" value="${store.snum}">${store.sname}</option>
						</c:forEach>
					</c:if>
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
					<col width="30%"/>
					<col width="30%"/>
					<col width="10%"/>
				</colgroup>
				<tbody>
					<tr>
						<th>날짜</th>
						<th>ID</th>
						<th>핸드폰</th>
						<th>인원</th>
						<th>메뉴</th>
						<th>요청사항</th>
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
					<c:if test="${details eq null}">
					<tr>
						<td colspan="7" style="text-align:center;">예약이 없습니다</td>
					</tr>
					</c:if>
				</tbody>
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
		</div>
	</div>
	<jsp:include page="/jsp/footer.jsp"/>
</body>
</html>