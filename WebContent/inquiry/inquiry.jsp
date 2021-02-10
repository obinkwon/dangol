<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자주묻는질문</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
div.main {
	display: block;
	width: 100%;
	margin-top: 50px;
	margin-bottom: 100px;
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

li.active {
	background-color: #66ccff;
}

div.inquiryDiv{
	display: inline-block;
	width: 65%;
	margin-left: 10%;
}
div.inquiryText{
font-size:17px;
line-height:2em
}
div.col-lg-6{
position:relative;
margin-bottom:30px;
float:right;
width:250px;
heigth:30px;
}
h2.page-header{
margin-left:50px;
margin-bottom:30px;
font-weight: 500;
}
#inquiryBtn{
	float:right;
	margin-right:50px;
	margin-top:30px;
	margin-bottom:30px;
	background-color: #66ccff;
	border: none;
	color: white;
	width: 120px;
	height: 45px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 14px;
	cursor: pointer;
}
table.table {
	width: 100%;
	border-top:2px solid #66ccff
}
table.table th {
text-align:center;
}

.cancelImg {
	width: 100%;
	height: 100%;
}

.delBtn {
	padding: 0px;
	width: 30px;
	height: 30px;
	border: 0px;
	background-color: white;
	outline: 0;
}
td.inquirylist{
text-align:center;
}
.inquirytitle{
cursor: pointer;}



</style>

<script type="text/javascript">
$(document).ready(function(){
$('.delBtn').click(function() { 
	var inum= $(this).closest("tr").find("td:eq(0)").text();
	var result = confirm('정말로 삭제하시겠습니까?');
	if(result) { 
		
		location.replace('removeInquiry.do?inum='+inum);
		} else {
			
		} 
	});
	
	$('.inquirytitle').click(function(){
		var inum =$(this).closest("tr").find("td:eq(0)").text();
		 location.href="inquiryView.do?inum="+inum;
	});
	
	$('button#searchInquiry').click(function(){
		 location.href="searchInquiry.do?keyword="+$('input#searchInquiryText').val();
	})
	
	
	
});
</script>

</head>
<body>
	<jsp:include page="../jsp/header.jsp" />

	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">고객센터</a></li>
				<li class="nav"><a class="nav" href="faq.do">자주 묻는 질문</a></li>
				<li class="active"><a class="nav" href="inquiry.do">1:1문의</a></li>
			</ul>
		</div>
	
		<div class="inquiryDiv">
		
		
		<div class="inquiryText">
		<h2 class="page-header">1:1문의</h2>
		ㆍ평균24시간 이내 답변됩니다.<br>
		ㆍ고객센터로 문의 가능합니다.<br>
		ㆍ전화번호, 주소, 이메일, 계좌번호 등의 개인정보는 타인에 의해 도용될 위험이 있으니,문의 시 입력하지 않도록 주의해 주시기 바랍니다.
		</div>
	
		 
					
		
	<div class="col-lg-6">
		<input type="button" id="inquiryBtn" value="1:1문의하기" onclick="location.href='registInquiryForm.do'">
    <div class="input-group">
      <input type="text" id="searchInquiryText" class="form-control"  placeholder="Search for...">
      <span class="input-group-btn">
        <button id="searchInquiry" class="btn btn-default" type="button">Search</button>
      </span>
    </div>
    </div>
  
		<table class="table" >
				<tr>
					<th width="10%" >문의번호</th>
					<th width="20%">문의유형</th>
					<th width="25%">문의제목</th>
					<th width="22%">문의날짜</th>
					<th width="13%">답변상태</th>
					<th width="10%">삭제</th>
				</tr>
			<c:forEach var="inquiry" items="${inquirylist}">
			<tr>
			<td class="inquirylist">${inquiry.inum}</td>
			<td class="inquirylist"><c:choose><c:when test="${inquiry.itype=='service'}">서비스 이용</c:when>
			<c:otherwise>사이트 이용</c:otherwise></c:choose>
			</td>
			<td class="inquirytitle">${inquiry.ititle}</td>
			<td class="inquirylist">${inquiry.idate}</td>
			<td class="inquirylist"><c:choose>
			<c:when test="${inquiry.istate=='yes'}">답변완료</c:when>
			<c:otherwise>답변대기중</c:otherwise></c:choose>
			<td class="inquirylist">
			<button class="delBtn"><img class="cancelImg" src="jsp/cancel.png" ></button>
			</td>
			</tr>
			
			</c:forEach>
				
	
				</table>
		
		
	
		</div>

	<jsp:include page="../jsp/footer.jsp" />
		

</body>
</html>