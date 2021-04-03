<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.main {
		margin : auto;
		margin-top: 50px;
		margin-bottom:100px;
		width: 100%;
	}
	.modifyFormTitle {
		text-align : center;
		margin-top: 20px;
		margin-bottom: 20px;
		font-size: 24px;
		font-weight: bold;
	}
	table.modifyFormList {
		margin : auto;
		font-size: 15px;
	}
	table.modifyFormList td {
		padding : 10px;
		height: 30px;
	}
	select {
		padding: 5px;
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
	div.modifyFormContent {
		border: 1px solid #dedede;
		margin : auto;
		width: 30%;
	}
	.inputText {
		width: 210px;
		height : 28px; 
	}
	#isPwdSame {
		color: #ff0000;
	}
	.inputRadio {
		margin-top: 10px;
		height: 20px;
	}
	#addTag, .addressBtn{
		background-color: #66ccff;
		color: white;
		text-align: center;
		text-decoration: none;
		font-size: 13px;
		border: none;
		cursor: pointer;
		width: 100px;
		height: 28px;
	}
	.addTag {
		border: none;
	}
	p.tagtext, p.text {
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
	.addImg {
		margin-top: 10px;
	}
	#addLine td{
		padding: 0px;
	}
	.actionBtn {
		display : block;
		text-align: center;
		margin : auto;
		margin-top: 25px;
		margin-bottom : 30px;
		background-color: #66ccff;
		border: none;
		color: white;
		width: 300px;
		height: 45px;
		text-decoration: none;
		font-size: 18px;
		cursor: pointer;
	}
</style>
<script type="text/javascript">
$(document).ready(function(){
	$('#pwdCheck').blur(function(){
		if(($('#pwd').val()!="")){
			if(($('#pwd').val())==($('#pwdCheck').val())){
		  		$('#isPwdSame').text("비밀번호가 일치합니다");
			}else{
				$('#isPwdSame').text("비밀번호가 일치하지 않습니다");
			}
		}
	});
	//회원정보수정 버튼 누를 때 제한 할 사항들
	$('#modifyBtn').click(function(){
		if(($('#pwd').val()!="") 
			&& ($('#isPwdSame').text() =="비밀번호가 일치합니다")
			&& ($('#mphone').val()!="")
			&&($('#address').val()!="")){
						
		}else{
			$('form#modify').attr("action","");
			alert("필수항목을 입력해주세요.");
		}
	});
			 
 	//태그 제한
  	var tag1 =$('#addLine').find('tr:eq(0)').find('td').find('input').val();
  	var tag2 =$('#addLine').find('tr:eq(1)').find('td').find('input').val();
  	var tag3 =$('#addLine').find('tr:eq(2)').find('td').find('input').val();
	//	alert(tag1);
	//	alert(tag2);
	//	alert(tag3);
	$("#tag option[value='"+tag1+"']").remove();	
	$("#tag option[value='"+tag2+"']").remove();	
	$("#tag option[value='"+tag3+"']").remove();	
			
  	var count=$('#addLine tr').length;
	if(count<3){
		$('#addTag').attr('disabled',false);
	}else {
		$('#addTag').attr('disabled',true);					
	}	
	
	$('#addTag').click(function(){
		var tag = $('#tag').val();
		if(tag!=null){ //처음 값 append 막기
			var msg = '';
			msg += '<tr>';
			msg += '<td>';
			msg += '#<input type="text" name="tag" class="addTag" value="'+tag+'" readonly="readonly">';
			msg += '</td>';
			msg += '</tr>';
			msg += '<td>';
			msg += '<button class="delBtn">';
			msg += '<img class="cancelImg" src="jsp/cancel.png">';
			msg += '</button>';
			msg += '</td>';
			msg += '</tr>';
			$('#addLine').append(msg);
			
			var selectTag=	$("#tag option:selected");
			selectTag.remove();
			$('#tag option:eq(0)').prop("selected", true); //select 초기값 설정
			var count=$('#addLine tr').length;
			if(count<3){
				$('#addTag').attr('disabled',false);
			}else {
				$('#addTag').attr('disabled',true);					
			}	
			
			//태그삭제
			$('.delBtn').click(function(){
				$(this).closest('tr').remove();
				var s = $(this).closest('tr').find('td').find('input').val();
				$('#tag').append('<option value="'+s+'">#'+s+'</option>');
				var count=$('#addLine tr').length;
			 	if(count<3){
					$('#addTag').attr('disabled',false);
				}else{
					$('#addTag').attr('disabled',true);
				}  
			});
		}
	});
	
	//태그삭제
	$('.delBtn').click(function(){
		$(this).closest('tr').remove();
		var s = $(this).closest('tr').find('td').find('input').val();
		$('#tag').append('<option value="'+s+'">#'+s+'</option>');
		var count=$('#addLine tr').length;
		if(count<3){
			$('#addTag').attr('disabled',false);
		}else{
			$('#addTag').attr('disabled',true);
		}  
	});
					
	//회원 탈퇴
	$('#deleteBtn').click(function() { 
		var result = confirm('정말로 탈퇴하시겠습니까?');
		if(result) { 
			location.replace('removeMember.do');
		}
	});
}); 

</script>
<script type="text/javascript">
	var sel_files = [];
	
	$(document).ready(function(){
		$("#file").on("change",SelectImg);
	});
	function SelectImg(e){
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

		<div class="modifyFormContent">
			<form action="modifyMember.do" enctype="multipart/form-data"
				method="post" id="modify">
				<p class="modifyFormTitle">(${mid})님의 회원정보</p>
				<table class="modifyFormList">
					<tr>
						<td><span style="color:red">* </span>아이디</td>
						<td colspan="2">
							<input type="text" class="inputText" id="mid" name="mid" value="${mid}" readonly="readonly">
						</td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>비밀번호</td>
						<td colspan="2">
							<input type="password" class="inputText" id="pwd" name="mpw">
						</td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>비밀번호 확인</td>
						<td colspan="2"><input type="password" class="inputText" id="pwdCheck"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td id="isPwdSame" class="inputText" colspan="2"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>전화번호</td>
						<td colspan="2">
							<input type="text" class="inputText" placeholder="(-)제외  11자리를 입력하세요" maxlength="11" id="mphone" name="mphone" value="${Member.mphone}">
						</td>
					<tr>
						<td><span style="color:red">* </span>주소</td>
						<td>
							<input type="text" id="useraddr" value="${Member.maddress}" name="maddress" class="inputText" required="required" readonly="readonly">
						</td>
						<td>
							<button type="button" class="addressBtn" onclick="goPopup()">주소검색</button>
						</td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td colspan="2"><input type="text" id="useraddrDetail" value="${Member.maddress_d}" name="maddress" class="inputText"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>성별</td>
						<td colspan="2">
						<c:choose>
							<c:when test="${Member.mgender == 'm'}">
								<input type="radio" class="inputRadio" name="mgender" checked="checked" value="m">남  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" class="inputRadio" name=mgender value="f">여
							</c:when>
							<c:otherwise>
								<input type="radio" class="inputRadio" name="mgender" value="m">남 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								<input type="radio" class="inputRadio" name="mgender" checked="checked" value="f"> 여
							</c:otherwise>
						</c:choose>
						</td>
					</tr>
					<tr>
						<td>직업</td>
						<td colspan="2"><input type="text" class="inputText" name="mjob" id="mjob" value="${Member.mjob}"></td>
					</tr>
					<tr>
						<td>선호지역</td>
						<td>
							<input type="text" id="preferaddr" value="${Member.marea1}" name="marea1" class="inputText" readonly="readonly">
						</td>
						<td>
							<button type="button" class="addressBtn" onclick="prefer1()">주소검색</button>
						</td> 
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td>
							<input type="text" id="preferaddr2" value="${Member.marea2}" name="marea2" class="inputText" readonly="readonly">
						</td>
						<td>
							<button type="button" class="addressBtn" onclick="prefer2()">주소검색</button>
						</td>
					</tr>
					<tr>
						<td>해시태그</td>
						<td>
							<select id="tag" class="Tag">
							<c:if test="${!empty themeList}">
								<option id="click" selected disabled>#해시태그</option>
								<c:forEach var="themeList" items="${themeList}">
									<option id="taglist" value="${themeList.avalue}">#${themeList.avalue}</option>
								</c:forEach>
							</c:if>
							<c:if test="${empty themeList}">
								<option id="click" selected disabled>태그 없음</option>
							</c:if>
							</select>
						</td>
						<td><input type="button" id="addTag" value="추가"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td colspan="2">
							<table id="addLine">
							<c:forEach var="mtag" items="${mtagList}">
								<tr>
									<td>#
										<input type="text" name="mtag" class="addTag" value="${mtag.avalue}" readonly="readonly">
									</td>
									<td>
										<button class="delBtn"><img class="cancelImg" src="jsp/cancel.png" ></button>
									</td>
								</tr>
							</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<p class="tagtext">해시태그는 회원별 추천에 사용됩니다.</p>
							<p class="tagtext">※태그최대 등록 갯수: 3개</p>
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<c:choose>
								<c:when test="${Member.mimage!=null}">
									<img id="img" class="memberImg" src="downloadMImage.do?mid=${mid}">
								</c:when>
								<c:otherwise>
									<img id="img" class="memberImg" src="myPage.png">
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<td>회원이미지</td>
						<td colspan="2"><input id="file" type="file" name="mfile" class="addImg"></td>
					</tr>
					<tr>
						<td colspan="3"><p class="text">*표시는 필수 입력 사항입니다.</p></td>
					</tr>
					<tr>
						<td colspan="3">
							<input style="margin-bottom: 0px;" type="submit" class="actionBtn" id="modifyBtn" value="수정하기"> 
						</td>
					</tr>
					<tr>
						<td colspan="3">
							<input style="margin-top: 0px;" type="button" class="actionBtn" id="deleteBtn" value="탈퇴하기">
						</td>
					</tr>
				</table>
				
			</form>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp" />
</body>
</html> 