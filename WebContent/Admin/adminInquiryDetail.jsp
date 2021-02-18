<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의_상세</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
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
	.table {
		margin-bottom : 10px;
		border-bottom : 1px solid #ddd;
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
	.inputTextArea{
		width:100%;
		height:300px;
		resize: none;
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
	.mauto{
		margin : 0 auto;
	}
	.btn-wrap {
		display: block;
		text-align: center;
	    width: 100%;
	    margin: 0 auto;
	    margin-bottom : 30px;
	}
	.btn-mint{
		background-color: #66ccff;
		color: #fff;
	}
</style>
<script type="text/javascript">
	function insAnswer(){ //답변 등록
		if($('#answerArea').val() == ''){
			alert('답변 내용을 입력해주세요');
		}else{
		    $('#frmList').submit();
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
		<div class="page_title">
			<h3>1:1문의 상세</h3>
		</div>
		<form id="frmList" action="insertInquiryAnswer.do" method="post">
		<table class="table">
			<colgroup>
				<col width="10%">
				<col width="*">
			</colgroup>
			<tbody>
				<tr>
					<td>제목</td>
					<td>
						<input type="hidden" name="inum" value="${inquiry.inum}">
						<input type="text" name="ititle" class="inputText w300" value="${inquiry.ititle}" readonly>
					</td>
				</tr>
				<tr>
					<td>문의구분</td>
					<td>
						<c:if test="${inquiry.itype == 'service'}">
							<input type="text" name="service" class="inputText w300" value="서비스" readonly>
						</c:if>
						<c:if test="${inquiry.itype == 'site'}">
							<input type="text" name="site" class="inputText w300" value="사이트" readonly>
						</c:if>
						<input type="hidden" name="itype" value="${inquiry.itype}">
					</td>
				</tr>
				<tr>
					<td>연락처</td>
					<td>
						<c:if test="${inquiry.mphone ne null}">
							<input type="text" name="phone" class="inputText w300" value="${inquiry.mphone}" readonly>
						</c:if>
						<c:if test="${inquiry.bphone ne null}">
							<input type="text" name="phone" class="inputText w300" value="${inquiry.bphone}" readonly>
						</c:if>
					</td>
				</tr>
				<tr>
					<td>문의내용</td>
					<td>
						<textarea class="inputTextArea" name="icontent" readonly>${inquiry.icontent}</textarea>
					</td>
				</tr>
				<tr>
					<td>답변내용</td>
					<td>
						<textarea id="answerArea" class="inputTextArea" name="ianswer">${inquiry.ianswer}</textarea>
					</td>
				</tr>
			</tbody>
		</table>
		<div class="btn-wrap">
			<button type="button" class="btn-view" onclick="history.back(-1)">취소</button>
			<button type="button"  class="btn-view btn-mint" onclick="insAnswer();">작성완료</button>
		</div>
		</form>
	</div>
</div>
</body>
</html>