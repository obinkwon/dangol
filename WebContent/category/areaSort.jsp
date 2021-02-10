<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %> 
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>지역별</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<style type="text/css">
	div.main{
		margin : auto;
		display : block;
		width : 100%;
		padding-top : 50px;
	}
	div.areaSortTop {
		text-align : center;
		margin : auto;
		width : 660px;
	}
	div.areaSortBottom {
		width : 965px;
		text-align : center;
		margin : auto;
	}
	div.areaSortTxt {
		display: inline-block;
		margin-top: 30px;
	}
	p.areaSortTop {
		width: 100%;
		text-align: center;
		font-size: 30px;
		font-weight: bold;
		font-family: '맑은 고딕';
	}
	/* 중복 */
	div.storeList {
		display : inline-block;
		text-align: center;
		margin : auto;
	}
	div.storeOne {
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
	div.storeOne:hover {
		border: 2px solid #66ccff;
		cursor: pointer;
	}
	select.sortSelect {
		float : right;
		margin-bottom : 60px;
		width : 80px;
		height : 30px;
	}
	p.areaTxt {
		width: 100%;
		text-align: center;
		font-size: 13px;
		font-family: '맑은 고딕';
	}
	img.storeOne {
		margin-top: 15px;
		width: 250px;
		height: 200px;
	}
	a.storeOne {
		margin-left: 15px;
		font-size: 15px;
		color: #ff4d4d;
	}
	a.storeOneA {
		margin-left: 15px;
		margin-top: 10px;
		font-size: 15px;
		color: #ff4d4d;
	}
	a.storeOneB {
		margin-left: 15px;
		margin-top: 10px;
		font-size: 15px;
		color: #00cc00;
	}
	p.storeOneA {
		margin-top: 10px;
		font-size: 20px;
	}
	p.storeOneB {
		margin-top: 10px;
		font-size: 15px;
	}
	p.hashTag {
		margin-top: 10px;
		font-size: 15px;
	}
	a.storeOneA:hover {
		text-decoration: none;
		font-size: 20px;
		color: #ff4d4d;
		font-weight: bold;
	}
	a.storeOneB:hover {
		text-decoration: none;
		font-size: 20px;
		color: #00cc00;
		font-weight: bold;
	}
	span.glyphicon-star, span.glyphicon-user {
		margin-top: 15px;
	}
	div.tab-pane a, div.tab-pane active a {
		margin-right: 20px;
		color: #000000;
	}
	div.tab-pane td,div.tab-pane active td{
		padding-bottom : 15px; 
	}
	div.tab-pane a:hover, div.tab-pane active a:hover {
		text-decoration: none;
		color: #66ccff;
		cursor: pointer;
	}
</style>
<script type="text/javascript">
	$(document).ready(function(){
		var mainArea = '';
		var subArea = '';
		var str = '${param.areaName}';
		if(str=='') {
			mainArea = '서울특별시';
			subArea = '전체';
		}
		else {
			var areaArray = str.split(" ");
			mainArea = areaArray[0];
			subArea = areaArray[1];
		}
        $('div.tab-content > div').each(function() {
        	$(this).attr('class','tab-pane');
        });
		$('li[role="presentation"] > a').each(function() {
			var text = $(this).text();
		    if(text == mainArea){
		        $(this).parent('li').attr('class','active');
		        var profile = $(this).attr('href');
		       	$(profile).attr('class','tab-pane active');
		    }else{
				$(this).parent('li').attr('class','');
		    }
		});
		if(${param.type=='dan'}){
			$("#option_dan").prop('selected','true');
		}else if(${param.type=='star'}){
			$("#option_star").prop('selected','true');
		}else{
			$("#option_new").prop('selected','true');
		}
		$("#sortSelect").change(function(){
			location.href="areaSort.do?page=${param.page}&areaName=${param.areaName}&type="+$(this).val();
		});
		$('li[role="presentation"]').click(function (e) {
			mainArea = $(this).children('a').text();
		});
		$('div.tab-content a').click(function(){
			subArea = $(this).text();
			if(subArea=='전체') subArea = '';
			location.href="areaSort.do?areaName="+mainArea+" "+subArea;
		});
		$('div.storeOne').click(function(){
			var snum = $(this).find('input[type=hidden]#storeNum').val();
			location.href="storeView.do?snum="+snum;
		});
	});
</script>
</head>
<body>
	<jsp:include page="../jsp/header.jsp" />
	<div class="main">
		<div class="areaSortTop">
			<p class="areaSortTop">지역별</p>
			<div class="areaSortTxt">
				<div role="tabpanel" style="border-bottom : 1px solid #d9d9d9">
					<!-- Nav tabs -->
					<ul class="nav nav-tabs" role="tablist">
						<li role="presentation" class="active"><a href="#area1"
							aria-controls="area1" role="tab" data-toggle="tab">서울특별시</a></li>
						<li role="presentation"><a href="#area2"
							aria-controls="area2" role="tab" data-toggle="tab">인천광역시</a></li>
						<li role="presentation"><a href="#area3"
							aria-controls="area3" role="tab" data-toggle="tab">대전광역시</a></li>
						<li role="presentation"><a href="#area4"
							aria-controls="area4" role="tab" data-toggle="tab">광주광역시</a></li>
						<li role="presentation"><a href="#area5"
							aria-controls="area5" role="tab" data-toggle="tab">대구광역시</a></li>
						<li role="presentation"><a href="#area6"
							aria-controls="area6" role="tab" data-toggle="tab">울산광역시</a></li>
						<li role="presentation"><a href="#area7"
							aria-controls="area7" role="tab" data-toggle="tab">부산광역시</a></li>
						<li role="presentation"><a href="#area8"
							aria-controls="area8" role="tab" data-toggle="tab">경기도</a></li>
						<li role="presentation"><a href="#area9"
							aria-controls="area9" role="tab" data-toggle="tab">강원도</a></li>
						<li role="presentation"><a href="#area10"
							aria-controls="area10" role="tab" data-toggle="tab">충청도</a></li>
						<li role="presentation"><a href="#area11"
							aria-controls="area11" role="tab" data-toggle="tab">전라도</a></li>
						<li role="presentation"><a href="#area12"
							aria-controls="area12" role="tab" data-toggle="tab">경상도</a></li>
						<li role="presentation"><a href="#area13"
							aria-controls="area13" role="tab" data-toggle="tab">제주도</a></li>
						<li role="presentation"><a href="#area14"
							aria-controls="area14" role="tab" data-toggle="tab">세종특별자치시</a></li>
					</ul>
					<!-- Tab panes -->
					<div class="tab-content">
						<div role="tabpanel" class="tab-pane active" id="area1">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>강남구</a></td>
									<td><a>강동구</a></td>
									<td><a>강서구</a></td>
									<td><a>강북구</a></td>
									<td><a>관악구</a></td>
									<td><a>광진구</a></td>
									<td><a>금천구</a></td>
									<td><a>노원구</a></td>
								</tr>
								<tr>
									<td><a>도봉구</a></td>
									<td><a>동대문구</a></td>
									<td><a>동작구</a></td>
									<td><a>마포구</a></td>
									<td><a>서대문구</a></td>
									<td><a>서초구</a></td>
									<td><a>성동구</a></td>
									<td><a>성북구</a></td>
									<td><a>송파구</a></td>
								</tr>
								<tr>
									<td><a>양천구</a></td>
									<td><a>영등포구</a></td>
									<td><a>용산구</a></td>
									<td><a>은평구</a></td>
									<td><a>종로구</a></td>
									<td><a>중구</a></td>
									<td><a>중랑구</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area2">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>계양구</a></td>
									<td><a>남구</a></td>
									<td><a>남동구</a></td>
									<td><a>동구</a></td>
									<td><a>부평구</a></td>
									<td><a>서구</a></td>
									<td><a>연수구</a></td>
									<td><a>중구</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area3">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>대덕구</a></td>
									<td><a>동구</a></td>
									<td><a>서구</a></td>
									<td><a>유성구</a></td>
									<td><a>중구</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area4">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>광산구</a></td>
									<td><a>남구</a></td>
									<td><a>동구</a></td>
									<td><a>북구</a></td>
									<td><a>서구</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area5">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>남구</a></td>
									<td><a>달서구</a></td>
									<td><a>동구</a></td>
									<td><a>북구</a></td>
									<td><a>서구</a></td>
									<td><a>수성구</a></td>
									<td><a>중구</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area6">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>남구</a></td>
									<td><a>동구</a></td>
									<td><a>북구</a></td>
									<td><a>중구</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area7">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>강서구</a></td>
									<td><a>금정구</a></td>
									<td><a>남구</a></td>
									<td><a>동구</a></td>
									<td><a>동래구</a></td>
									<td><a>부산진구</a></td>
									<td><a>북구</a></td>
									<td><a>사상구</a></td>
								</tr>
								<tr>
									<td><a>사하구</a></td>
									<td><a>서구</a></td>
									<td><a>수영구</a></td>
									<td><a>연제구</a></td>
									<td><a>영도구</a></td>
									<td><a>중구</a></td>
									<td><a>해운대구</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area8">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>고양시</a></td>
									<td><a>과천시</a></td>
									<td><a>광명시</a></td>
									<td><a>광주시</a></td>
									<td><a>구리시</a></td>
									<td><a>군포시</a></td>
									<td><a>김포시</a></td>
									<td><a>남양주시</a></td>
								</tr>
								<tr>
									<td><a>동두천시</a></td>
									<td><a>부천시</a></td>
									<td><a>성남시</a></td>
									<td><a>수원시</a></td>
									<td><a>시흥시</a></td>
									<td><a>안산시</a></td>
									<td><a>안성시</a></td>
									<td><a>안양시</a></td>
									<td><a>양주시</a></td>
								</tr>
								<tr>
									<td><a>오산시</a></td>
									<td><a>용인시</a></td>
									<td><a>의왕시</a></td>
									<td><a>의정부시</a></td>
									<td><a>이천시</a></td>
									<td><a>파주시</a></td>
									<td><a>평택시</a></td>
									<td><a>포천시</a></td>
									<td><a>하남시</a></td>
								</tr>
								<tr>
									<td><a>화성시</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane " id="area9">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>강릉시</a></td>
									<td><a>동해시</a></td>
									<td><a>삼척시</a></td>
									<td><a>속초시</a></td>
									<td><a>원주시</a></td>
									<td><a>춘천시</a></td>
									<td><a>북구</a></td>
									<td><a>태백시</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area10">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>제천시</a></td>
									<td><a>청주시</a></td>
									<td><a>충주시</a></td>
									<td><a>계룡시</a></td>
									<td><a>공주시</a></td>
									<td><a>논산시</a></td>
									<td><a>보령시</a></td>
									<td><a>서산시</a></td>
								</tr>
								<tr>
									<td><a>아산시</a></td>
									<td><a>천안시</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area11">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>군산시</a></td>
									<td><a>김제시</a></td>
									<td><a>남원시</a></td>
									<td><a>익산시</a></td>
									<td><a>전주시</a></td>
									<td><a>정읍시</a></td>
									<td><a>광양시</a></td>
									<td><a>나주시</a></td>
								</tr>
								<tr>
									<td><a>목포시</a></td>
									<td><a>순천시</a></td>
									<td><a>여수시</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area12">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>경산시</a></td>
									<td><a>경주시</a></td>
									<td><a>구미시</a></td>
									<td><a>김천시</a></td>
									<td><a>문경시</a></td>
									<td><a>상주시</a></td>
									<td><a>안동시</a></td>
									<td><a>영주시</a></td>
								</tr>
								<tr>
									<td><a>영천시</a></td>
									<td><a>포항시</a></td>
									<td><a>거제시</a></td>
									<td><a>김해시</a></td>
									<td><a>마산시</a></td>
									<td><a>밀양시</a></td>
									<td><a>사천시</a></td>
									<td><a>양산시</a></td>
									<td><a>진주시</a></td>
								</tr>
								<tr>
									<td><a>진해시</a></td>
									<td><a>창원시</a></td>
									<td><a>통영시</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area13">
							<table>
								<tr>
									<td><a>전체</a></td>
									<td><a>서귀포시</a></td>
									<td><a>제주시</a></td>
								</tr>
							</table>
						</div>
						<div role="tabpanel" class="tab-pane" id="area14">
							<table>
								<tr>
									<td><a>세종특별자치시</a></td>
								</tr>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="areaSortBottom">
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
						<a class="storeOneA">${storeMap.commentCount}점</a><br> <span
							class="glyphicon glyphicon-user" aria-hidden="true"></span> <a
							class="storeOneB">${storeMap.userCount}명</a>
						<p class="hashTag">
							<c:if test="${storeMap.stag1!=null}">
								<a>#${storeMap.stag1}</a>
							</c:if>
							<c:if test="${storeMap.stag2!=null}">
								<a>#${storeMap.stag2}</a>
							</c:if>
							<c:if test="${storeMap.stag3!=null}">
								<a>#${storeMap.stag3}</a>
							</c:if>
						</p>
					</div>
				</c:forEach>
			</div>
			<div>
			<c:if test="${viewInfo.start ne 1}">
				<input type="button" value="처음" onclick="location.href='areaSort.do?page=1&type=${param.type}&areaName=${param.areaName}'">
				<input type="button" value="이전" onclick="location.href='areaSort.do?page=${viewInfo.start-1}&type=${param.type}&areaName=${param.areaName}'">
			</c:if>
			<c:forEach begin="${viewInfo.start}" end="${viewInfo.end<viewInfo.last?viewInfo.end:viewInfo.last}" var="i">
				<c:choose>
					<c:when test="${i==viewInfo.current}">
						[${i}]
					</c:when>
					<c:otherwise>
						<a href="areaSort.do?page=${i}&type=${param.type}&areaName=${param.areaName}">[${i}]</a>	
					</c:otherwise>
				</c:choose>
			</c:forEach>
			<c:if test="${viewInfo.end < viewInfo.last}">
				<input type="button" value="다음" onclick="location.href='areaSort.do?page=${viewInfo.end+1}&type=${param.type}&areaName=${param.areaName}'">
				<input type="button" value="마지막" onclick="location.href='areaSort.do?page=${viewInfo.last}&type=${param.type}&areaName=${param.areaName}'">
			</c:if>
			</div>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp" />
</body>
</html>