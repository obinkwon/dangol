<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>검색결과창</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.main{
		display : block;
		width : 100%;
		padding-top : 50px;
	}
	div.newStoreTop{
		margin : auto;
		width : 660px;
	}
	div.newStoreBottom{
		display : inline-block;		
		text-align : center;
		margin-left : 150px;
	}
	div.sortSelect{
		width : 100%;
		height : 100px;
	}
	p.newStoreTop{
		width : 100%;
		text-align : center;
		font-size : 30px;
		font-weight : bold;
		font-family : '맑은 고딕';
	}
	//중복
	div.storeList{
		display : inline-block;
		width : 100%;
		margin : auto;
	}
	div.storeOne{
		width : 300px;
		height : 400px;
		margin-right : 50px;
		margin-bottom : 50px;
		display : block;
		float : left;
		border : 1px solid #d9d9d9;
		border-bottom : 2px solid #d9d9d9;
	}
	div.storeOne:hover{
		border : 2px solid #66ccff;
		cursor: pointer;
	}
	select.sortSelect{
		float : right;
		margin-right : 200px;
		margin-bottom : 60px;
		width : 80px;
		height : 30px;
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
		$("#sortSelect").change(function(){
			location.href="search.do?page=${param.page}&keyword=${param.keyword}&type="+this.value;
		});
		if(${param.type=="dan"})
			$("#option_dan").prop('selected','true');
		else if(${param.type=="star"})
			$("#option_star").prop('selected','true');
		else
			$("#option_new").prop('selected','true');
		$('div.storeOne').click(function(){
			var snum = $(this).find('input[type=hidden]#storeNum').val();
			location.href="storeView.do?snum="+snum;
		});
	});
</script>
</head>
<body>
	<jsp:include page="../jsp/header.jsp"/>
	<div class="main">
		<div class="newStoreTop">
			<p class="newStoreTop">${param.keyword} (으)로 검색한 가게 결과 입니다</p>
		</div>
		<div class="newStoreBottom">
			<div class="sortSelect">
				<select class="sortSelect" id="sortSelect">
					<option id="option_new" value="new">최신순</option>
					<option id="option_star" value="star">별점순</option>
					<option id="option_dan" value="dan">단골순</option>
				</select>
			</div>
			<div class="storeList">
				<c:forEach var="storeMap" items="${storeMapList}">
				<div class="storeOne">
					<input id="storeNum" type="hidden" value="${storeMap.snum}">
					<c:choose>
						<c:when test="${storeMap.simage != null}">
							<img class="storeOne" src="downloadStoreImg.do?snum=${storeMap.snum}">
						</c:when>
						<c:otherwise>
							<img class="storeOne" src="image_ready2.png">
						</c:otherwise>
					</c:choose>
					<p class="storeOneA">
						<b>${storeMap.sname}</b>
					</p>
					<p class="storeOneB">${storeMap.saddress}</p>
					<span class="glyphicon glyphicon-star" aria-hidden="true"></span>
					<a class="storeOneA">${storeMap.commentCount}점</a><br>
					<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
					<a class="storeOneB">${storeMap.userCount}명</a>
					<p class="hashTag">
						<c:if test="${storeMap.stag1!=null}"><a>#${storeMap.stag1}</a></c:if>
						<c:if test="${storeMap.stag2!=null}"><a>#${storeMap.stag2}</a></c:if>
						<c:if test="${storeMap.stag3!=null}"><a>#${storeMap.stag3}</a></c:if>
					</p>
				</div>
				</c:forEach>
			</div>
		</div>
		<div style="text-align : center;">
			<c:if test="${viewInfo.start ne 1}">
				<input type="button" value="처음" onclick="location.href='search.do?page=1&type=${param.type}&keyword=${param.keyword}'">
				<input type="button" value="이전" onclick="location.href='search.do?page=${viewInfo.start-1}&type=${param.type}&keyword=${param.keyword}'">
			</c:if>
			<c:forEach begin="${viewInfo.start}" end="${viewInfo.end<viewInfo.last?viewInfo.end:viewInfo.last}" var="i">
				<c:choose>
					<c:when test="${i==viewInfo.current}">
						[${i}]
					</c:when>
					<c:otherwise>
						<a href="search.do?page=${i}&type=${param.type}&keyword=${param.keyword}">[${i}]</a>	
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${viewInfo.end < viewInfo.last}">
				<input type="button" value="다음" onclick="location.href='search.do?page=${viewInfo.end+1}&type=${param.type}&keyword=${param.keyword}'">
				<input type="button" value="마지막" onclick="location.href='search.do?page=${viewInfo.last}&type=${param.type}&keyword=${param.keyword}'">
			</c:if>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp"/>
</body>
</html>