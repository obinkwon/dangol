<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사장님_회원가입</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.main {
		margin : auto;
		margin-top: 50px;
		margin-bottom:100px;
		width: 100%;
	}
	table.signForm {	
		margin : auto;		
		font-size: 15px;
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
	.w300{
		width: 300px;
	}

</style>

<script type="text/javascript">
 $(document).ready(function(){
	//비밀번호 확인
	 $('#pwdCheck').blur(function(){
		if(($('#pwd').val()!="")){
			if(($('#pwd').val())==($('#pwdCheck').val())){
				$('#isPwdSame').text('비밀번호가 일치합니다');
				$('#isPwdSame').css({'color' : 'green'});
			}else{
				$('#isPwdSame').text('비밀번호가 일치하지 않습니다');
		  		$('#isPwdSame').css({'color' : 'red'});
			}
		}else{
			$('#isPwdSame').text("비밀번호를 입력해주세요");
	  		$('#isPwdSame').css({"color" : "red"});
		}
	});
}); 

</script>
<script type="text/javascript">
	function idCheck(){ //id 체크
		var bid = $('#bid').val();
		if(bid == ''){
			alert('id를 입력해주세요');			
		}else{
			$.ajax({
				url : 'checkId.do',
				data : {
					id : bid
				},
				type : 'get',
				success : function(data) {
					if (data) {
						$('#canId').text('사용가능한 id 입니다');
						$('#canId').css({"color" : "green"});
					} else {
						$('#canId').text('중복된 id 입니다.');
						$('#canId').css({"color" : "red"});
					}
				}
			});
		}
	}
	
	function addBoss(){ //회원가입
		if(formCheck()){
			if(confirm('가입 하시겠습니까?')){
				$('#signUp').submit();
			}
		}
	}
	
	function formCheck(){ //폼 체크
		if(($('#isPwdSame').text() != '비밀번호가 일치합니다') 
				|| ($('#canId').text() != '사용가능한 id 입니다') 
				|| ($('#bphone').val() == '')){
			
			alert('필수항목을 다시 입력해주세요');
			return false;
		}
	
		return true;
	}
</script>
</head>
<body>
<jsp:include page="header.jsp" />
	<div class="main">
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">가맹점주 가입</h2>
			</div>
			<form action="insertBoss.do" id="signUp" method="post">
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
								<input type="text" class="inputText w300" id="bid" name="bid" maxlength="10" placeholder="특수문자 없이 10자이내">
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
							<td colspan="2"><input type="password" class="inputText w300" id="pwd" name="bpw" maxlength="13" placeholder="공백없이 13자이내" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
						</tr>
						<tr>
							<td><span style="color:red">* </span>비밀번호 확인</td>
							<td colspan="2"><input type="password"  class="inputText w300" id="pwdCheck" maxlength="13" placeholder="공백없이 13자이내" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td id="isPwdSame" colspan="2"></td>
						</tr>
						<tr>
							<td><span style="color:red">* </span>전화번호</td>
							<td>
								<input type="text" placeholder="(-)제외  11자리이내" maxlength="11" id="bphone"  class="inputText w300" name="bphone" onKeyup="this.value=this.value.replace(/[^0-9]/g,'');">
							</td>
							<td id="phoneCheck"></td>
						<tr>
					</tbody>
				</table>
				<div class="contentsTitGroup">
					<h4 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);"><span style="color:red">* </span>표시는 필수 입력 사항입니다.</h4>
				</div>
				<div class="btn-wrap">
					<button class="btn-view btn-mint" onclick="addBoss()" type="button">가입하기</button>
				</div>
			</form> 
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>