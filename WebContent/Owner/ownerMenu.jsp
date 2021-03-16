<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가게정보 추가_내가게</title>
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
	.contentsTitGroup{
		padding-top: 2.0rem;
	    text-align: center;
	    display: block;
	}
	.btn-view {
	    width: 100px;
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
	.btn-mint{
		background-color: #66ccff;
		color: #fff;
	}
	.menubox{
		height : 50px;
	}
	.menubox label{ 
		display: inline-block; 
		vertical-align: middle;
		padding: .5em .75em; 
		color: #000000; 
		line-height: 25px;
		cursor: pointer; 
		border: 1px solid #000000; 
		height: 40px;
		float:left;
		margin-left : 40px;
	} 
	.menubox button{
		display: inline-block; 
		vertical-align: middle;
		padding: .5em .75em; 
		line-height: 25px;
		cursor: pointer; 
		height: 40px;
		float:left;
		margin-left : 40px;
	}
	.menubox input[type="file"] { 
		/* 파일 필드 숨기기 */ 
		position: absolute; 
		width: 1px; 
		height: 1px; 
		padding: 0; 
		margin: -1px; 
		overflow: hidden; 
		clip:rect(0,0,0,0); 
		border: 0; 
	}
	.menubox input[type="text"] { 
		display: inline-block; 
		float:left;
		margin-left : 40px;
	} 
	.btn-wrap {
		display: block;
		text-align: center;
	    width: 100%;
	    margin: 0 auto;
	    margin-bottom : 30px;
		padding-top: 4.5rem;
	}
	.nonborder{
		border : 0px;
	}
	.menuImg{
		width : 500px;
		height : 400px;
		margin-bottom : 50px;
	}
	.img30{
		margin-top: 10px;
		margin-left : 30px;
		width: 20px;
		height : 20px;
	}
	.ttip {
		position: relative;
		display: inline-block;
	}
	.ttiptext {
		visibility: hidden;
		width: 200px;
		background-color: #e6e6e6;
		text-align: center;
		padding: 5px 0;
		border-radius: 6px;
		position: absolute;
		margin-top: -40px;
		margin-left: -60px;
	}
	.ttip:hover .ttiptext {
		visibility: visible;
	}
	.layerpop{
		display : none;
		position : absolute;
	}
</style>
<script type="text/javascript">
$(function(){
	$("#ofile").on("change",SelectImg);
}); 
</script>
<script type="text/javascript">
	var sel_files = [];
	
	function SelectImg(e){//이미지 미리보기
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			sel_file = f;
			var reader = new FileReader();
			reader.onload = function(e){
				$("#oimage").attr("src",e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	
	function addMenu(){ //메뉴 등록
		if(confirm('추가 하시겠습니까?')){
			$('#frmList').attr('action','insertMenu.do');
			$('#frmList').submit();
		}
	}
	
	function delMenu(ord){ //메뉴 삭제
		var snum = $('#storeNum').val();
		if(confirm('삭제 하시겠습니까?')){
			location.href='deleteMenu.do?ord='+ord+'&snum='+snum;
		}
	}
	
	function viewMenu(ord){// 메뉴 이미지 팝업
		var snum = $('#storeNum').val();
		$.ajax({
			type:'POST',
			url:'downloadStoreMenuImg.do',
			data:{
				ord : ord,
				snum : snum
			},
			success : function(data){
				if(data != ''){
					openPop(ord,snum);
				}else{
					alert('등록된 이미지가 없습니다');
				}
			}
		});		
	}
	
	function closePop(){ //팝업 닫기
		$('.layerpop').hide();
	}
	
	function openPop(ord,snum){
		var _width = '600';
	    var _height = '600';
	    var _left = Math.ceil(( $(window).width() - _width )/2);
	    var _top = Math.ceil(( $(window).width() - _height )/2); 
		$('.layerpop').css({'width':_width, 'height':_height, 'left':_left, 'top':_top});
		$('#imgPopup').css({'width':_width, 'height':_height});
		$('#imgPopup').attr('src','downloadStoreMenuImg.do?ord='+ord+'&snum='+snum);
		$('.layerpop').show();
	}
</script>
</head>
<body>
	<jsp:include page="/jsp/header.jsp" />
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">사장님 페이지</a></li>
				<li><a class="nav" href="ownerInfoForm.do">내 정보</a></li>
				<li class="active"><a class="nav" href="ownerStore.do">내 가게</a></li>
				<li><a class="nav" href="selectDetailsBySnum.do">예약현황</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">메뉴 등록</h2>
			</div>
			<form id="frmList" enctype="multipart/form-data" method="post">
				<input type="hidden" name="bid" value="${bid}">
				<input type="hidden" name="snum" value="${store.snum}" id="storeNum">
				<div class="btn-wrap">
					<img class="menuImg" id="oimage" src="menu_ready.png">
					<div class="menubox">
						<input class="inputText w300" type="text" placeholder="메뉴명" name="oname">
						<input class="inputText w300" type="text" placeholder="가격" name="oprice">
						<label for="ofile">이미지 업로드</label>
						<input id="ofile" type="file" name="ofile" >
						<input type="hidden" name="oimage" value="${store.simage}">
						<button class="btn-view w100 btn-mint" type="button" onclick="addMenu()">추가</button>
						<div class="ttip">
							<img class="img30" alt="" src="/jsp/question-mark.png">
							<span class="ttiptext">사이즈 : 500 x 400 (px)</span>
						</div>
					</div>
				</div>
			</form>
			<table class="table">
				<colgroup>
					<col width="10%"/>
					<col width="*"/>
					<col width="20%"/>
					<col width="10%"/>
					<col width="10%"/>
				</colgroup>
				<tbody>
					<c:forEach var="order" items="${menuList}" varStatus="status">
					<tr>
						<td>${status.index+1}</td>
						<td>${order.oname}</td>
						<td>${order.oprice}</td>
						<td><button class="btn-view w100" type="button" onclick="delMenu('${order.ord}')">삭제</button></td>
						<td><button class="btn-view w100" type="button" onclick="viewMenu('${order.ord}')">이미지</button></td>
					</tr>
					</c:forEach>
					<c:if test="${empty menuList}">
					<tr>
						<td colspan="5" style="text-align : center;">등록된 메뉴가 없습니다</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="layerpop">
			<img id="imgPopup" src="">
			<div class="btn-wrap"><button class="btn-view w100 btn-mint" onclick="closePop()">닫기</button></div>
		</div>
	</div>
	<jsp:include page="/jsp/footer.jsp" />
</body>
</html>