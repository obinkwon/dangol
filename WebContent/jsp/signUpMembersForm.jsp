<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
		margin-bottom: 100px;
		width: 35%;
		border: 1px solid #dedede;
	}
	.signFormtitle {
		text-align: center;
		margin-top: 20px;
		margin-bottom: 20px;
		font-size: 24px;
		font-weight: bold;
	}
	table.signForm {	
		margin : auto;		
		font-size: 15px;
	}
	table.signForm td {
		padding : 10px;
		height: 30px;
	}
	select {
		padding: 5px;
	}
	.tagText {
		text-align: center;
		height: 10px;
		font-weight: bold;
		font-size: 15px;
	}
	.inputText {
		width: 210px;
		height : 28px; 
	}
	#overlap_check, #addTag, .addressBtn{
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
	#joinBtn {
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
	.addTag{
		border : none;
	}
	img.memberImg {
		display : block;
		margin : auto;
		margin-top: 20px;
		width: 120px;
		height: 120px;
	}
	#addLine td{
		padding: 0px;
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
	
	//회원가입 버튼 누를 때 제한 할 사항들
	$('#joinBtn').click(function(){
		if(($('#isPwdSame').text() =="비밀번호가 일치합니다") 
				&& ($('#canId').text()=="사용가능한 id 입니다") 
				&& ($('#mphone').val()!="") 
				&&($('#address').val()!="")) ;
		else{
			$('form#signUp').attr("action","");
			alert("필수항목을 입력해주세요.");
		}
	});
		
	//휴대폰번호 형식
	$('#mphone').blur(function(){
		var num=$('#mphone').val();
		if(num.length==11){
			$('#mphone').val(num);
			$('#phoneCheck').text("");
		}else{
			$('#mphone').val("");
			$('#phoneCheck').text("잘못된 번호 형식입니다.");
			$('#phoneCheck').css({"color" : "red"});
			$('#phoneCheck').css({"font-size" : "12px"});
		}
	})
			 
	//태그 추가
	$('#addTag').off("click").on("click",function(){
		var tag = $('#tag').val();
		if(tag!=null){ //처음 값 append 막기
			//table에 태그 append하기
			$('#addLine').append('<tr><td>#<input type="text" name="tag" class="addTag" value="'+tag
					+'" readonly="readonly"></td><td><button class="delBtn"><img class="cancelImg" src="jsp/cancel.png"></button></td></tr>');
			//추가한거 다시 추가 못하게 목록에서 제거하기
			$("select#tag option[value='"+tag+"']").remove();
			//select 초기값 설정 (#해시태그로)
			$('#tag option:eq(0)').prop("selected", true); 
			var count=$('#addLine tr').length;//테이블 tr 갯수
			if(count<3) $('#addTag').attr('disabled',false);//3개가 넘어가면 추가버튼 비활성화
			else $('#addTag').attr('disabled',true);					
		}else{
			alert('태그가 없습니다 관리자에게 문의해주세요');
		}
		//태그삭제
		$('.delBtn').off("click").on("click",function(){//동적추가후 클릭이벤트 중복 발생 제거
			$(this).closest('tr').remove();//삭제한 버튼에 해당하는 태그 삭제
			var s = $(this).closest('tr').find('td').find('input').val();
			count=$('#addLine tr').length;//테이블 tr 갯수
			if(count<3) $('#addTag').attr('disabled',false);//3개가 넘어가면 추가버튼 비활성화
			else $('#addTag').attr('disabled',true);
			
			$("select#tag").append("<option value='"+s+"'>"+"#"+s+"</option>");
		});
	});
})
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#mid").bind("keyup",function(){//id 특수문자 제외
			 re = /[~!@\#$%^&*\()\-=+_' ]/gi; 
			 var temp=$("#mid").val();
			 if(re.test(temp)){ //특수문자가 포함되면 삭제하여 값으로 다시셋팅
			 	$("#mid").val(temp.replace(re,"")); 
			 } 
		});
		
		$("#pwd").bind("keyup",function(){//pw 공백 제외
			 re = /[ ]/gi;
			 var temp=$("#pwd").val();
			 if(re.test(temp)){ //특수문자가 포함되면 삭제하여 값으로 다시셋팅
			 	$("#pwd").val(temp.replace(re,"")); 
			 } 
		});
		
		$("#pwdCheck").bind("keyup",function(){//pwCheck 공백 제외
			 re = /[ ]/gi; 
			 var temp=$("#pwdCheck").val();
			 if(re.test(temp)){ //특수문자가 포함되면 삭제하여 값으로 다시셋팅
			 	$("#pwdCheck").val(temp.replace(re,"")); 
			 } 
		});

		$("#mphone").on("keyup", function() {//전화번호 숫자만 입력받도록 
		    $(this).val($(this).val().replace(/[^0-9]/g,""));
		});

		$('#overlap_check').click(function() {
			$.ajax({
				url : "checkIdMember.do",
				data : {
					id : $('#mid').val()
				},
				type : "get",
				success : function(data) {
					if($('#mid').val()!= ""){
						if (data) {
							$('#canId').text("사용가능한 id 입니다");
							$('#canId').css({"color" : "green"});
						} else {
							$('#canId').text("중복된 id 입니다.");
							$('#canId').css({"color" : "red"});
							$('#mid').val("");
						}
					}else{
						$('#canId').text("id를 입력해주세요.");
						$('#canId').css({"color" : "red"});
					}
				}
			});
		});
	})
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
</script>
</head>
<body>
<jsp:include page="header.jsp" />
	<div class="main">
		<form action="signUp.do" id="signUp" enctype="multipart/form-data" method="post">
			<p class="signFormtitle">일반 가입</p>
			<table class="signForm">
				<tr>
					<td width="30%"><span style="color:red">* </span>아이디</td>
					<td>
						<input type="text" class="inputText" id="mid" name="mid" maxlength="10" placeholder="특수문자 없이 10자이내">
					</td>
					<td width="30%">
						<input type="button" value="중복확인" id="overlap_check">
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
					<td colspan="2"><input type="password" class="inputText" id="pwd" name="mpw" maxlength="13" placeholder="공백없이 13자이내"></td>
				</tr>
				<tr>
					<td><span style="color:red">* </span>비밀번호 확인</td>
					<td colspan="2"><input type="password"  class="inputText" id="pwdCheck" maxlength="13" placeholder="공백없이 13자이내"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td id="isPwdSame" colspan="2"></td>
				</tr>
				<tr>
					<td><span style="color:red">* </span>전화번호</td>
					<td>
						<input type="text" placeholder="(-)제외  11자리를 입력하세요" maxlength="11" id="mphone"  class="inputText" name="mphone">
					</td>
					<td id="phoneCheck"></td>
				<tr>
					<td><span style="color:red">* </span>주소</td>
					<td>
						<input type="text" id="useraddr" name="maddress" class="inputText" required="required" readonly="readonly">
					</td>
					<td>
						<button type="button" class="addressBtn" onclick="goPopup()">주소검색</button>
					</td>
				</tr>
				<tr>
					<td>상세주소</td>
					<td colspan="2"><input type="text" id="useraddrDetail" name="maddress_d" class="inputText"></td>
				</tr>
				<tr>
					<td><span style="color:red">* </span>성별</td>
					<td colspan="2">
						<input type="radio" name="mgender" checked="checked" value="m">남 &nbsp;&nbsp;&nbsp;&nbsp;
						 
						<input type="radio" name=mgender value="f">여
					</td>
				</tr>
				<tr>
					<td>직업</td>
					<td colspan="2"><input type="text" name="mjob" class="inputText" id="mjob"></td>
				</tr>
				<tr>
					<td>선호지역</td>
					<td>
						<input type="text" id="preferaddr" name="marea1" class="inputText" readonly="readonly">
					</td>
					<td>
						<button type="button" class="addressBtn" onclick="prefer1()">주소검색</button>
					</td> 
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<input type="text" id="preferaddr2" name="marea2" class="inputText" readonly="readonly">
					</td>
					<td>
						<button type="button" class="addressBtn" onclick="prefer2()">주소검색</button>
					</td>
				</tr>
				<tr>
					<td>해시태그</td>
					<td>
						<select id="tag">
						<c:if test="${!empty themeList}">
							<option id="click" selected disabled>#해시태그</option>
							<c:forEach var="themeList" items="${themeList}">
								<option value="${themeList.avalue}">#${themeList.avalue}</option>
							</c:forEach>
						</c:if>
						<c:if test="${empty themeList}">
							<option id="click" selected disabled>태그 없음</option>
						</c:if>
						</select>
					</td> 
					<td>
						<input type="button" id="addTag" value="추가">
					</td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td colspan="2">
						<table id="addLine">
						</table>
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
				<tr>
					<td colspan="3"><p class="tagText">*표시는 필수 입력 사항입니다.</p></td>
				</tr>
				<tr>
					<td colspan="3"><input type="submit" id="joinBtn" value="가입하기"></td>
				</tr>
			</table>
		</form>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>