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
	width: 50%;
	height:600px;
	margin-left: 12%;
	margin-top:3%;
		border:2px solid #999999;
		  border-radius: 20px;
}
table.insertTable {
	margin-top:20px;
	margin-left:30px;
	width: 90%;
}
table.insertTable td{
padding:9px;}
p{
font-size:15px;
}
.title{
width:400px;
height:30px;
}
.pwd{
height:30px;
}

textarea.textarea{
width:400px;
height:150px;
resize: none;
}
textarea.textareaAnswer{
width:400px;
height:150px;
background-color: #e6f7ff;
font-weight: bold;
resize: none;
}
div.btn{
margin-top:10px;
margin-right:40px;
float:right;

}
.delBtn{
	background-color: #66ccff;
	border: none;
	color: white;
	width: 100px;
	height: 30px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 18px;
	cursor: pointer;
}
.inquiryBtn{
margin-left:30px;
	background-color: #66ccff;
	border: none;
	color: white;
	width: 100px;
	height: 30px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 18px;
	cursor: pointer;
}
div.Div{
	display: inline-block;
	width: 65%;
	margin-left: 15%;
}
.idate{
margin-left:50px;
}

</style>
<script type="text/javascript">
$(document).ready(function(){
$('.inquiryBtn').click(function(){
	 location.href="inquiry.do";
	
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
	
	<div class="Div">
		<h2 class="page-header">1:1문의</h2></div>
		<div class="inquiryDiv">
		<table class="insertTable">
		<tr>
		<td width="30%"><p><b>제목</b></p></td>
		<td width="70%"><input type="text" value="${inquiry.ititle}" class="title" readonly="readonly"></td>
		</tr>
		<tr>
		<td><p><b>문의구분</b></p></td>
		<td><c:choose>
		<c:when test="${inquiry.itype=='service'}">서비스이용</c:when>
		<c:otherwise>사이트이용</c:otherwise>
		</c:choose>
		<span class="idate"><b>문의날짜</b></span>
		<span  style="margin-left:40px;">${inquiry.idate}</sapn></td></tr>
		<tr>
		<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
		<td><p><b>문의내용</b></p></td>
		<td><textarea class="textarea" readonly="readonly">${inquiry.icontent}</textarea></td>
		</tr>
		<tr>
		<td><b>답변내용</b></td>
		<td><textarea class="textareaAnswer"  readonly="readonly">${inquiry.ianswer}</textarea></td>
		</tr>
		</table>
		<div class="btn">
		<input type="button"  class="inquiryBtn" value="목록">
		</div>
		</div>
	
				</div>
				

	<jsp:include page="../jsp/footer.jsp" />

</body>
</html>