<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트상세보기_이벤트/행사</title>
<link rel="stylesheet" href="/css/template.css" />
<style>
	.contentsTitGroup{
		padding-top: 9.5rem;
  		padding-bottom: 6.0rem;
	    text-align: center;
	    display: block;
	}
	.titContentDetail{
		border-bottom : 1px solid #66ccff; 
	}
	.event-contents {
	    padding-top: 3rem;
	    margin : 0 auto;
	    text-align : center;
	    display: inline-block;
	}
	.event-contents dl {
	    padding-right: 6vw;
	    padding-left: 6vw;
		font-size: 1.8rem;
		line-height: 3.2rem;
	}
	.event-contents dt {
	    font-weight: 700;
	    display: inline-block;
	}
	.event-contents dt:after {
		content: '|';
	    display: inline-block;
	    vertical-align: middle;
	    font-size: 1.6rem;
	    margin: 0 1rem;
	    margin-top: -0.7rem;
	}
	.event-contents dd {
	    display: inline-block;
	}
	.event-contents-wrap {
	    width: 950px;
	    margin: 0 auto;
	    text-align : center;
	}
	.spanText{
		height: 40px;
	    color: #7b6e66;
	    padding: 0 7px;
	    background-color: transparent;
	}
	.btn-basic{
		backgroud-color: #ffcc99;
	}
</style>
<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
	function deleteEvent(eid){
		if (confirm("이벤트를 삭제하시겠습니까?")) {
			location.href='deleteEvent.do?eid='+eid;
		}
	}
	
	function updateEvent(eid){
		location.href='eventUpdateForm.do?eid='+eid;
	}
</script>
</head>
<body>
	<jsp:include page="/jsp/header.jsp"/>
	<div class="container">
		<div class="contentsTitGroup">
			<strong class="titContentDetail" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">이벤트 상세</strong>
			<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">${event.etitle}</h2>
		</div>
		<div class="event-contents-wrap">
			<div class="image-wrap">
				<img src="download.do?eid=${event.eid}" alt="사진 파일을 준비중입니다." width="100%" height="100%">
			</div>
			<div class="event-contents">
				<dl>
					<dt>이벤트 기간</dt>
					<dd>
						<fmt:formatDate value="${event.estartdate}" type="date" pattern="MM.dd(EE)"/>
						<span class="spanText"> - </span>
						<fmt:formatDate value="${event.eenddate}" type="date" pattern="MM.dd(EE)"/>
						
					</dd>
				</dl>
				<dl>
					<dt>이벤트 대상</dt>
					<dd>
						<c:choose>
							<c:when test="${event.etarget1 == event.etarget2}">
								<span class="spanText">${event.etarget1}</span> 
							</c:when>
							<c:otherwise>
								<span class="spanText">${event.etarget1} ~ ${event.etarget2}</span> 
							</c:otherwise>
						</c:choose>
					</dd>
				</dl>
			</div>
		</div>
	<!-- 사장님 전용 단추 -->
	<c:if test="${Authority eq true}">
		<div class="btn-wrap">
			<button type="button" class="btn-view btn-mint" id="update_event" onclick="updateEvent('${event.eid}'); return false;" style="margin-top: 4.5rem;">수정</button>
			<button type="button" class="btn-view" onClick="deleteEvent('${event.eid}'); return false;" style="margin-top: 4.5rem;">삭제</button>
	 	</div>
	</c:if>
	</div>
</body>
</html>