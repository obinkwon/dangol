<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/image/favicon.png">
<meta charset="UTF-8">
<title>테마별</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="/css/template.css" />
<script type="text/javascript">
	function themeSort(page,type,anum){//페이지 이동
		location.href='themeSort.do?page='+page+'&type='+type+'&anum='+anum;
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$(".themeImg").click(function(){// 테마 종류 클릭시
			location.href="themeSort.do?type=new&anum="+$(this).children('input').val();
		});
		
		$("#sortSelect").change(function(){//정렬 클륵시
			var anum = $('#anum').val();
			location.href='themeSort.do?page=1&anum='+anum+'&type='+$(this).val();
		});
		
		$('.storeOne').click(function(){// 가게 클릭시
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
		<div class="w90Form" style="margin:auto;text-align:center;">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">테마별</h2>
			</div>
			<div class="categorySort">
				<c:forEach var="admin" items="${adminList}">
				<c:choose>
					<c:when test="${param.anum == admin.anum}">
						<div class="themeImg imgCheck">
							<span class="themeTxt"># ${admin.avalue}</span>
							<input type="hidden" value="${admin.anum}">
						</div>
					</c:when>
					<c:otherwise>
						<div class="themeImg">
							<span class="themeTxt"># ${admin.avalue}</span>
							<input type="hidden" value="${admin.anum}">
						</div>
					</c:otherwise>
				</c:choose>
				</c:forEach>
			</div>
		</div>
		<div class="w90Form" style="margin:auto;text-align:center;">
			<div class="toggle-wrap">
				<select class="inputText w100" id="sortSelect">
					<option value="new" <c:if test="${viewInfo.type == 'new' or viewInfo.type == ''}">selected</c:if>>최신순</option>
					<option value="star" <c:if test="${viewInfo.type == 'star'}">selected</c:if>>별점순</option>
					<option value="dan" <c:if test="${viewInfo.type == 'dan'}">selected</c:if>>단골순</option>
				</select>
			</div>
			<div class="categoryList">
				<input id="anum" type="hidden" value="${viewInfo.anum}">
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
<jsp:include page="/jsp/footer.jsp"/>
</body>
</html>