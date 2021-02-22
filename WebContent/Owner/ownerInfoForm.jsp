<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보_사장님</title>
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
	table.signForm {	
		margin : auto;		
		font-size: 15px;
	}
	.formTitle {
		text-align : center;
		margin-top: 20px;
		margin-bottom: 20px;
		font-size: 24px;
		font-weight: bold;
	}
	table.signForm td {
		padding : 10px;
		height: 30px;
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
	.btn-wrap {
		display: block;
		text-align: center;
	    width: 100%;
	    margin: 0 auto;
	    margin-bottom : 30px;
		padding-top: 4.5rem;
	}
	.contentsTitGroup{
		padding-top: 2.0rem;
	    text-align: center;
	    display: block;
	}
</style>
<script type="text/javascript">
/* 수정 전 제약사항 */
function checkpw() {
	/* 비밀번호 제대로 입력했을 때 */
	if (($('#txt_checkpw').text() == "비밀번호가 일치합니다")) {
		return true
	}else{
		/* 비밀번호 다르게 입력했을 때 */
		return false
	}
}

function updateBtn(){ //수정하기
	if(checkpw()){
		if(confirm("수정하시겠습니까?")){
			$('#frmList').submit();	
		}
	}else{
		alert("필수정보를 정확히 입력해주세요");
	}
}

$(function(){
	/* 탈퇴하기 */
	$("#btn_drop_member").on("click", function(){
		var chk1 = $('#pwd_checkpw1').val();
		if (confirm("정말로 탈퇴하시겠습니까?")) {
 			var password = prompt('개인정보 확인을 위해 \n비밀번호를 한 번 더 입력해주세요','');
 			if (password == chk1) {
				alert("그동안 단골의 희열 서비스를 \n이용해주셔서 감사합니다");
				location.href="deleteOwner.do";	
			}
		}
	});
	
	$("#pwd_checkpw2").blur(function(){
		if ($('#pwd_checkpw1').val() == $('#pwd_checkpw2').val()) {
			$('#txt_checkpw').text("비밀번호가 일치합니다");
			$('#txt_checkpw').css({'color':'green'});
		}else{
			$('#txt_checkpw').text("비밀번호가 일치하지 않습니다");
			$('#txt_checkpw').css({'color':'red'});
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
				<li class="active"><a class="nav" href="ownerInfoForm.do">내 정보</a></li>
				<li><a class="nav" href="ownerStore.do">내 가게</a></li>
				<li><a class="nav" href="selectDetailsBySnum.do">예약현황</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">(${bid})님의 정보</h2>
			</div>
			<form class="signForm" id="frmList" action="updateOwner.do">
				<table class="signForm">
					<tr>
						<td><span style="color:red">* </span>아이디</td>
						<td><input class="inputText w300" type="text" name="bid" value="${boss.bid}" readonly="readonly"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>비밀번호</td>
						<td><input class="inputText w300" id="pwd_checkpw1" name="bpw" value="${boss.bpw}" type="password"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>비밀번호 확인</td>
						<td><input class="inputText w300" id="pwd_checkpw2" value="" type="password"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td id="txt_checkpw"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>전화번호</td>
						<td><input class="inputText w300" type="text" name="bphone" value="${boss.bphone}"></td>
					</tr>
					<tr>
						<td>가게 현황</td>
						<td>
							<c:choose>
								<c:when test="${empty stores}">등록된 가게가 없습니다.</c:when>
								<c:otherwise>
									<c:forEach var="store" items="${stores}">
										<ul class="stores">
											<li><a href="">${store.sname}</a></li>
										</ul>
									</c:forEach>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
				</table>
				<div class="contentsTitGroup">
					<h4 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);"><span style="color:red">* </span>표시는 필수 입력 사항입니다.</h4>
				</div>
				<div class="btn-wrap">
					<button class="btn-view btn-mint" type="button" onclick="updateBtn();">수정하기</button>
					<button class="btn-view" id="btn_drop_member" type="button">탈퇴하기</button>
				</div>
			</form>
		</div>
	</div>
</body>
</html>