<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<meta charset="UTF-8">
<title>ID/PW 찾기</title>
<style type="text/css">
	div.main {
		margin : auto;
		margin-top: 50px;
		margin-bottom:100px;
		width: 100%;
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
	.contentsTitGroup{
		padding-top: 2.0rem;
	    text-align: center;
	    display: block;
	}
	.w300{
		width: 300px;
	}
	.inputRadio{
	    margin: 0;
	    width: 15px;
	    height: 15px;
	    border: 0;
	    margin-right: 20px;
	}
	table.signForm {	
		margin : auto;		
		font-size: 15px;
	}
	table.signForm td {
		padding : 10px;
		height: 30px;
		text-align : center;
	}
	.btn-wrap {
		display: block;
		text-align: center;
	    width: 100%;
	    margin: 0 auto;
	    margin-bottom : 30px;
		padding-top: 4.5rem;
	}
</style>
<script type="text/javascript">
	function findId(){ //id 찾기
		var hp = $('#phone').val();
		hp = hp.replace(/[~!@\#$%^&*\()\-=+_' ]/gi,'');
		$.ajax({
			url : 'findId.do',
			data: {
				loginUser : $('input[name=loginUser]:checked').val(),
				phone : hp
			},
			type :'GET',
			success : function(data){
				if(data.length == 0){
 					alert('회원정보가 일치하는 아이디가 없습니다.');
 				}
 				else {
 					var result = '';
 					for (var i = 0; i < data.length; i++) {
						result = result+'회원님의 아이디는 ['+ data[i]+'] 입니다.\n';
					}
 					alert(result);
 				} 
			}
		}); 
	}
	
	function findPw(){ //비밀번호 찾기
		var hp = $('#phone').val();
		hp = hp.replace(/[~!@\#$%^&*\()\-=+_' ]/gi,'');
 	 	$.ajax({
 	 		url:'findPw.do',
			data: {
				loginUser : $('input[name=loginUser]:checked').val(),
				id : $('#id').val(),
				phone : hp
			},
			type :'GET',
			success : function(data){
				if(data == ''){
					alert('입력하신 정보와 일치하지 않습니다.');
 				}
 				else {
 					alert('회원님의 비밀번호는 ['+data+'] 입니다.');
 				} 
			},
		 	error : function(data){
			}  
		}); 
	}
</script>
</head>
<body>
<jsp:include page="header.jsp" />
	<div class="main">
		<div class="container">
			<div class="contentsTitGroup">
				<c:if test="${type == 'id'}">
					<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">아이디 찾기</h2>
				</c:if>
				<c:if test="${type == 'pwd'}">
					<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">비밀번호 찾기</h2>
				</c:if>
			</div>
			<table class="signForm">
				<colgroup>
					<col width="20%">
					<col width="50%">
				</colgroup>
				<tbody>
					<tr>
						<td colspan="2">
							<input class="inputRadio" type="radio" name="loginUser" id="loginUser-u" value="user" checked>
							<label for="loginUser-u">사용자</label>
							<input class="inputRadio" type="radio" name="loginUser" id="loginUser-b" value="boss">
							<label for="loginUser-b">사장님</label>
						</td>
					</tr>
					<c:if test="${type == 'pwd'}">
					<tr>
						<td>아이디</td>
						<td>
							<input class="inputText w300" type="text" name="id" id="id">
						</td>
					</tr>
					</c:if>
					<tr>
						<td>전화번호</td>
						<td>
							<input class="inputText w300" type="text" placeholder="(-)제외  13자리를 입력하세요" maxlength="13" id="phone">
						</td>
					</tr>
				</tbody>
			</table>
			<div class="btn-wrap">
				<c:if test="${type == 'id'}">
					<button class="btn-view btn-mint w300" onclick="findId()" type="button">찾기</button>
				</c:if>
				<c:if test="${type == 'pwd'}">
					<button class="btn-view btn-mint w300" onclick="findPw()" type="button">찾기</button>
				</c:if>
			</div>
		</div>
	</div>
<jsp:include page="footer.jsp" />
</body>
</html>