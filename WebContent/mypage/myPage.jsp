<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="/css/template.css" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
$(document).ready(function(){
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
	var sel_files = [];
	
	$(document).ready(function(){
		$("#file").on("change",SelectImg);
	});
	function SelectImg(e){ //이미지 변경
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
	
	function goPopup(){// 주소
		var pop = window.open("jusoPopup.do?index=0","pop","width=570,height=420, scrollbars=yes, resizable=yes,left=400,top=300");
	}
	function prefer1(){// 선호지역1
		var pop = window.open("jusoPopup.do?index=1","pop","width=570,height=420, scrollbars=yes, resizable=yes,left=400,top=300");
	}
	function prefer2(){// 선호지역2
		var pop = window.open("jusoPopup.do?index=2","pop","width=570,height=420, scrollbars=yes, resizable=yes,left=400,top=300");
	}
	
	function jusoCallBack(roadAddrPart1,addrDetail,index){//주소 API 리턴
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
			deleteBtn += '<button class="delBtn" type="button" onClick="delTag('+tagVal+')"><img class="img30" src="/image/cancel.png"></button>';
			deleteBtn += '</span>';
			$('#tagDiv').append(deleteBtn);
		}
	}
	
	function delTag(val){ //태그 삭제
		$('#themeTag_'+val).remove();
	}
	
	function modMember(){//회원 수정
		if(($('#pwd').val()!="") 
			&& ($('#isPwdSame').text() =="비밀번호가 일치합니다")
			&& ($('#mphone').val()!="")
			&&($('#address').val()!="")){
						
			$('#modify').attr("action","modifyMember.do");
			$('#modify').submit();
		}else{
			$('#modify').attr("action","");
			alert("필수항목을 입력해주세요.");
		}
	}
	
	function delMember(){//회원 탈퇴
		var result = confirm('정말로 탈퇴하시겠습니까?');
		if(result) { 
			$('#modify').attr('action','removeMember.do');
			$('#modify').submit();
		}
	}
</script>
</head>
<body>
<jsp:include page="../jsp/header.jsp" />
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">마이페이지</a></li>
				<li class="active"><a class="nav" href="myPage.do">회원정보</a></li>
				<li class="nav"><a class="nav" href="bookmark.do">즐겨찾기</a></li>
				<li class="nav"><a class="nav" href="historyList.do">방문내역</a></li>
				<li class="nav"><a class="nav" href="reserveState.do">예약현황</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">회원정보</h2>
			</div>
			<form action="modifyMember.do" enctype="multipart/form-data" method="post" id="modify">
				<input type="hidden" name="mtype" value="user">
				<table class="signForm">
					<colgroup>
						<col width="30%">
						<col width="*">
						<col width="30%">
					</colgroup>
					<tbody>
					<tr>
						<td><span style="color:red">* </span>아이디</td>
						<td colspan="2">
							<input type="text" class="inputText w300" id="mid" name="mid" value="${mid}" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>비밀번호</td>
						<td colspan="2"><input type="password" class="inputText w300" id="pwd" name="mpw" value="${Member.mpw}" maxlength="13" placeholder="공백없이 13자이내" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>비밀번호 확인</td>
						<td colspan="2"><input type="password" class="inputText w300" id="pwdCheck" maxlength="13" placeholder="공백없이 13자이내"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td id="isPwdSame" colspan="2"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>전화번호</td>
						<td colspan="2">
							<input type="text" class="inputText w300" placeholder="(-)제외  11자리이내" maxlength="11" id="mphone" name="mphone" value="${Member.mphone}" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
						</td>
					<tr>
						<td><span style="color:red">* </span>주소</td>
						<td>
							<input type="text" id="useraddr" value="${Member.maddress}" name="maddress" class="inputText w300" required="required" readonly="readonly">
						</td>
						<td>
							<button type="button" class="btn-view btn-mint" onclick="goPopup()" style="width:100px;">주소검색</button>
						</td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td colspan="2"><input type="text" id="useraddrDetail" value="${Member.maddress_d}" name="maddress_d" class="inputText w300"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>성별</td>
						<td colspan="2">
							<div class="formArea">
								<ul>
									<li>
										<input class="inputRadio" type="radio" name="mgender" id="mgender-m" value="m" <c:if test="${Member.mgender == 'm'}">checked</c:if>>
										<label for="mgender-m">남</label>
									</li>
									<li>
										<input class="inputRadio" type="radio" name="mgender" id="mgender-f" value="f" <c:if test="${Member.mgender != 'm'}">checked</c:if>>
										<label for="mgender-f">여</label>
									</li>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<td>직업</td>
						<td colspan="2"><input type="text" class="inputText w300" name="mjob" id="mjob" value="${Member.mjob}"></td>
					</tr>
					<tr>
						<td>선호지역</td>
						<td>
							<input type="text" id="preferaddr" value="${Member.marea1}" name="marea1" class="inputText w300" readonly="readonly">
						</td>
						<td>
							<button type="button" class="btn-view btn-mint" onclick="prefer1()" style="width:100px;">주소검색</button>
						</td> 
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>
							<input type="text" id="preferaddr2" value="${Member.marea2}" name="marea2" class="inputText w300" readonly="readonly">
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
							<div id="tagDiv">
								<c:forEach var="mtag" items="${mtagList}">
								<span style="margin-left:20px;" id="themeTag_${mtag.anum}">
									<input type="hidden" name="mtag" value="${mtag.anum}">#${mtag.avalue}
									<button class="delBtn" type="button" onClick="delTag('${mtag.anum}')"><img class="img30" src="/image/cancel.png" ></button>
								</span>
								</c:forEach>
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<span class="storeSpan">해시태그는 회원별 추천에 사용됩니다.</span><br/>
							<span class="storeSpan">※태그최대 등록 갯수: 3개</span>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<div class="btn-wrap">
								<c:if test="${Member.mimage ne null}"><img id="img" class="img120" src="downloadMImage.do?mid=${mid}"></c:if>
								<c:if test="${Member.mimage eq null}"><img id="img" class="img120" src="/image/myPage.png"></c:if>
							</div>
						</td>
					</tr>
					<tr>
						<td>회원이미지</td>
						<td colspan="2">
							<input id="file" type="file" name="mfile">
							<input type="hidden" name="mimage" value="${Member.mimage}">
						</td>
					</tr>
					</tbody>
				</table>
				<div class="contentsTitGroup">
					<h4 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);"><span style="color:red">* </span>표시는 필수 입력 사항입니다.</h4>
				</div>
				<div class="btn-wrap">
					<button class="btn-view btn-mint" onclick="modMember()" type="button">수정하기</button>
					<button class="btn-view btn-mint" onclick="delMember()" type="button">탈퇴하기</button>
				</div>
			</form>
		</div>
	</div>
<jsp:include page="../jsp/footer.jsp" />
</body>
</html> 