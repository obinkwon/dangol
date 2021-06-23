<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="/css/template.css" />
<style type="text/css">

p.name {
	margin-top: 20px;
	margin-left: 50px;
	font-size: 15px;
	font-weight: bold;
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
	
	//작성 완료
	function writeComment(){
		
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
		
		sum = 0;
		for(var i=0;i<5;i++){
			star = $('#servicestar').children('li:eq('+i+')').children('img').attr('src');
			if(star == 'star.png'){
				sum++;
			}else if(star == 'star-half.png'){
				sum += 0.5;
			}
		}
		$('#result2').val(sum);
		
		sum = 0;
		for(var i=0;i<5;i++){
			star = $('#pricestar').children('li:eq('+i+')').children('img').attr('src');
			if(star == 'star.png'){
				sum++;
			}else if(star == 'star-half.png'){
				sum += 0.5;
			}
		}
		$('#result3').val(sum);
		
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
<jsp:include page="/jsp/header.jsp" />
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">마이페이지</a></li>
				<li class="nav"><a class="nav" href="myPage.do">회원정보</a></li>
				<li class="nav"><a class="nav" href="bookmark.do">즐겨찾기</a></li>
				<li class="active"><a class="nav" href="historyList.do">방문내역</a></li>
				<li class="nav"><a class="nav" href="reserveState.do">예약현황</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">단골님의 이용후기</h2>
			</div>
			<div class="w80Form" style="margin:auto;text-align:center;">
				<form action="createComment.do" id="comment" onsubmit="return true;">
					<!-- top -->
					<div class="storeViewTop" style="height:130px;margin-top:50px;border-bottom:1px solid #000000;">
						<div class="storeLeft" style="width:30%;margin-left:200px;">
							<c:if test="${mimage ne null}">
								<img class="img100 imgRound" src="downloadMImage.do?mid=${mid}"><br>
							</c:if>
							<c:if test="${mimage eq null}">
								<img  class="img100 imgRound" src="/image/myPage.png">
							</c:if>
							<span class="storeSpan" style="margin-left:0px;">${mid}</span>
							<span class="storeSpan" style="margin-left:0px;">${details.gname}</span>
						</div>
						<div class="storeLeft" style="display:block;width:30%;text-align:left;">
							<p>날짜 : ${details.ddate}</p>
							<p>메뉴 : ${details.dmenu}</p>
							<p>혜택 : ${details.gbenefit}</p>
						</div>
					</div>
					<!-- tbottom -->
					<div class="storeViewBottom">
						<div class="storeLeft">
							<div>
								총점 
								<ul id="totalstar">
									<li class="star0"><img src="star-empty.png"></li>
									<li class="star1"><img src="star-empty.png"></li>
									<li class="star2"><img src="star-empty.png"></li>
									<li class="star3"><img src="star-empty.png"></li>
									<li class="star4"><img src="star-empty.png"></li>
								</ul>
								<input type="hidden" name="ctotal" id="result1">
							</div>
							<div>
							</div>
						</div>
						<div class="storeLeft">
							<div>
								맛
								<select class="inputText w100" id="selectTaste1" name="tag">
								<c:forEach var="tasteTag" items="${tasteTag}">
									<option selected disabled hidden >#맛태그</option>
									<option value="${tasteTag.avalue}">${tasteTag.avalue}</option>
								</c:forEach>
								</select>
								<select class="inputText w100" name="tag" id="selectTaste2">
								<c:forEach var="tasteTag" items="${tasteTag}">
									<option  value="${tasteTag.avalue}">${tasteTag.avalue}</option>
								</c:forEach>
								</select>
							</div>
						</div>						
					</div>
					
					
					
					
					<table>
	
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
					<button type="button" class="inputText w100" onclick="writeComment()">작성완료</button>
				</form>
			</div>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp" />
</body>
</html>