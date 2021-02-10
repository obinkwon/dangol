<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	div.main {
		height: 500px;
		margin : auto;
		text-align : center;
	}
	p.findIdPwTitle {
		position: relative;
		margin-left: 25%;
		margin-top: 30px;
		margin-bottom: 30px;
		line-height: 2em;
		font-size: 32px
	}
	div.findTop {
		position: relative;
		margin-top: 50px;
		height : 100px;
	}
	div.findBottom {
		display : inline;
		height : 100px;
	}
	p.findIdTitle {
		position: relative;
		display: inline;
		float: left;
		font-size: 25px;
		margin-left: 25%;
	}
	p.findPwTitle {
		position: relative;
		font-size: 25px;
		float: left;
		margin-left: 25%;
	}
	table.findId {
		margin-left: 25%;
		float : left;
	}
	table.findPw {
		margin-left: 15%;
		float : left;
	}
	td.right {
		padding-right: 20px;
		padding-bottom: 20px;
	}
	.Btn {
		position: relative;
		margin-left: 20px;
		margin-top: 30px;
		background-color: #66ccff;
		border: none;
		color: white;
		width: 250px;
		height: 40px;
		text-align: center;
		text-decoration: none;
		display: inline-block;
		font-size: 18px;
		cursor: pointer;
	}
	.user {
		position: relative;
		margin-left: 25%;
		margin-bottom: 50px;
		font-size: 18px;
	}
	td.radioRright {
		position: relative;
		padding-right: 50px;
	}
	#phone,#phonePw{
		width:195px;
		height:28px;
		font-size:12px;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
	function open_win(url,name){
		window.open(url,name,'width=450,height=250');
	}
	
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#findIdBtn").attr("disabled", true);
		$('#phone').bind("click",function(){
			$("#findIdBtn").attr("disabled", false);
		$("#findIdBtn").click(function(){
			var hp = $('#phone').val();
			hp = hp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	 	 	$.ajax({
				url : "findId.do",
				data: {
					loginUser: $(":input:radio[name=loginUser]:checked").val(),
					phone:hp
				},
				type :"get",
				success : function(data){
					if(data[0]==null){
	 				
	 					alert("회원정보가 일치하는 아이디가 없습니다.");
	 				}
	 				else {
	 					var result = "";
	 					for (var i = 0; i < data.length; i++) {
							result = result+"회원님의 아이디는 ["+ data[i]+"] 입니다.\n"
						}
	 					alert(result);
	 				} 
				},error : function(request,status,error){
					alert(request.status);
					alert(request.responseText);
					alert(error);
					
				}  
			}); 
		});
		});
	$("#findPwBtn").attr("disabled", true);
	$('#id').bind("click",function(){
		$("#findPwBtn").attr("disabled", false);
		$("#findPwBtn").click(function(){
			var hp = $('#phonePw').val();
			hp = hp.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
	 	 	$.ajax({
	 	 		url:"findPw.do",
				data: {
					loginUser: $(":input:radio[name=loginUser]:checked").val(),
					id:$('#id').val(),
					phone:hp
					},
					type :"get",
					success : function(data){
						if(data==""){
							alert("입력하신 정보와 일치하지 않습니다.");
		 				}
		 				else {
		 					alert("회원님의 비밀번호는 ["+data+"] 입니다.");
		 				} 
					},
				 	error : function(data){
					}  
				}); 
		}); 
	});	 
	}); 
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<br>
	<p class="findIdPwTitle">ID/PW 찾기</p>
	<table class="user">
		<tr>
			<td class="radioRright">
				<input type="radio" name="loginUser" value="user" checked="checked">사용자
			</td>
			<td>
				<input type="radio" name="loginUser" value="boss">사장님
			</td>
		</tr>
	</table>
	<div class="main">
		<div class="findTop">
			<p class="findIdTitle">ID찾기</p>
			<p class="findPwTitle">PW찾기</p>
		</div>
		<div class="findBottom">
			<table class="findId">
				<tr>
					<td class="right">전화번호</td>
					<td class="right">
						<input type="text" placeholder="(-)제외  13자리를 입력하세요" maxlength="13" id="phone" >
					</td>
				</tr>
				<tr>
					<td colspan="2" class="right">
						<input type="submit" value="찾기" class="Btn" id="findIdBtn">
					</td>
				</tr>
			</table>
			<table class="findPw">
				<tr>
					<td class="right">ID</td>
					<td class="right"><input type="text" name="id" id="id"></td>
				</tr>
				<tr>
					<td class="right">전화번호</td>
					<td class="right">
						<input type="text" placeholder="(-)제외  13자리를 입력하세요" maxlength="13" id="phonePw">
					</td>
				</tr>
				<tr>
					<td colspan="2"><input type="submit" value="찾기" class="Btn" id="findPwBtn"></td>
				</tr>
			</table>
		</div>
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>