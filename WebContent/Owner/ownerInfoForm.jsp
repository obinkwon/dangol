<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내 정보_사장님</title>
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
	<style type="text/css">
		#tbl_updateForm{
			width:150px;
			height:100px;
		}
		
		td{
			overflow:auto;
		}
		
		.ownerNav {
		  margin: 30px;
		  float: left;
		  position: sticky;
		  border: solid;
		  border-color: LightSeaGreen;
		}
		
		#infoForm {
		}
		
		#updateForm {
		}
		
	</style>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">

/* $("#btn_update").on("click", function(){
	if (confirm("회원정보를 수정하시겠습니까?")) {
		if ($('#txt_checkpw').text() != "비밀번호가 일치합니다") {
		}else{
			location.href=""
			
		}
	}	
}); */

/* 수정 전 제약사항 */
function checkpw() {
	/* 비밀번호 제대로 입력했을 때 */
	if (($('#txt_checkpw').text() == "비밀번호가 일치합니다")) {
		alert("회원정보를 수정합니다");
		return true
	}else{
		/* 비밀번호 다르게 입력했을 때 */
		alert("필수정보를 정확히 입력해주세요");
		return false
	}
}

$(function(){
	
	/* 탈퇴하기 */
	$("#btn_drop_member").on("click", function(){
		if (confirm("정말로 탈퇴하시겠습니까?")) {
 			var password = prompt('개인정보 확인을 위해 \n비밀번호를 한 번 더 입력해주세요','');
 			
	 			if (password eq ${"#pwd_checkpw1"}) {
					alert("그동안 단골의 희열 서비스를 \n이용해주셔서 감사합니다");
					location.href="deleteOwner.do";	
				}else{
					
				}
		}
	});
	
	$("#pwd_checkpw2").blur(function(){
		if (($('#pwd_checkpw1').val())==($('#pwd_checkpw2').val())) {
			$('#txt_checkpw').text("비밀번호가 일치합니다");
		}
		else{
			$('#txt_checkpw').text("비밀번호가 일치하지 않습니다");
		}
	});

/* 	
 * 비밀번호가 일치하지 않습니다. 사용가능한 비밀번호입니다.
 $("#checkpw").on("blur",function(){
		alert("hello");
	}); */
});
</script>

</head>

<body>
	<jsp:include page="/jsp/header.jsp"/>
	

<!-- 사장님 메뉴바-->
<div class="main">
	<div class="nav">
		<ul class="nav nav-pills nav-stacked">
			<li class="navTitle"><a class="navTitle" href="ownerInfoForm.do">사장님 페이지</a></li>
			<li class="active"><a class="nav" href="ownerInfoForm.do">내 정보<span class="sr-only">(current)</span></a></li>
			<li class="nav"><a class="nav" href="ownerStore.do">내 가게</a></li>
			<li class="nav"><a class="nav" href="selectDetailsBySnum.do">예약현황</a></li>
		</ul>
	</div>
</div>

<div id="div_title">
	<h1>사장님 페이지입니다.</h1>
</div>

<!-- 내정보 창 -->
<div id="div_ownerInfo">
	<form id="form_update_owner" action="updateOwner.do" onsubmit="return checkpw();">
	<table id="tbl_updateForm">
		<tr>
			<td>아이디</td>
			<td><input type="text" name="bid" value="${boss.bid}" readonly="readonly"></td>
		</tr>
		<tr>
			<td>* 비밀번호</td>
			<td><input id="pwd_checkpw1" name="bpw" value="${boss.bpw}" type="password"></td>
		</tr>
		<tr>
			<td>* 비밀번호 확인</td>
			<td><input id="pwd_checkpw2" value="${boss.bpw}" type="password"></td>
		</tr>
		<tr>
			<td></td>
			<td id="txt_checkpw"></td>
		</tr>
		<tr>
			<td>전화번호</td>
			<td><input type="text" name="bphone" value="${boss.bphone}"></td>
		</tr>
		<tr>
			<td>가게 현황</td>
			<td>
				<nav>
				<!-- 등록된 가게가 없을 때 -->
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
				</nav>
			</td>
		</tr>
		<tr>
			<td><input id="btn_update" type="submit" value="수정하기"></td>
			<td><input id="btn_drop_member" type="button" value="탈퇴하기"></td>
		</tr>
	</table>
	<p class="text">*표시는 필수 입력 사항입니다.</p>
	</form>
</div>
</body>
</html>