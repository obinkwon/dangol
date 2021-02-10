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

div.faqTitle {
	position: relative;
	margin-left: 22%;
	border: 1px solid;
	width: 60%;
}

div.faqDiv {
	float: right;
	margin-bottom:30px;
}

select.faqSelect {
	width: 140px;
	height: 30px;
}

div.faqList {
	display: inline-block;
	width: 60%;
	margin-left: 10%;
}

table.table {
	width: 100%;
	border-top:2px solid #66ccff;
}

table.table th, table.table td {
	padding-left: 20px;
   height: 40px;
}

table.table th {
	text-align:center;
}
table.table td {
	height: 40px;
}
table.table td.no{
text-align:center;
}
p.faqTitle{
font-weight : bold;
font-size: 17px;
margin-top: 30px;
margin-left: 40px;
font-size: 17px;
margin-bottom: 20px;
color: #66ccff;
}
p.faqContent{
font-size: 15px;
line-height:200%;
margin-left: 40px;
}
p.faq{
margin-top:20px;
margin-bottom:20px;
color:#808080;
margin-left: 40px;
}
h2.page-header{
marging-top:100px;
margin-left:50px;
margin-bottom:30px;
font-weight: 500;
}
</style>
<script type="text/javascript">
	$(document).ready(function(){

		$('#faqSelect').change(function(){
			location.href="faq.do?type="+this.value;
			//var select =$(this).val();
		});
		if(${param.type=="service"}){
			$("#service").prop('selected','true');
		}
		else if(${param.type=="site"}){
				$("#site").prop('selected','true');
			}else{
				$("#all").prop('selected','true');
			}
		
		for(var i =1; i<4;i++){
			$('#panel'+i).hide();
		/* 	$('#'+i).click(function(){
				$('#panel'+i).slideDown("fast");	
			}); */
		}
 		$('#1').click(function(){
			$('#panel1').slideToggle();	
		})
		$('#2').click(function(){
			$('#panel2').slideToggle();	
		})
		$('#3').click(function(){
			$('#panel3').slideToggle();	
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
				<li class="active"><a class="nav" href="faq.do">자주 묻는 질문</a></li>
				<li class="nav"><a class="nav" href="inquiry.do">1:1문의</a></li>
			</ul>
		</div>
	
		<div class="faqList">
		<h2 class="page-header"> 자주묻는 질문 </h2>
		<div class="faqDiv">
		<select class="faqSelect" id="faqSelect">
		<option id="all" value="all">전체</option>
		<option id="service" value="service">서비스 이용</option>
		<option id="site" value="site">사이트 이용</option>
		</select>
		</div>
			<table class="table">
				<tr>
					<th width="10%">글번호</th>
					<th width="25%">분류</th>
					<th width="65%">질문내용</th>
				</tr>
				<tbody id="faqBody">
					<tr id="1">
						<td class="no">1</td>
						<td class="no">서비스 이용</td>
						<td>멤버십 할인 기준은 어떻게 되나요?</td>
					</tr>
					<tr id="panel1">
						<td colspan="3"><p class="faqTitle">√ 회사소개 > 등급별 혜택에서 확인 가능</p>
					<p class="faqContent">ㆍ멤버십은 매장별 이용횟수로 산출됩니다.<br>ㆍ이용횟수가 12회 이하인 경우 범골등급, 24회 이하인 경우 진골등급, 48회 이하인 경우 성골등급, 48회 초과인 경우 단골등급에 해당됩니다.<br>ㆍ총 구매건수는 리뷰작성 기준입니다.<br>ㆍ혜택은 매장 별로 다를 수 있습니다.
					</p>
					<p class="faq">답변이 충분하지 않으셨다면, 1:1문의를 이용해 주세요.</p>
					</td>
					</tr>
					<tr id="2">
						<td class="no">2</td>
						<td class="no">서비스 이용</td>
						<td>멤버십 할인 기준은 각 매장마다 다른가요?</td>
					</tr>
					<tr id="panel2">
						<td colspan="3"><p class="faqTitle">√ 멤버십 할인은 매장/지점별로 상이 할 수 있습니다.</p>
					<p class="faqContent">ㆍ멤버십은 매장별 이용횟수로 산출됩니다.<br>ㆍ혜택은 매장 별로 다를 수 있습니다.</p>
					<p class="faq">답변이 충분하지 않으셨다면, 1:1문의를 이용해 주세요.</p></td>
					</tr>
					<tr id="3">

						<td class="no">3</td>
						<td class="no">서비스 이용</td>
						<td>후기를 꼭 작성해야 하나요?</td>
					</tr>

					<tr id="panel3">
						<td colspan="3"><p class="faqTitle">√후기작성은 필수 사항이 아닙니다.</p>
						<p class="faqContent">ㆍ이용후기 작성은 필수사항이 아닙니다.그러나 후기를 작성하셔야만 이용횟수가 산정되어 매장별 혜택을 받을수 있습니다.</p>
						<p class="faq">답변이 충분하지 않으셨다면, 1:1문의를 이용해 주세요.</p></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	<jsp:include page="../jsp/footer.jsp" />

</body>
</html>