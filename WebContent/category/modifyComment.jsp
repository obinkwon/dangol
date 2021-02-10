<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>후기 수정폼</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.main{
		margin : auto;
		display : block;
		width : 100%;
		padding-top : 50px;
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
	
	p.commentTitle {
		position: relative;
		margin-left: 15px;
		margin-bottom: 20px;
		font-size: 24px;
		font-weight: bold;
	}
	div.commentContent {
		width: 600px;
		position: relative;
		margin-left: 22%;
	}
	div.storeCommentOne {
		position: relative;
		width: 600px;
		margin-left: 22%;
	}
	table.commentForm {
		position: relative;
		margin-top: 17px;
		width: 100%;
	}
	table.commentForm td {
		height: 20px;
	}
	img.star,img.commentStar {
		width: 20px;
		height: 20px;
	}
	img.memberImg {
		margin-top: 20px;
		margin-left: 50px;
		width: 100px;
		height: 100px;
		border: 1.5px solid;
		border-radius: 50%;
	}
	p.name {
		margin-top: 20px;
		margin-left: 50px;
		font-size: 15px;
		font-weight: bold;
	}
	hr.line {
		border: solid #000000;
		border-width: 1px;
	}
	li.star0, li.star1, li.star2, li.star3, li.star4 {
		display: inline;
		cursor: pointer;
	}
	textarea {
		width: 540px;
		height: 80px;
		resize: none;
	}
	.insertBtn {
		float: right;
		margin-top: 10px;
	}
	select.selectTaste {
		width: 100px;
	}
</style>
<script type="text/javascript">
	function change(image){
		if(image.attr('src') == 'star-half.png'){
			image.attr('src','star.png');
		}else if(image.attr('src') == 'star-empty.png'){
			image.attr('src','star-half.png');	
		}else{
			image.attr('src','star-empty.png');	
		}
	}
</script>
<script type="text/javascript">
$(document).ready(function(){
	function numToStar(num,loc){//점수를 별로 바꾸는 함수
		var i = 0;		
		while (num > 0) {
			if(num == 0.5){
				loc.append("<li class='star"+i+"'><img class='commentStar' src='star-half.png'></li>");
			}else{
				loc.append("<li class='star"+i+"'><img class='commentStar' src='star.png'></li>");
			}
			i++;
			num--;
		}
		for(var j=i;j<5;j++){
			loc.append("<li class='star"+j+"'><img class='commentStar' src='star-empty.png'></li>");
		}
	}
 	//점수를 별로 바꾸기
	var totalloc = $('#commentStar1').children('ul');
	var serviceloc = $('#commentStar2').children('ul');
	var priceloc = $('#commentStar3').children('ul');
	
	var total =  ${comment.ctotal};//총점
	var service = ${comment.cservice};//서비스
	var price = ${comment.cprice};//가격
	totalloc.find('li').remove();
	serviceloc.find('li').remove();
	priceloc.find('li').remove();
	numToStar(total,totalloc);
	numToStar(service,serviceloc);
	numToStar(price,priceloc);
	
	var originSelect2= $('#selectTaste2').html();
	$("#selectTaste2").hide();
	$('#selectTaste1').change(function(){
		$('.insertBtn').val("수정완료");
		$("#selectTaste2").show();
	 	$('#selectTaste2').html(originSelect2);
		var selectTag =	$("#selectTaste1 option:selected").val(); 		
		$("#selectTaste2 option[value='"+selectTag+"']").remove();	
	});
	//별 클릭시 이벤트
	$('.star0').click(function(){
		$(this).parents().children('li:gt(0)').children('img').attr('src','star-empty.png');
		change($(this).children('img'));
	});
	$('.star1').click(function(){
		$(this).parents().children('li:gt(1)').children('img').attr('src','star-empty.png');
		$(this).parents().children('li:lt(1)').children('img').attr('src','star.png');
		change($(this).children('img'));
	});
	$('.star2').click(function(){
		$(this).parents().children('li:gt(2)').children('img').attr('src','star-empty.png');
		$(this).parents().children('li:lt(2)').children('img').attr('src','star.png');
		change($(this).children('img'));
	});
	$('.star3').click(function(){
		$(this).parents().children('li:gt(3)').children('img').attr('src','star-empty.png');
		$(this).parents().children('li:lt(3)').children('img').attr('src','star.png');
		change($(this).children('img'));
	});
	$('.star4').click(function(){
		$(this).parents().children('li:gt(4)').children('img').attr('src','star-empty.png');
		$(this).parents().children('li:lt(4)').children('img').attr('src','star.png');
		change($(this).children('img'));
	});
	
	$('.insertBtn').click(function(){
		var star;
		for(var j=1;j<4;j++){
			var sum = 0;
			for(var i=0;i<5;i++){
				star = $('td#commentStar'+j).find('li:eq('+i+')').children('img').attr('src');
				if(star == 'star.png') sum++;
				else if(star == 'star-half.png') sum += 0.5;
			}
			$('#result'+j).val(sum);
		}
	});
	
 	$('.insertBtn').click(function() { 
		var result = confirm('이용후기를 수정하시겠습니까?');
		if(result && $(this).val()!="수정중") $('form#comment').attr("onsubmit","return true;");
		else if(result && $(this).val()=="수정중"){
			alert("맛 태그를 선택해주세요");
			$('form#comment').attr("onsubmit","return false;");
		}
		else $('form#comment').attr("onsubmit","return false;");
	}); 
 	
});
</script>
	</head>
<body>
	<jsp:include page="../jsp/header.jsp" />

	<div class="main">
		<div class="commentContent">
			<p class="commentTitle">(${mid})&nbsp;단골님의
				(${store.sname})&nbsp;이용후기</p>
		</div>
		<div class="storeCommentOne">
			<form action="modifyComment.do" id="comment">
				<table class="commentForm">
					<tr>
						<td width="45%" rowspan="3" colspan="2">
							<input type="hidden" name="cnum" value="${comment.cnum}">
							<input type="hidden" name="type" value="${type}">
							<input type="hidden" name="snum" value="${store.snum}">
							<c:choose>
								<c:when test="${mimage!=null}">
									<img class="memberImg" src="downloadMImage.do?mid=${mid}">
									<br>
								</c:when>
								<c:otherwise>
									<img class="memberImg" src="myPage.png">
								</c:otherwise>
							</c:choose>
							<p class="name">${mid}&nbsp;
							<c:choose>
								<c:when test="${glevel==1}">진골</c:when>
								<c:when test="${glevel==2}">성골</c:when>
								<c:when test="${glevel==3}">단골</c:when>
								<c:otherwise>범골</c:otherwise>
							</c:choose>
							</p>
						</td>
						<td width="17%"><p>날짜</p></td>
						<td width="38%">
							<p>
								<fmt:formatDate value="${details.ddate}" pattern="yyyy-MM-dd" />
							</p>
						</td>
					</tr>
					<tr>
						<td><p>메뉴</p></td>
						<td>
							<table>
								<c:forEach var="menu" items="${menulist}">
									<tr>
										<td>${menu}</td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td><p>혜택</p></td>
						<c:if test="${grade.glevel==0}">
							<td><p>${store.sratelv0}%할인</p></td>
						</c:if>
						<c:if test="${grade.glevel==1}">
							<td><p>${store.sratelv1}%할인</p></td>
						</c:if>
						<c:if test="${grade.glevel==2}">
							<td><p>${store.sratelv2}%할인</p></td>
						</c:if>
						<c:if test="${grade.glevel==3}">
							<td><p>${store.sratelv3}%할인</p></td>
						</c:if>
					</tr>
					<tr>
						<td colspan="4"><hr class="line"></td>
					</tr>
					<tr>
						<td><p>총점</p></td>
						<td id="commentStar1">
							<ul>
								<c:forEach begin="0" end="4" varStatus="status">
									<li class="star${status.index}"><img class="star" src="star-empty.png"></li>
								</c:forEach>
							</ul> 
							<input type="hidden" name="ctotal" value="submit" id="result1">
						</td>
						<td>맛</td>
						<td>
							<select class="selectTaste" id="selectTaste1" name="tag">
									<c:forEach var="tasteTag" items="${tasteTag}">
										<option selected disabled hidden>#맛태그</option>
										<option value="${tasteTag.avalue}">${tasteTag.avalue}</option>
									</c:forEach>
							</select>&nbsp;&nbsp;&nbsp;&nbsp; 
							<select class="selectTaste" name="tag" id="selectTaste2">
								<c:forEach var="tasteTag" items="${tasteTag}">
									<option value="${tasteTag.avalue}">${tasteTag.avalue}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td><p>서비스</p></td>
						<td id="commentStar2">
							<ul>
								<c:forEach begin="0" end="4" varStatus="status">
									<li class="star${status.index}"><img class="star" src="star-empty.png"></li>
								</c:forEach>
							</ul> 
							<input type="hidden" name="cservice" value="submit" id="result2">
						</td>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td><p>가격</p></td>
						<td id="commentStar3">
							<ul>
								<c:forEach begin="0" end="4" varStatus="status">
									<li class="star${status.index}"><img class="star" src="star-empty.png"></li>
								</c:forEach>
							</ul> 
							<input type="hidden" name="cprice" value="submit" id="result3">
						</td>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td>후기</td>
						<td colspan="3"><textarea name="creview" maxlength="25">${comment.creview}</textarea></td>
					</tr>
				</table>
				<input type="submit" class="insertBtn" value="수정중">
			</form>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp" />
</body>
</html>