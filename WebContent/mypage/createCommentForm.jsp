<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
div.main {
	display: block;
	margin-top: 50px;
	margin-bottom: 100px;
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

img {
	width: 20px;
	height: 20px;
}

li.star0,li.star1,li.star2,li.star3,li.star4 {
	display: inline;
	cursor:pointer;
}

textarea {
	width: 540px;
	height: 80px;
	resize:none;
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

		var originSelect2= $('#selectTaste2').html();
		
		$("#selectTaste2").hide();
	 $('#selectTaste1').change(function(){
		 $("#selectTaste2").show();
 		$('#selectTaste2').html(originSelect2);
	 	var selectTag=	$("#selectTaste1 option:selected").val(); 		
		 $("#selectTaste2 option[value='"+selectTag+"']").remove();	
		 
	 });
	 

	 
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
		var sum = 0;
		for(var i=0;i<5;i++){
			star = $('#totalstar').children('li:eq('+i+')').children('img').attr('src');
			if(star == 'star.png'){
				sum++;
			}else if(star == 'star-half.png'){
				sum += 0.5;
			}
		}
		$('#result1').val(sum);
		//alert(sum);
	});
	
	$('.insertBtn').click(function(){
		var star;
		var sum = 0;
		for(var i=0;i<5;i++){
			star = $('#servicestar').children('li:eq('+i+')').children('img').attr('src');
			if(star == 'star.png'){
				sum++;
			}else if(star == 'star-half.png'){
				sum += 0.5;
			}
		}
		$('#result2').val(sum);
		//alert(sum);
	});
	$('.insertBtn').click(function(){
		var star;
		var sum = 0;
		for(var i=0;i<5;i++){
			star = $('#pricestar').children('li:eq('+i+')').children('img').attr('src');
			if(star == 'star.png'){
				sum++;
			}else if(star == 'star-half.png'){
				sum += 0.5;
			}
		}
	$('#result3').val(sum);
	
	});
	
	
  	$('.insertBtn').click(function() { 
		var result = confirm('이용후기를 등록하시겠습니까?');
		if(result &&$('#selectTaste1').val()!=null) { 
			$('form#comment').attr("onsubmit","return true;");
			} else {
				alert("후기를 입력해주세요");
				$('form#comment').attr("onsubmit","return false;");
			}
		}); 
 	
 


})

</script>
</head>
<body>
	<jsp:include page="../jsp/header.jsp" />

	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">마이페이지</a></li>
				<li class="nav"><a class="nav" href="myPage.do">회원정보</a></li>
				<li class="nav"><a class="nav" href="bookmark.do">즐겨찾기</a></li>
				<li class="nav"><a class="nav" href="historyList.do">방문내역</a></li>
				<li class="active"><a class="nav" href="reserveState.do">예약현황</a></li>
			</ul>
		</div>
		<div class="commentContent">
			<p class="commentTitle">(${mid})&nbsp;단골님의
				(${store.sname})&nbsp;이용후기</p>
		</div>
		<div class="storeCommentOne">
			<form action="createComment.do" id="comment" onsubmit="return true;">
				<table class="commentForm">
					<tr>
						<td width="45%" rowspan="3" colspan="2">
						<input type="hidden" name="dnum" value="${details.dnum}">
						<c:choose>
						<c:when test="${mimage!=null}">
						<img class="memberImg" src="downloadMImage.do?mid=${mid}"><br>
						</c:when>
						<c:otherwise>
						<img  class="memberImg" src="myPage.png">
						</c:otherwise>
						</c:choose>
							<p class="name">${mid}&nbsp;
								<c:if test="${glevel==0}">범골</c:if>
								<c:if test="${glevel==1}">진골</c:if>
								<c:if test="${glevel==2}">성골</c:if>
								<c:if test="${glevel==3}">단골</c:if>
							</p></td>
						<td width="17%"><p>날짜</p></td>
						<td width="38%"><p>
								<fmt:formatDate value="${details.ddate}" pattern="yyyy-MM-dd" />
							</p></td>
					</tr>
					<tr>
						<td><p>메뉴</p></td>
						<td>
							<table>
									<c:forEach var="menu" items="${menulist}">
										<tr><td>${menu}</td></tr>
									</c:forEach>
							</table>
						</td>
					</tr>
					<tr>
						<td><p>혜택</p></td>
						<c:if test="${glevel==0}">
							<td><p>${store.sratelv0}%할인</p></td>
						</c:if>
						<c:if test="${glevel==1}">
							<td><p>${store.sratelv1}%할인</p></td>
						</c:if>
						<c:if test="${glevel==2}">
							<td><p>${store.sratelv2}%할인</p></td>
						</c:if>
						<c:if test="${glevel==3}">
							<td><p>${store.sratelv3}%할인</p></td>
						</c:if>
					</tr>
					<tr>
						<td colspan="4"><hr class="line"></td>
					</tr>

					<tr>
						<td><p>총점</p></td>
						<td>
							<ul id="totalstar">
								<li class="star0"><img src="star-empty.png"></li>
								<li class="star1"><img src="star-empty.png"></li>
								<li class="star2"><img src="star-empty.png"></li>
								<li class="star3"><img src="star-empty.png"></li>
								<li class="star4"><img src="star-empty.png"></li>
							</ul>
							<input type="hidden" name="ctotal" id="result1">
						</td>
						<td>맛</td>
						<td><select class="selectTaste" id="selectTaste1" name="tag">
						<c:forEach var="tasteTag" items="${tasteTag}">
						<option selected disabled hidden >#맛태그</option>
						<option value="${tasteTag.avalue}">${tasteTag.avalue}</option>
						</c:forEach>
						</select>&nbsp;&nbsp;&nbsp;&nbsp;
							<select class="selectTaste" name="tag" id="selectTaste2">
								<c:forEach var="tasteTag" items="${tasteTag}">
						<option  value="${tasteTag.avalue}">${tasteTag.avalue}</option>
						</c:forEach>
							</select></td>
					</tr>

					<tr>
						<td><p>서비스</p></td>
						<td>
							<ul id="servicestar">
								<li class="star0"><img src="star-empty.png"></li>
								<li class="star1"><img src="star-empty.png"></li>
								<li class="star2"><img src="star-empty.png"></li>
								<li class="star3"><img src="star-empty.png"></li>
								<li class="star4"><img src="star-empty.png"></li>
							</ul>
							<input type="hidden" name="cservice" id="result2">
						</td>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td><p>가격</p></td>
						<td>
							<ul id="pricestar">
								<li class="star0"><img src="star-empty.png"></li>
								<li class="star1"><img src="star-empty.png"></li>
								<li class="star2"><img src="star-empty.png"></li>
								<li class="star3"><img src="star-empty.png"></li>
								<li class="star4"><img src="star-empty.png"></li>
							</ul>
							<input type="hidden" name="cprice" id="result3">
						</td>
						<td colspan="2"></td>
					</tr>
					<tr>
						<td>후기</td>
						<td colspan="3"><textarea name="creview"></textarea></td>
					</tr>
				</table>
			<input type="submit" class="insertBtn" value="작성완료">
			</form>
		</div>
	</div>

	<jsp:include page="../jsp/footer.jsp" />
</body>
</html>