<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트목록_이벤트/행사</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
	<style type="text/css">
		.container {
		    height: 1170px;
		}
		.contentsTitGroup{
			padding-top: 9.5rem;
    		padding-bottom: 6.0rem;
   		    text-align: center;
   		    display: block;
		}
		.contentTit:before, .contentTit:after {
		    display: inline-block;
		    background: #66ccff;
		    content: " ";
		    margin-top: -0.3rem;
		    width: 4.3rem;
		    height: 0.1rem;
		    vertical-align: middle;
		}
		.toggle-wrap {
			width : 100%;
		    margin-bottom : 100px;
		    margin-left :800px;
		    width: 41.1rem;
		    font-size: 1.6rem;
		    display: block;
		}
		.contents-wrap{
		    display: block;
		}
		.contentTit:before {
		    margin-right: 3.0rem;
		}
		
		.contentTit:after {
		    margin-left: 2.5rem;
		}
		.container ul,.container ol,.container li {
	    	list-style: none;
		}
		.container ul {
		    display: block;
		    margin-block-start: 1em;
		    margin-block-end: 1em;
		    margin-inline-start: 0px;
		    margin-inline-end: 0px;
		    padding-inline-start: 40px;
		}
		.container li {
			border : 2px solid #ffffff;
		    float: left;
		    width: 23.5%;
		    overflow: hidden;
		    display: list-item;
		}
		.container a {
		    position: relative;
		    display: block;
		    overflow: hidden;
		}
		a, a:link, a:visited, a:active {
		    text-decoration: none;
		    cursor: pointer;
		}
		.container li:hover{
			border : 2px solid #66ccff;
		}
		.img {
		    background: transparent;
		    display: block;
		    overflow: hidden;
		    max-width: 100%;
    		height: auto;
    		width: 100%;
    		border: none;
		}
		.contentsArea {
		    padding: 2rem;
		    text-align: left;
		}
		.contentsArea:hover{
			cursor : pointer;
		}
		.brandTit {
		    font-size: 1.6rem;
		    line-height: 1.7rem;
		}
		.scheduleDate, .eventTarget {
		    color: #666666;
		    font-size: 3.125vw;
		    height: 20px;
		    line-height: 20px;
	        font-size: 1.3rem;
	        display : block;
	        text-align : right;
	        margin-top : 10px;
		}
		.container img:hover{
            cursor:pointer;
            -webkit-transform:scale(1.1); /*  크롬 */
            -moz-transform:scale(1.1); /* FireFox */
            -o-transform:scale(1.1); /* Opera */
            transform:scale(1.1);
            transition: transform .35s;
            -o-transition: transform .35s;
            -moz-transition: transform .35s;
            -webkit-transition: transform .35s;
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
	</style>
	<script type="text/javascript">
		var status = $("#status").val(); 
	
		$(function(){
			if (${bid != null} && ${Stores == "[]"}) {
				alert("사장님 가게 등록을 먼저 해주세요");
			}else if(${bid == null}){
			}
			
			
			$("#store").on("change",function(){
				location.href="selectEvents.do?status="+status+"&snum="+this.value;
			});
			
			$(".contentsArea").on("click",function(event){
				$(this).siblings('a').trigger('click');
			});
 		});
		
		function eventView(eid){ // 이벤트 상세보기
			location.href="selectOneEvent.do?eid="+eid;
		}
	</script>
</head>
<body>
<jsp:include page="/jsp/header.jsp"/>
<div class="nav">
	<ul class="nav nav-pills nav-stacked">
		<li class="navTitle"><a class="navTitle">이벤트/행사</a></li>
		<li <c:if test="${status == 'all'}">class="active"</c:if>><a class="nav" href="selectEvents.do?status=all">모든 이벤트</a></li>
		<li <c:if test="${status == 'ing'}">class="active"</c:if>><a class="nav" href="selectEvents.do?status=ing">진행중인 이벤트</a></li>
		<li <c:if test="${status == 'ed'}">class="active"</c:if>><a class="nav" href="selectEvents.do?status=ed">종료된 이벤트</a></li>
	</ul>
</div>
<div class="container">
	<div class="contentsTitGroup">
		<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">EVENT</h2>
		<c:choose>
			<c:when test="${status eq 'ing'}">
				<h3 class="contentSubTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">진행중인 이벤트</h3>
			</c:when>
			<c:when test="${status eq 'ed'}">
				<h3 class="contentSubTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">종료된 이벤트</h3>
			</c:when>           
			<c:otherwise>
				<h3 class="contentSubTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">모든 이벤트</h3>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="toggle-wrap">
		<!-- 사장님 전용 단추 -->
		<c:if test="${not empty bid}">
			가게별 이벤트 보기 : 
			<select id="status" name="status">
				<option value="0">전체 이벤트</option>
				<option value="-1">내 모든 가게 이벤트</option>
				<c:if test="${not empty Stores}">
					<c:forEach var="store" items="${Stores}">
						<option id="${store.snum}" value="${store.snum}">${store.sname}</option>
					</c:forEach>
				</c:if>
			</select>
			<br>
			새로운 이벤트 추가 : 
		 	<button type="button" onclick="location.href='eventAddForm.do'">추가</button>
		</c:if>
	</div>
	<div class="contents-wrap">
		<c:forEach var="event" items="${eventList}" varStatus="status">
		<ul class="eventList">
			<li>
				<a href="#none" onclick="eventView('${event.eid}'); return false;">
					<span class="img" style="height: 277px;">
						<img src="download.do?eid=${event.eid}" alt="사진 파일을 준비중입니다." width="250px">
					</span>
				</a>
				<div class="contentsArea" style="height: 120px;">
					<div class="brandTit">${event.etitle}</div>
					<div class="scheduleDate">
						<span class="date"><fmt:formatDate value="${event.estartdate}" type="date" pattern="MM.dd(EE)"/></span>
						<span class="symbol">-</span>
                        <span class="date"><fmt:formatDate value="${event.eenddate}" type="date" pattern="MM.dd(EE)"/></span>
                    </div>
                    <div class="eventTarget">
                     	<span class="date">${event.etarget1}</span>
                     	<span class="symbol">~</span>
                     	<span class="date">${event.etarget2}</span>
                 	</div>
				</div>
			</li>
		</ul>
		</c:forEach>
	</div>
</div>
</body>
</html>