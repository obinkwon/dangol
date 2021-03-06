<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>음식별</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.main{
		margin : auto;
		display : block;
		width : 100%;
		padding-top : 50px;
	}
	div.foodSortTop{
		text-align : center;
		margin : auto;
		width : 660px;
	}
	div.foodSortBottom{
		width : 965px;
		text-align : center;
		margin : auto;
	}
	div.foodImg{
		width : 99.6px;
		height : 99px;
		border-radius : 4px;
		padding-top : 75px;
		margin-right : 10px;
		margin-bottom : 10px;
		border : 1px solid #000000;
		background-size: 95px 100px;
		float : left;
		background-position : center;
	}
	div.foodImg_check{
		width : 99.6px;
		height : 99px;
		border-radius : 4px;
		padding-top : 75px;
		margin-right : 10px;
		margin-bottom : 10px;
		border : 1px solid #66ccff;
		background-size: 95px 100px;
		float : left;
	}
	div.foodImg:hover{
		border : 1px solid #66ccff;
		cursor : pointer;
	}
	div.foodSortImg{
		display : inline-block;
		margin-top : 30px;
	}
	div.storeList{
		display : inline-block;
		text-align: center;
		margin : auto;
	}
	div.storeOne{
		width : 300px;
		height : 400px;
		margin : auto;
		margin-left : 10px;
		margin-right : 10px;
		margin-bottom : 10px;
		display : block;
		float : left;
		border : 1px solid #d9d9d9;
		border-bottom : 2px solid #d9d9d9;
		text-align: center;
	}
	div.storeOne:hover{
		border : 2px solid #66ccff;
		cursor: pointer;
	}
	select.sortSelect{
		float : right;
		margin-bottom : 60px;
		width : 80px;
		height : 30px;
	}
	p.foodSortTop{
		width : 100%;
		text-align : center;
		font-size : 30px;
		font-weight : bold;
		font-family : '맑은 고딕';
	}
	p.foodImg{
		width : 100%;
		text-align : center;
		font-size : 13px;
		font-family : '맑은 고딕';
	}
	img.foodImg{
		width : 90px;
		height : 90px;
	}
	img.storeOne{
		margin-top : 15px;
		width : 250px;
		height : 200px;
	}
	a.storeOne{
		margin-left : 15px;
		font-size : 15px;
		color : #ff4d4d;
	}
	a.storeOneA{
		margin-left : 15px;
		margin-top : 10px;
		font-size : 15px;
		color : #ff4d4d;
	}
	a.storeOneB{
		margin-left : 15px;
		margin-top : 10px;
		font-size : 15px;
		color : #00cc00;
	}
	p.storeOneA{
		margin-top : 10px;
		font-size : 20px;
	}
	p.storeOneB{
		margin-top : 10px;
		font-size : 15px;
	}
	p.hashTag{
		margin-top : 10px;
		font-size : 15px;
	}
	a.storeOneA:hover{
		text-decoration : none;
		font-size : 20px;
		color : #ff4d4d;
		font-weight : bold;
	}
	a.storeOneB:hover{
		text-decoration : none;
		font-size : 20px;
		color : #00cc00;
		font-weight : bold;
	}
	span.glyphicon-star,span.glyphicon-user{
		margin-top : 15px;
	}
</style>
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
	<jsp:include page="../jsp/header.jsp"/>
	<div class="main">
		<div class="foodSortTop">
			<p class="foodSortTop">음식별</p>
			<div class="foodSortImg">
				<c:forEach var="admin" items="${adminList}">
				<c:choose>
					<c:when test="${param.anum == admin.anum}">
						<div class="foodImg_check" style="background-image : url('downloadAimage.do?anum=${admin.anum}');">
							<p class="foodImg">${admin.avalue}</p>
							<input type="hidden" value="${admin.anum}">
						</div>
					</c:when>
					<c:otherwise>
						<div class="foodImg" style="background-image : url('downloadAimage.do?anum=${admin.anum}');">
							<p class="foodImg">${admin.avalue}</p>
							<input type="hidden" value="${admin.anum}">
						</div>
					</c:otherwise>
				</c:choose>
				</c:forEach>
			</div>
		</div>
		<div class="foodSortBottom">
			<div class="sortSelect">
				<select class="sortSelect" id="sortSelect">
					<option id="option_new" value="new">최신순</option>
					<option id="option_star" value="star">별점순</option>
					<option id="option_dan" value="dan">단골순</option>
				</select>
			</div>
			<div class="storeList">
				<c:forEach var="store" items="${storeList}">
				<div class="storeOne">
					<input class="storeNum" type="hidden" value="${store.snum}">
					<c:choose>
						<c:when test="${store.simage != null}">
							<img class="storeOne" src="downloadStoreImg.do?snum=${store.snum}">
						</c:when>
						<c:otherwise>
							<img class="storeOne" src="image_ready2.png">
						</c:otherwise>
					</c:choose>
					<p class="storeOneA"><b>${store.sname}</b></p>
					<p class="storeOneB">${store.saddress}</p>
					<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
					<a class="storeOneA">${store.commentTotal}점</a><br>
					<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
					<a class="storeOneB">${store.dancnt}명</a>
					<p class="hashTag">
						<c:if test="${store.stag ne null}"><a>${store.stag}</a></c:if>
					</p>
				</div>
				</c:forEach>
			</div>
			<div>
			<c:if test="${viewInfo.start ne 1}">
				<input type="button" value="처음" onclick="location.href='foodSort.do?page=1&type=${param.type}&foodName=${param.foodName}'">
				<input type="button" value="이전" onclick="location.href='foodSort.do?page=${viewInfo.start-1}&type=${param.type}&foodName=${param.foodName}'">
			</c:if>
			<c:forEach begin="${viewInfo.start}" end="${viewInfo.end < viewInfo.last ? viewInfo.end : viewInfo.last}" var="i">
				<c:choose>
					<c:when test="${i==viewInfo.current}">
						[${i}]
					</c:when>
					<c:otherwise>
						<a href="foodSort.do?page=${i}&type=${param.type}&foodName=${param.foodName}">[${i}]</a>	
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${viewInfo.end < viewInfo.last}">
				<input type="button" value="다음" onclick="location.href='foodSort.do?page=${viewInfo.end+1}&type=${param.type}&foodName=${param.foodName}'">
				<input type="button" value="마지막" onclick="location.href='foodSort.do?page=${viewInfo.last}&type=${param.type}&foodName=${param.foodName}'">
			</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp"/>
</body>
</html>