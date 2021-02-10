<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>1:1문의_관리자화면</title>
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script type="text/javascript" async>

</script>
<style type="text/css">
	div.notice{
		border : 1px solid #000000;
		padding : 10px;
		padding-left : 100px;
	}
	div.main{
		display : inline;
		width : 100%;
	}
	div.nav{
		margin-top: 50px;
		float: left;
		width: 13%;
		margin-left: 50px;
	}
	div.section{
		margin-top : 50px;
		float : right;
		width : 60%;
		margin-right : 200px;
	}
	li.nav_active {
		background-color: #66ccff;
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
	$(document).on("click","#tr_inqurys",function(){
		$("#div_inquiry").hide();
		$("#div_ianswer").hide();
		
		/*상세보기 창 로드 */
		$("#div_inquiry").show();
		
		/*1:1문의 내용 가져오기*/
		$.get("selectOneInquiry.do?inum="+$(this).find('td:first').find('input').val(), function(data){
			var table = "";

			$('#table_inquiry tr:gt(0)').remove();
			
			table += '<tr>';
			table += '<th>구분</th>';
			table += '<td>' + data.itype + '</td>';
			table += '</tr>';
			table += '<tr>';
			table += '<th>제목</th>';
			table += '<td>' + data.ititle + '</td>';
			table += '</tr>';
			table += '<tr>';
			table += '<th>내용</th>';
			table += '<td>' + data.icontent + '</td>';
			table += '</tr>';
			table += '<tr>';
			table += '<th></th>';
			table += '<td><input type="hidden" id="inum" value=' + data.inum + '></td>';
			table += '</tr>';

			$('#table_inquiry tr:eq(0)').after(table);
		});

	});
	
	$(function(){
		/* 상세보기 및 답변등록 창은 숨겨져 있음 */
		$("#div_inquiry").hide();
		$("#div_ianswer").hide();
		
		/* 상세보기 창에서 창 닫기 버튼 누르면 사라짐 */
		$("#btn_inquiry_close").on("click", function(){
			$("#div_inquiry").hide();
			$("#div_ianswer").hide();
		})
		
		/* 상세보기 창에서 답변등록 버튼 클릭시 */
		$("#btn_ianswer_open").on("click", function(){
			/* 답변등록  관련 창 로드 */
			$("#div_ianswer").show();
			
			/* 답변 가져오기 */
			$.get("selectOneInquiry.do?inum="+$("#inum").val(), function(data){
				/* 답변이 없을 때 */
				if (data.ianswer == null) {
					$("#btn_ianswer_insert").show();
					
					var table = "";
					$('#table_ianswer tr:gt(0)').remove();
					
					table += '<tr>';
					table += '<th>답변</th>';
					table += '<td><input type="text" id="ianswer" placeholder="답변을 입력해주세요">' + '</td>';
					table += '</tr>';
					table += '<tr>';
					table += '<th></th>';
					table += '<td><input type="hidden" id="inum" value=' + data.inum + '>' + '</td>';
					table += '</tr>';
				}
				
				/* 답변이 있을 때 */
				else {
					$("#btn_ianswer_insert").hide();
					
					var table = "";
					$('#table_ianswer tr:gt(0)').remove();
					
					table += '<tr>';
					table += '<th>답변</th>';
					table += '<td><input type="text" disabled id="ianswer" value=' + data.ianswer + '>' + '</td>';
					table += '</tr>';
					table += '<tr>';
					table += '<th></th>';
					table += '<td><input type="hidden" id="inum" value=' + data.inum + '>' + '</td>';
					table += '</tr>';
				}
				
				$('#table_ianswer tr:eq(0)').after(table);
				
			});
		})
		
		/* 답변등록하기 */
		$("#btn_ianswer_insert").on("click", function(){
			if (confirm("답변을 등록하시겠습니까?")) {
				$.ajax({
					url : "insertInquiryAnswer.do",
					data :{
						inum : $("#inum").val(),
						ianswer : $("#ianswer").val(),
					},
					type : "post",
					success : function(){
						alert("답변이 성공적으로 등록되었습니다.");
						location.href="selectAllInquirys.do";
					},
					error :function(){
						alert("답변 등록이 실패했습니다.\n 관리자에게 문의해주세요");
					}
				});
			}
		})
		
		/* 답변등록 창에서 닫기 버튼 -> 사라짐 */
		$("#btn_ianswer_close").on("click", function(){
			$("#div_ianswer").hide();
		})
	
		/* 글 검색하기 */
		$("#btn_searchInquirys").on("click", function(){
				$.ajax({
					url : "searchInquirys.do",
					data :{
						type : $("#type").val(),
						keyword : $("#keyword").val(),
					},
					type : "post",
					success : function(data){
						$("#countAll").text("전체("+data.allSize+")");
						$("#countYes").text("답변완료("+data.yesSize+")");
						$("#countNo").text("미답변("+data.noSize+")");
						/* 게시글이 없을 때 */
						if (data == "") {
							alert("일치하는 게시글이 없습니다.");
							
						/* 게시글이 있을 때 */
						}else{
							var table = "";
							
							$('#table_inqurys tr:gt(0)').remove();
							
  							for( var key in data.member){
  								table += '<tr>';
								table += '<td>' + data.inquiry[key].itype + '</td>'; 
								table += '<td>' + data.member[key].mid + '</td>'; 
								table += '<td>' + data.inquiry[key].iphone + '</td>'; 
								table += '<td>' + data.inquiry[key].ititle + '</td>'; 
								table += '<td>' + data.inquiry[key].idate + '</td>'; 
								table += '<td>' + data.inquiry[key].istate + '</td>'; 
  								table += '</tr>';
							}
  							
							$('#table_inqurys tr:eq(0)').after(table);
						}
					},
					error :function(){
						alert("검색오류입니다.");
					}
				});
		})

	});
	</script>
</head>
<body>
<div class="notice">
	<h1>관리자 페이지입니다.</h1>
</div>
<div class="main">
	<!-- 사장님 네비게이션 -->
	<div class="nav">
		<ul class="nav nav-pills nav-stacked">
			<li class="navTitle"><a class="navTitle">화면이동</a></li>
			<li class="nav"><a href="adminRecommandTag.do" class="nav">추천태그</a></li>
			<li class="nav"><a href="adminThemeTag.do" class="nav">테마별 태그</a></li>
			<li class="nav"><a href="adminFoodTag.do" class="nav">업종별 태그</a></li>
			<li class="nav"><a href="adminTasteTag.do" class="nav">맛별 태그</a></li>
			<li class="nav_active"><a href="selectAllInquirys.do" class="nav">1:1문의</a></li>
			<li class="nav"><a href="logout.do" class="nav"><button>로그아웃</button></a></li>
		</ul>
	</div>
	<div class="section">
		<a id="countAll" href="selectAllInquirys.do">전체(${CountAll})</a>
		<a id="countYes" href="selectYesInquirys.do">답변완료(${CountYes})</a>
		<a id="countNo" href="selectNoInquirys.do">미답변(${CountNo})</a>
		
		<!-- 글 검색하기 -->
		<input type="text" id="keyword" placeholder="검색내용을 입력하세요">
		<select id="type">
			<option value="title" selected>제목으로 찾기</option>
			<option value="content" >내용으로 찾기</option>
			<option value="mid" >ID로 찾기</option>
		</select>
		<input type="submit" id="btn_searchInquirys" value="검색">
		<hr>
		<table id="table_inqurys">
			<tr>
				<th><input type="hidden"></th>
				<th>구분</th>
				<th>ID</th>
				<th>전화번호</th>
				<th>제목</th>
				<th>날짜</th>
				<th>답변여부</th>
			</tr>
				<c:forEach var="inquirys" items="${Inquirys}" varStatus="status">
				<tr id="tr_inqurys" style="cursor:pointer"
				 onmouseover="this.style.background='blue'; this.style.color='white'"
				 onmouseout="this.style.backgroundColor='white'; this.style.color='black'">
					<td><input type="hidden" value="${inquirys.inum}"></td>
					<td>${inquirys.itype}</td>
					<td>${Ids[status.index]}</td>
					<td>${Phones[status.index]}</td>
					<td>${inquirys.ititle}</td>
					<td><fmt:formatDate value="${inquirys.idate}" pattern="yy년 MM월 dd일"/></td>
					<td>${inquirys.istate}</td>
				</tr>
				</c:forEach>	
		</table>

		<!-- 게시글 상세보기 부분 -->
		<div id="div_inquiry">
			<hr>
			
			<h2>상세보기</h2>
		
			<table id="table_inquiry">
				<tr>
				</tr>
			</table>
			
			<input type="button" id="btn_inquiry_close" value="창 닫기">
			<input type="button" id="btn_ianswer_open" value="답변등록">
		</div>

		<!-- 답변등록 부분 -->
		<div id="div_ianswer">
			<hr>
			
			<h2>답변등록</h2>
			
				<table id="table_ianswer">
					<tr>
					</tr>
				</table>
				
				<input type="button" id="btn_ianswer_close" value="닫기">
				<input type="submit" id="btn_ianswer_insert" value="등록">
		</div>
	</div>
</div>
</body>
</html>