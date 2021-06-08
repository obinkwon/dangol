<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입_사용자</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/template.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	.tagText {
		text-align: center;
		height: 10px;
		font-weight: bold;
		font-size: 15px;
	}
	.cancelImg {
		width: 100%;
		height: 100%;
	}
	.delBtn {
		padding: 0px;
		width: 30px;
		height: 30px;
		border: 0px;
		background-color: white;
		outline: 0;
	}
	img.memberImg {
		display : block;
		margin : auto;
		margin-top: 20px;
		width: 120px;
		height: 120px;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	//비밀번호 확인
	$('#pwdCheck').blur(function(){
		if(($('#pwd').val()!="")){
			if(($('#pwd').val())==($('#pwdCheck').val())){
		  		$('#isPwdSame').text("비밀번호가 일치합니다");
		  		$('#isPwdSame').css({"color" : "green"});
			}
			else{
				$('#isPwdSame').text("비밀번호가 일치하지 않습니다");
		  		$('#isPwdSame').css({"color" : "red"});
			}
		}else{
			$('#isPwdSame').text("비밀번호를 입력해주세요");
	  		$('#isPwdSame').css({"color" : "red"});
		}
	});
});
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mid").on("keyup",function(){//id 특수문자 제외
			 re = /[~!@\#$%^&*\()\-=+_' ]/gi; 
			 var temp = $("#mid").val();
			 if(re.test(temp)){ //특수문자가 포함되면 삭제하여 값으로 다시셋팅
			 	$("#mid").val(temp.replace(re,"")); 
			 } 
		});
		
		$("#pwd").on("keyup",function(){//pw 공백 제외
			 re = /[ ]/gi;
			 var temp = $("#pwd").val();
			 if(re.test(temp)){ //특수문자가 포함되면 삭제하여 값으로 다시셋팅
			 	$("#pwd").val(temp.replace(re,"")); 
			 } 
		});
		
		$("#pwdCheck").on("keyup",function(){//pwCheck 공백 제외
			 re = /[ ]/gi; 
			 var temp = $("#pwdCheck").val();
			 if(re.test(temp)){ //특수문자가 포함되면 삭제하여 값으로 다시셋팅
			 	$("#pwdCheck").val(temp.replace(re,"")); 
			 } 
		});

	});
</script>
<script type="text/javascript">
	var sel_files = [];
	
	$(document).ready(function(){
		$("#file").on("change",SelectImg);
	});
	function SelectImg(e){//이미지 미리보기
		var files=e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			sel_file = f;
			var reader = new FileReader();
			reader.onload = function(e){
				$("#img").attr("src",e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	function goPopup(){
		// 주소검색을 수행할 팝업 페이지를 호출합니다.
		var pop = window.open("jusoPopup.do?index=0","pop","width=570,height=420, scrollbars=yes, resizable=yes,left=400,top=300");
	}
	function prefer1(){
		var pop = window.open("jusoPopup.do?index=1","pop","width=570,height=420, scrollbars=yes, resizable=yes,left=400,top=300");
	}
	function prefer2(){
		var pop = window.open("jusoPopup.do?index=2","pop","width=570,height=420, scrollbars=yes, resizable=yes,left=400,top=300");
	}

	function jusoCallBack(roadAddrPart1,addrDetail,index){ 
		console.log(roadAddrPart1 + "," + addrDetail + "," +index);
		switch (index) {
		case "0":
			document.getElementById("useraddr").value = roadAddrPart1;    
			document.getElementById("useraddrDetail").value = addrDetail;    
			break;
		case "1":
			document.getElementById("preferaddr").value = roadAddrPart1;    
			break;
		case "2":
			document.getElementById("preferaddr2").value = roadAddrPart1;    
			break;
		}
	}
	
	function idCheck(){ //id 체크
		var mid = $('#mid').val();
		if(mid == ''){
			alert('id를 입력해주세요');			
		}else{
			$.ajax({
				url : "checkIdMember.do",
				data : {
					mid : mid
				},
				type : "get",
				success : function(data) {
					if (data) {
						$('#canId').text("사용가능한 id 입니다");
						$('#canId').css({"color" : "green"});
						$('#mid').attr('readonly','readonly');
					} else {
						$('#canId').text("중복된 id 입니다.");
						$('#canId').css({"color" : "red"});
					}
				}
			});
		}
	}
	
	function addMember(){ //회원가입
		if(formCheck()){
			if(confirm('가입 하시겠습니까?')){
				$('#signUp').submit();
			}
		}
	}
	
	function addTag(){ //태그 추가
		var tagVal = $('#ttag').val();
		var checkVal = $('#themeTag_'+tagVal).length;
		var tagStatus = $('#ttag option:checked').prop('disabled');
		if(checkVal){
			alert('중복된 태그 입니다. 다시 선택해주세요');
		}else{
			var tagText = $('#ttag option:checked').text();
			var tagList = $('#themeTag').text();
			var deleteBtn = '<span style="margin-left:20px;" id="themeTag_'+tagVal+'">';
			deleteBtn += '<input type="hidden" name="mtag" value="'+tagVal+'">'+tagText;
			deleteBtn += '<button class="delBtn" type="button" onClick="delTag('+tagVal+')"><img class="cancelImg" src="/jsp/cancel.png"></button>';
			deleteBtn += '</span>';
			$('#tagDiv').append(deleteBtn);
		}
	}
	
	function delTag(val){ //태그 삭제
		$('#themeTag_'+val).remove();
	}
	
	function formCheck(){ //폼 체크
		if($('#mid').val() == ''){
			alert('아이디를 입력해주세요.');
			$('#mid').focus();
			return false;
		}else if($('#canId').text() != '사용가능한 id 입니다'){
			alert('중복된 아이디입니다.');
			$('#mid').focus();
			return false;
		}else if($('#pwd').val() == ''){
			alert("비밀번호를 입력해주세요.");
			$('#pwd').focus();
			return false;
		}else if($('#pwdCheck').val() == ''){
			alert("비밀번호 확인을 입력해주세요.");
			$('#pwdCheck').focus();
			return false;
		}else if($('#pwd').val() != $('#pwdCheck').val()){
			alert("비밀번호가 일치하지 않습니다.");
			$('#pwdCheck').focus();
			return false;
		}else if($('#mphone').val() == ''){
			alert("전화번호를 입력해주세요.");
			$('#mphone').focus();
			return false;
		}else if($('#address').val() == ''){
			alert("주소를 입력해주세요.");
			$('#address').focus();
			return false;
		}else{
			return true;
		}
	}
</script>
</head>
<body>
<jsp:include page="header.jsp" />
	<div class="main">
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">일반 가입</h2>
			</div>
			<form action="signUp.do" id="signUp" enctype="multipart/form-data" method="post">
				<table class="signForm">
					<colgroup>
						<col width="30%">
						<col width="*">
						<col width="30%">
					</colgroup>
					<tbody>
						<tr>
							<td><span style="color:red">* </span>아이디</td>
							<td>
								<input type="text" class="inputText w300" id="mid" name="mid" maxlength="10" placeholder="특수문자 없이 10자이내" onKeyup="this.value=this.value.replace(/^[A-Za-z0-9]$/,'');">
							</td>
							<td>
								<button class="btn-view btn-mint" type="button" onclick="idCheck()" style="width:100px;">중복확인</button>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">
								<div id="canId"></div>
							</td>
						</tr>
						<tr>
							<td><span style="color:red">* </span>비밀번호</td>
							<td colspan="2"><input type="password" class="inputText w300" id="pwd" name="mpw" maxlength="13" placeholder="공백없이 13자이내" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
						</tr>
						<tr>
							<td><span style="color:red">* </span>비밀번호 확인</td>
							<td colspan="2"><input type="password"  class="inputText w300" id="pwdCheck" maxlength="13" placeholder="공백없이 13자이내"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td id="isPwdSame" colspan="2"></td>
						</tr>
						<tr>
							<td><span style="color:red">* </span>전화번호</td>
							<td colspan="2">
								<input type="text" placeholder="(-)제외  11자리이내" maxlength="11" id="mphone"  class="inputText w300" name="mphone" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
							</td>
						<tr>
							<td><span style="color:red">* </span>주소</td>
							<td>
								<input type="text" id="useraddr" name="maddress" class="inputText w300" required="required" readonly="readonly">
							</td>
							<td>
								<button type="button" class="btn-view btn-mint" onclick="goPopup()" style="width:100px;">주소검색</button>
							</td>
						</tr>
						<tr>
							<td>상세주소</td>
							<td colspan="2"><input type="text" id="useraddrDetail" name="maddress_d" class="inputText w300"></td>
						</tr>
						<tr>
							<td><span style="color:red">* </span>성별</td>
							<td colspan="2">
								<div class="formArea">
									<ul>
										<li>
											<input class="inputRadio" type="radio" name="mgender" id="mgender-m" value="m" checked>
											<label for="mgender-m">남</label>
										</li>
										<li>
											<input class="inputRadio" type="radio" name="mgender" id="mgender-f" value="f">
											<label for="mgender-f">여</label>
										</li>
									</ul>
								</div>
							</td>
						</tr>
						<tr>
							<td>직업</td>
							<td colspan="2"><input type="text" name="mjob" class="inputText w300" id="mjob"></td>
						</tr>
						<tr>
							<td>선호지역</td>
							<td>
								<input type="text" id="preferaddr" name="marea1" class="inputText w300" readonly="readonly">
							</td>
							<td>
								<button type="button" class="btn-view btn-mint" onclick="prefer1()" style="width:100px;">주소검색</button>
							</td> 
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td>
								<input type="text" id="preferaddr2" name="marea2" class="inputText w300" readonly="readonly">
							</td>
							<td>
								<button type="button" class="btn-view btn-mint" onclick="prefer2()" style="width:100px;">주소검색</button>
							</td>
						</tr>
						<tr>
							<td>해시태그</td>
							<td>
								<select id="ttag" class="inputText w300">
								<c:forEach var="themeTag" items="${themeList}">
									<option value="${themeTag.anum}">#${themeTag.avalue}</option>
								</c:forEach>
								<c:if test="${empty themeList}">
									<option selected disabled>태그 없음</option>
								</c:if>
								</select>
							</td> 
							<td>
								<button class="btn-view btn-mint" type="button" onclick="addTag()" style="width:100px;">추가</button>
							</td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">
								<div id="tagDiv"></div>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<p class="tagText">해시태그는 회원별 추천에 사용됩니다.</p>
								<p class="tagText">※태그최대 등록 갯수: 3개</p>
							</td>
						</tr>
						<tr>
							<td colspan="3">
								<img id="img" class="memberImg" src="myPage.png">
							</td>
						</tr>
						<tr>
							<td>회원이미지</td>
							<td colspan="2"><input id="file" type="file" name="mfile"></td>
						</tr>
					</tbody>
				</table>
				<div class="contentsTitGroup">
					<h4 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);"><span style="color:red">* </span>표시는 필수 입력 사항입니다.</h4>
				</div>
				<div class="btn-wrap">
					<button class="btn-view btn-mint" onclick="addMember()" type="button">가입하기</button>
				</div>
			</form>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>