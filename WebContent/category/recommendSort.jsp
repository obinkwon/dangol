<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>추천별</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/css/template.css" />
<script type="text/javascript">
	$(document).ready(function(){
		for(var i = 0; i < 3; i++){
			var rColor = "#"+(parseInt(Math.random()*0xffff)).toString(16)+"00";
			$('.recommendTag:eq('+i+')').css({'color':rColor});
		}
		
		$('#question').hover(function(){
			$('#tooltip').css({'display' : 'inline'});
		},function(){
			$('#tooltip').css({'display' : 'none'});
		});
		
		$('.storeOne').click(function(){// 가게 클릭시
			var snum = $(this).find('input[type=hidden]').val();
			location.href="storeView.do?snum="+snum;
		});
	});
</script>
</head>
<body>
<jsp:include page="/jsp/header.jsp" />
<div class="main">
	<div class="container">
		<div class="w90Form" style="margin:auto;text-align:center;">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">추천별</h2>
			</div>
			<div class="categorySort">
				<span class="storeBoldSpan">
					<b>${mid}</b>님을 위한 추천
					<span class="glyphicon glyphicon-question-sign" id="question"></span>
				</span><br/>
				<span id="tooltip" class="storeSpan tooltipSpan">선호지역과 해시태그를 바탕으로 검색한 추천리스트입니다.</span><br/>
				<c:forEach var="admin" items="${mtagList}">
					<span class="recommendTag">
						#${admin.avalue}
					</span>
				</c:forEach>
			</div>
		</div>
		<div class="w90Form" style="margin:auto;text-align:center;">
			<div class="categoryList" style="margin-top:50px;">
				<c:forEach var="store" items="${storeList}">
					<div class="storeOne">
						<input type="hidden" value="${store.snum}">
						<c:choose>
							<c:when test="${store.simage != null}">
								<img class="img250 h200" src="downloadStoreImg.do?snum=${store.snum}" style="margin-top:20px;">
							</c:when>
							<c:otherwise>
								<img class="img250 h200" src="/image/image_ready2.png" style="margin-top:20px;">
							</c:otherwise>
						</c:choose><br/>
						<span class="storeSpan" style="margin-left:0px;">${store.sname}</span><br/>
						<span class="storeSpan" style="margin-left:0px;">${store.saddress}</span><br/>
						<span class="glyphicon glyphicon-star" aria-hidden="true" style="margin-top:15px;"></span>
						<a class="storeA span-red">${store.commentTotal}점</a><br/>
						<span class="glyphicon glyphicon-user" aria-hidden="true" style="margin-top:15px;"></span>
						<a class="storeA span-green">${store.dancnt}명</a><br/>
						<span class="storeSpan" style="margin-left:0px;">
							<c:if test="${store.stag ne null}"><a>${store.stag}</a></c:if>
						</span>
					</div>
				</c:forEach>
			</div>
			<div>
				<c:if test="${viewInfo.startPage ne 1}">
					<input type="button" value="처음" onclick="themeSort('1','${viewInfo.type}','${viewInfo.anum}')">
					<input type="button" value="이전" onclick="themeSort('${viewInfo.startPage-1}','${viewInfo.type}','${viewInfo.anum}')">
				</c:if>
				<c:forEach begin="${viewInfo.startPage}" end="${viewInfo.endPage < viewInfo.lastPage ? viewInfo.endPage : viewInfo.lastPage}" var="i">
					<c:choose>
						<c:when test="${i == viewInfo.page}">
							[${i}]
						</c:when>
						<c:otherwise>
							<a href="themeSort('${i}','${viewInfo.type}','${viewInfo.anum}')">[${i}]</a>	
						</c:otherwise>
					</c:choose>
				</c:forEach>
				<c:if test="${viewInfo.endPage < viewInfo.lastPage}">
					<input type="button" value="다음" onclick="themeSort('${viewInfo.endPage+1}','${viewInfo.type}','${viewInfo.anum}')">
					<input type="button" value="마지막" onclick="themeSort('${viewInfo.lastPage}','${viewInfo.type}','${viewInfo.anum}')">
				</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/jsp/footer.jsp" />
</body>
</html>