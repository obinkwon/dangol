<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="/image/favicon.png">
<meta charset="UTF-8">
<title>지역별</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="/css/template.css" />
<script type="text/javascript">
	function mainArea(areaNum,areaName){//메인 지역 클릭시
		$('#areaName').val(areaName);
		$.ajax({
			url: 'areaInfoDetail.do',
			type: 'GET',
			dataType: 'json',
			data: {
				areaNum : areaNum,
			},
			success: function(data){
				var str  = '<div role="tabpanel" class="tab-pane active" id="area'+areaNum+'">';
				str += '<a href="#" onclick="areaSort(\'전체\')">전체</a>';
				for(var i=0; i <data.length; i++){
					str += '<a href="#" onclick="areaSort(\''+data[i].saddress+'\')">'+data[i].saddress+'</a>'
					if((i+1)%11 == 0){
						str += '<br />';
					}
				}
				str += '</div>';
				$('#area_d').html(str);
			},
		});
	}
	
	function areaSort(subArea){
		var mainArea = $('#areaName').val();
		if(subArea == '전체') {
			subArea = '';
		}
		location.href="areaSort.do?areaName="+mainArea+" "+subArea;
	}
</script>
<script type="text/javascript">
	$(document).ready(function(){
		$("#sortSelect").change(function(){//정렬 클륵시
			var areaName = $('#areaName').val();
			location.href='areaSort.do?page=1&areaName='+areaName+'&type='+$(this).val();
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
		<div class="w80Form" style="margin:auto;text-align:center;">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">지역별</h2>
			</div>
			<div class="categorySort">
				<div role="tabpanel" style="border-bottom : 1px solid #d9d9d9">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<c:forEach var="area" items="${areaList}">
							<li role="presentation"><a href="#area${area.ord}" aria-controls="area${area.ord}" role="tab" data-toggle="tab" onclick="mainArea('${area.ord}','${area.saddress}')">${area.saddress}</a></li>
						</c:forEach>
					</ul>
					<!-- Tab panes -->
					<div id="area_d" class="tab-content">
						<span class="storeSpan" style="text-align:center;">${viewInfo.areaName}</span>
					</div>
				</div>
			</div>
		</div>
		<div class="w80Form" style="margin:auto;text-align:center;">
			<div class="toggle-wrap">
				<select class="inputText w100" id="sortSelect">
					<option value="new" <c:if test="${viewInfo.type == 'new' or viewInfo.type == ''}">selected</c:if>>최신순</option>
					<option value="star" <c:if test="${viewInfo.type == 'star'}">selected</c:if>>별점순</option>
					<option value="dan" <c:if test="${viewInfo.type == 'dan'}">selected</c:if>>단골순</option>
				</select>
			</div>
			<div class="categoryList">
				<input id="areaName" type="hidden" value="${viewInfo.areaName}">
				
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