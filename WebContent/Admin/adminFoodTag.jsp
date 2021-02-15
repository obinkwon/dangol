<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>업종태그_관리자화면</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
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
	div.section{
		margin-top : 50px;
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
	.filebox label {
	    display: inline-block;
	    vertical-align: middle;
	    padding: .5em .75em;
	    color: #000000;
	    line-height: 25px;
	    cursor: pointer;
	    border: 1px solid #000000;
	    height: 40px;
	}
	.filebox input[type="file"] {
	    position: absolute;
	    width: 1px;
	    height: 1px;
	    padding: 0;
	    margin: -1px;
	    overflow: hidden;
	    clip: rect(0,0,0,0);
	    border: 0;
	}
	.foodImg {
	    display: block;
	    margin: 0 auto;
	    width: 100px;
	    height: 100px;
	    float: left;
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
	.left-form {
	    width: 330px;
	    float: left;
	    line-height: 62px;
	    padding-left: 10px;
	    color: #555;
	    text-align: left;
	    font-size: 14px;
	}
	.middle-form {
	    float: left;
	    width: 30%;
	    color: #7b6e66;
	    text-align: left;
	}
	.right-form {
	    float: left;
	    width: 20%;
	    color: #7b6e66;
	    text-align: left;
	}
	.table {
		margin-bottom : 10px;
		border-bottom : 1px solid #ddd;
	}
</style>
	<script type="text/javascript">
		$(document).ready(function(){
			$("#afile").on("change",SelectImg);
		});
		
		function addFoodTag(){ //태그 추가
			if($('#foodTagText').val() == '' || $('#afile').val() == ''){
				alert('추가할 태그명과 이미지 파일을 입력해주세요');
			}else{
			    $('#frmList').submit();
			}
		}
		
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
		
		function deleteTag(anum){ //태그 삭제
			if (confirm("정말로 삭제하시겠습니까?")) {
				location.href="deleteTag.do?returnUrl=adminFoodTag.do&anum="+anum;			
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
			<li class="nav_active"><a href="adminFoodTag.do" class="nav">업종별 태그</a></li>
			<li class="nav"><a href="adminTasteTag.do" class="nav">맛별 태그</a></li>
			<li class="nav"><a href="selectAllInquirys.do" class="nav">1:1문의</a></li>
			<li class="nav"><a href="logout.do" class="nav"><button>로그아웃</button></a></li>
		</ul>
	</div>
	<div class="section">
		<div class="page_title">
			<h3>업종태그 설정</h3>
		</div>
		<table class="table">
			<tr>
				<th>이미지</th>
				<th>테마</th>
				<th>삭제</th>
			</tr>
				<c:forEach var="foodTag" items="${foodTags}">
					<tr>
						<td><img src="downloadAimage.do?anum=${foodTag.anum}" alt="사진 파일을 준비중입니다." width="100px" height="100px"></td>
						<td>${foodTag.avalue}</td>
						<td>
							<input type="button" onclick="deleteTag('${foodTag.anum}');" class="btn_del_FoodTag" value="x">
						</td>
					</tr>
				</c:forEach>
		</table>
		<form id="frmList" action="insertTagFile.do" enctype="multipart/form-data" method="post">
			<div class="left-form">
				<input type="hidden" name="atype" value="food">
				<input class="inputText w300" type="text" name="avalue" id="foodTagText" placeholder="추가할 태그를 입력하세요">
			</div>
			<div class="middle-form">
				<div class="filebox">
					<img id="img" class="foodImg" src="menu_ready.png">
					<label for="afile">이미지 업로드</label>
					<input type="file" name="afile" id="afile">
				</div>
			</div>
			<div class="right-form">
				<button class="btn-view" type="button" onclick="addFoodTag(); return false;">추가하기</button>
			</div>
		</form>
	</div>
</div>
</body>
</html>