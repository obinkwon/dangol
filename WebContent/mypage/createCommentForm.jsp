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
textarea {
	width: 540px;
	height: 80px;
	resize:none;
}
</style>
<script type="text/javascript">
var star_empty = '/image/star-empty.png';
var star_full = '/image/star.png';
var star_half = '/image/star-half.png';

	//별 이미지 교체
	function starChange(type,starNum){
		var result = $('#'+type+'Res'+starNum).val();
		var image = $('#'+type+'Img'+starNum);
		var sum = Number(starNum);
		if(result == 'H'){
			image.attr('src',star_full);
			$('#'+type+'Res'+starNum).val('F');
			sum += 1;
		}else if(result == 'E'){
			image.attr('src',star_half);	
			$('#'+type+'Res'+starNum).val('H');
			sum += 0.5;
		}else{
			image.attr('src',star_empty);	
			$('#'+type+'Res'+starNum).val('E');
		}
		$('#'+type+'Sum').val(sum);
	}
	
	//별 클릭시
	function starBtn(type,starNum){
		if(starNum == '0'){
			$('#'+type+'star').children('li:gt('+starNum+')').children('img').attr('src',star_empty);
			$('#'+type+'star').children('li:gt('+starNum+')').children('input').val('E');
		}else{
			$('#'+type+'star').children('li:gt('+starNum+')').children('img').attr('src',star_empty);
			$('#'+type+'star').children('li:gt('+starNum+')').children('input').val('E');
			$('#'+type+'star').children('li:lt('+starNum+')').children('img').attr('src',star_full);
			$('#'+type+'star').children('li:lt('+starNum+')').children('input').val('F');
		}
		starChange(type,starNum);
	}
	
	//작성 완료
	function writeComment(){
		if(confirm('이용후기를 등록하시겠습니까?')){
			$('#comment').attr('action','createComment.do');
			$('#comment').submit();
		}
	}
</script>
<script type="text/javascript">
$(document).ready(function(){
	var selHtml= $('#selectTaste2').html();
 	$('#selectTaste1').change(function(){
		var selectTag=	$("#selectTaste1 option:selected").val(); 		
		$("#selectTaste2").show();
		$('#selectTaste2').html(selHtml);
		$("#selectTaste2 option[value='"+selectTag+"']").remove();	
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
				<form action="" id="comment">
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
						<div class="storeLeft" style="width:40%;margin-left:200px;">
							<div style="text-align:left;">
								<span class="storeSpan" style="margin-right:15px;">총점</span>
								<ul id="totalstar" style="display:inline-block;">
									<li class="star" onclick="starBtn('total',0)"><img id="totalImg0" class="img20" src="/image/star-empty.png"><input id="totalRes0" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('total',1)"><img id="totalImg1" class="img20" src="/image/star-empty.png"><input id="totalRes1" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('total',2)"><img id="totalImg2" class="img20" src="/image/star-empty.png"><input id="totalRes2" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('total',3)"><img id="totalImg3" class="img20" src="/image/star-empty.png"><input id="totalRes3" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('total',4)"><img id="totalImg4" class="img20" src="/image/star-empty.png"><input id="totalRes4" type="hidden" value="E"></li>
								</ul>
								<input type="hidden" name="ctotal" id="totalSum">
							</div>
							<div style="text-align:left;">
								<span class="storeSpan">서비스</span>
								<ul id="servicestar" style="display:inline-block;">
									<li class="star" onclick="starBtn('service',0)"><img id="serviceImg0" class="img20" src="/image/star-empty.png"><input id="serviceRes0" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('service',1)"><img id="serviceImg1" class="img20" src="/image/star-empty.png"><input id="serviceRes1" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('service',2)"><img id="serviceImg2" class="img20" src="/image/star-empty.png"><input id="serviceRes2" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('service',3)"><img id="serviceImg3" class="img20" src="/image/star-empty.png"><input id="serviceRes3" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('service',4)"><img id="serviceImg4" class="img20" src="/image/star-empty.png"><input id="serviceRes4" type="hidden" value="E"></li>
								</ul>
								<input type="hidden" name="cservice" id="serviceSum">
							</div>
							<div style="text-align:left;">
								<span class="storeSpan" style="margin-right:15px;">가격 </span>
								<ul id="pricestar" style="display:inline-block;">
									<li class="star" onclick="starBtn('price',0)"><img id="priceImg0" class="img20" src="/image/star-empty.png"><input id="priceRes0" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('price',1)"><img id="priceImg1" class="img20" src="/image/star-empty.png"><input id="priceRes1" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('price',2)"><img id="priceImg2" class="img20" src="/image/star-empty.png"><input id="priceRes2" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('price',3)"><img id="priceImg3" class="img20" src="/image/star-empty.png"><input id="priceRes3" type="hidden" value="E"></li>
									<li class="star" onclick="starBtn('price',4)"><img id="priceImg4" class="img20" src="/image/star-empty.png"><input id="priceRes4" type="hidden" value="E"></li>
								</ul>
								<input type="hidden" name="cprice" id="priceSum">
							</div>
						</div>
						<div class="storeLeft" style="width:40%;text-align:left;">
							<span class="storeSpan" style="float:left;margin-right:50px;">맛</span>
							<select class="inputText w100" id="selectTaste1" name="ctaste">
								<option selected disabled>맛 선택</option>
								<c:forEach var="tasteTag" items="${tasteList}">
									<option value="${tasteTag.avalue}">${tasteTag.avalue}</option>
								</c:forEach>
							</select>
							<select class="inputText w100" id="selectTaste2" name="ctaste" style="display:none;margin-left:20px;">
								<c:forEach var="tasteTag" items="${tasteList}">
									<option  value="${tasteTag.avalue}">${tasteTag.avalue}</option>
								</c:forEach>
							</select>
						</div>						
					</div>
					<div class="storeViewBottom">	
						<div class="storeLeft" style="width:40%;margin-left:200px;">
							<span class="storeSpan" style="float:left;">후기</span>
							<textarea class="textarea" name="creview"></textarea>
						</div>
					</div>
					<div class="btn-wrap">
						<button type="button" class="btn-view w100" onclick="writeComment()">작성완료</button>
					</div>	
				</form>
			</div>
		</div>
	</div>
<jsp:include page="/jsp/footer.jsp" />
</body>
</html>