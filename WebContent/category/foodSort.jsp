<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>음식별</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js" ></script>
<link rel="stylesheet" href="/css/template.css" />
<script type="text/javascript">
	function foodSort(page,type,foodName){//페이지 이동
		location.href='foodSort.do?page='+page+'&type='+type+'&foodName='+foodName;
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$("div.foodImg").click(function(){
			location.href="foodSort.do?type=food&anum="+$(this).children('input').val();
		});
		$("#sortSelect").change(function(){
			location.href="foodSort.do?page=${param.page}&foodName=${param.foodName}&type="+this.value;
		});
		if(${param.type=="dan"})
			$("#option_dan").prop('selected','true');
		else if(${param.type=="star"})
			$("#option_star").prop('selected','true');
		else
			$("#option_new").prop('selected','true');
		
		$('div.storeOne').click(function(){
			var snum = $(this).find('input[type=hidden]').val();
			location.href="storeView.do?snum="+snum;
		});
	});
</script>
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
<div class="main">
	<div class="container">
		<div class="w80Form" style="margin:auto;text-align:center;">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">음식별</h2>
			</div>
			<div class="foodSort">
				<c:forEach var="admin" items="${adminList}">
				<c:choose>
					<c:when test="${param.anum == admin.anum}">
						<div class="foodImg imgCheck" style="background-image : url('downloadAimage.do?anum=${admin.anum}');">
							<span class="imgSpan">${admin.avalue}</span>
							<input type="hidden" value="${admin.anum}">
						</div>
					</c:when>
					<c:otherwise>
						<div class="foodImg" style="background-image : url('downloadAimage.do?anum=${admin.anum}');">
							<span class="imgSpan">${admin.avalue}</span>
							<input type="hidden" value="${admin.anum}">
						</div>
					</c:otherwise>
				</c:choose>
				</c:forEach>
			</div>
		</div>
		<div class="w80Form" style="margin:auto;text-align:center;">
			<div class="toggle-wrap">
				<select class="inputText w100" id="sortSelect">
					<option id="option_new" value="new">최신순</option>
					<option id="option_star" value="star">별점순</option>
					<option id="option_dan" value="dan">단골순</option>
				</select>
			</div>
			<div class="foodList">
				<c:forEach var="store" items="${storeList}">
					<div class="storeOne">
						<input class="storeNum" type="hidden" value="${store.snum}">
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
						<a class="storeA span-green">${store.dancnt}명</a>
						<span class="storeSpan" style="margin-left:0px;">
							<c:if test="${store.stag ne null}"><a>${store.stag}</a></c:if>
						</span>
					</div>
				</c:forEach>
			</div>
			<div>
			<c:if test="${viewInfo.startPage ne 1}">
				<input type="button" value="처음" onclick="foodSort('1','${param.type}','${param.foodName}')">
				<input type="button" value="이전" onclick="foodSort('${viewInfo.startPage-1}','${param.type}','${param.foodName}')">
			</c:if>
			<c:forEach begin="${viewInfo.startPage}" end="${viewInfo.endPage < viewInfo.lastPage ? viewInfo.endPage : viewInfo.lastPage}" var="i">
				<c:choose>
					<c:when test="${i == viewInfo.page}">
						[${i}]
					</c:when>
					<c:otherwise>
						<a href="foodSort('${i}','${param.type}','${param.foodName}')">[${i}]</a>	
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${viewInfo.endPage < viewInfo.lastPage}">
				<input type="button" value="다음" onclick="foodSort('${viewInfo.endPage+1}','${param.type}','${param.foodName}')">
				<input type="button" value="마지막" onclick="foodSort('${viewInfo.lastPage}','${param.type}','${param.foodName}')">
			</c:if>
			</div>
		</div>
	</div>
</div>
<jsp:include page="/jsp/footer.jsp"/>
</body>
</html>