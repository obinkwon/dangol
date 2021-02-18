<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의_관리자화면</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<style type="text/css">
	div.notice{
		border : 1px solid #000000;
		padding : 10px;
		padding-left : 100px;
	}
	div.main{
		display : inline;
		width : 100%;
	}
	div.nav{
		margin-top: 50px;
		float: left;
		width: 13%;
		margin-left: 50px;
	}
	.section{
		margin-top : 30px;
		float : right;
		width : 60%;
		margin-right : 200px;
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
	.inputText {
	    height: 40px;
	    line-height: 40px;
	    color: #7b6e66;
	    padding: 0 7px;
	    border: 1px solid #7b6e66;
	    background-color: transparent;
	    vertical-align: middle;
	    float: left;
	}
	.w300 {
	    width: 300px;
	}
	.btn-view {
	    width: 200px;
	    font-size: 1.4rem;
	    background-color: #fff;
	    color: #000000;
	    height: 4rem;
	    line-height: 3.9rem;
	    font-weight: 600;
	    letter-spacing: 0.5px;
	    transition-duration: .5s;
	    border: 0.1rem solid #66ccff;
	}
	.ml10{
		margin-left:10px;
	}
	.mt10{
		margin-top:10px;
	}
	.w100{
		width: 100px;
	}
	.selected{
		background-color : #66ccff;
	}
</style>
<script>
	function searchInquiry(){ //글 검색하기
		var state = $('#selState').val();
		var type = $('#selType').val();
		var keyword = $('#selKeyword').val();
		if(state == 'all'){
			location.href="selectAllInquirys.do?type="+type+"&keyword="+keyword;
		}else{
			location.href="selectAllInquirys.do?istate="+state+"&type="+type+"&keyword="+keyword;
		}
	}
		
	function selInquiry(type){ // 전체 / 답변완료 / 미답변 클릭
		if(type == 'all'){
			location.href="selectAllInquirys.do";
		}else{
			location.href="selectAllInquirys.do?istate="+type;
		}
	}
</script>
</head>
<body>
<div class="notice">
	<h1>관리자 페이지입니다.</h1>
</div>
<div class="main">
	<div class="nav">
		<ul class="nav nav-pills nav-stacked">
			<li class="navTitle"><a class="navTitle">화면이동</a></li>
			<li class="nav"><a href="adminRecommandTag.do" class="nav">추천태그</a></li>
			<li class="nav"><a href="adminThemeTag.do" class="nav">테마별 태그</a></li>
			<li class="nav"><a href="adminFoodTag.do" class="nav">업종별 태그</a></li>
			<li class="nav"><a href="adminTasteTag.do" class="nav">맛별 태그</a></li>
			<li class="nav_active"><a href="selectAllInquirys.do" class="nav">1:1문의</a></li>
			<li class="nav"><a href="logout.do" class="nav"><button>로그아웃</button></a></li>
		</ul>
	</div>
	<div class="section">
		<c:forEach var="count" items="${cntList}" varStatus="status">
			<button class="btn-view w100 <c:if test="${count.itype == state}">selected</c:if>" onclick="selInquiry('${count.itype}');"> ${count.ititle}(${count.cnt})</button>
		</c:forEach>
	</div>
	<div class="section mt10">
		<!-- 글 검색하기 -->
		<input class="inputText w300" type="text" id="selKeyword" placeholder="검색내용을 입력하세요">
		<input type="hidden" id="selState" name="state" value="${state}">
		<select class="inputText w300 ml10" id="selType">
			<option value="title" selected>제목으로 찾기</option>
			<option value="content" >내용으로 찾기</option>
			<option value="mid" >ID로 찾기</option>
		</select>
		<button class="btn-view ml10" type="button" onclick="searchInquiry();">검색</button>
		<table class="table mt10">
			<colgroup>
				<col width="5%">
				<col width="10%">
				<col width="*">
				<col width="10%">
				<col width="10%">
			</colgroup>
			<thead>
				<tr>
					<th scope="col">번호</th>
					<th scope="col">구분</th>
					<th scope="col">제목</th>
					<th scope="col">날짜</th>
					<th scope="col">답변여부</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="inquiry" items="${iList}" varStatus="status">
				<tr>
					<td>${inquiry.rownum}</td>
					<td>
						<c:if test="${inquiry.itype == 'service'}">
							서비스
						</c:if>
						<c:if test="${inquiry.itype == 'site'}">
							사이트
						</c:if>
					</td>
					<td><a href="selectInquiryDetail.do?inum=${inquiry.inum}">${inquiry.ititle}</a></td>
					<td><fmt:formatDate value="${inquiry.idate}" pattern="yyyy.MM.dd"/></td>
					<td>
						<c:if test="${inquiry.istate == 'yes'}">
							답변완료
						</c:if>
						<c:if test="${inquiry.istate == 'no'}">
							미답변
						</c:if>
					</td>
				</tr>
				</c:forEach>	
			</tbody>
		</table>
	</div>
</div>
</body>
</html>