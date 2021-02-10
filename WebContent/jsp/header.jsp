<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	li {list-style: none; }
	div.header{
		display : block;
		width : 100%;
		height : 30%;
	}
	div.headerA{
		margin-left : 75%;
		clear : both;
	}
	div.headerB{
		display : inline-block;
	}
	div.headerB2{
		text-align : center;
		margin-top : 38px;
		margin-right : 10%;
	}
	div.headerSearch{
		margin-left : 10%;
		margin-top : 60px;
	}
	div.menuBar{
		width: 100%; 
		margin-bottom: 20px; 
		text-align: center; 
		height: 40px; 
		border-bottom : 2px solid #cccccc;
	}
	div.menuBar:after {
		content: ""; 
		display: block; 
		clear: both; 
	}
	a.headerA{
		padding : auto;
		margin-right : 30px;
		color : #000000;
	}
	a.headerA:hover{
		text-decoration: none;
		color : #66ccff;
	}
	img.headerImage{
		width : 330px;
		height : 120px;
		float : left;
	}
	img.myPageImage{
		width : 40px;
		height : 40px;
	}
	p.headerP{
		text-align : center;
		font-size : 30px;
		margin-top : 20px;
		font-weight : bold;
		font-family : '맑은고딕';
	}
	ul.menuBar{
		display: none; 
		padding: 20px 0; 
		text-align : center;
	}
	ul.menuTitle{
		width : 70%;
		margin : auto;
		clear : both;
		position: relative;
		overflow: hidden;
		z-index : 1;
	}
	ul.menuTitle > li {
		float: left; 
		width: 20%; 
		line-height: 40px;
	}
	li.subBar{
		float: none; 
	}
	a.menuTitle{
		font-size : 15px;
		font-weight: bold;
		color : #404040;
		font-family : '굴림체';
	}
	a.subTitle{
		font-size : 13px;
		color : #404040;
		font-family : '굴림체';
	}
	a.menuTitle:hover,a.subTitle:hover{
		text-decoration: none;
		color : #66ccff;
		cursor : pointer;
	} 
</style>
<script type="text/javascript">
	$(document).ready(function(){
		$("div.menuBar").hover(function(){
			$("ul.menuBar").css({'height':'250px'});
			$("ul.menuBar").css({'background-color':'#ffffff'});
			$("ul.menuBar").show();
		},function(){
			$("ul.menuBar").hide();
		});
		$('button#searchBtn').click(function(){
			location.href="search.do?keyword="+$('input#searchText').val();
		});
	});
</script>
</head>
<body>
	<div class="header">
		<p class="headerP">우리동네 단골들의 대표 서비스, 단골의 HERE<p>
		<hr style="border : solid 1px gray;">
		<div class="headerA">
			<c:choose>
				<c:when test="${mid!=null}">
					<a class="headerA"><b>${mid}님 환영합니다</b></a><a class="headerA" href="logout.do">로그아웃</a>
				</c:when>
				<c:when test="${bid!=null}">
					<a class="headerA"><b>사장 ${bid}님 환영합니다</b></a><a class="headerA" href="logout.do">로그아웃</a>
				</c:when>
				<c:otherwise>
					<a class="headerA" href="loginForm.do">로그인</a><a class="headerA" href="signUpForm.do">회원가입</a>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="headerB">
			<a href="main.do"><img class="headerImage" src="headerLogo.png"></a>
			<div class="col-md-6">
				<div class="headerSearch">
		           	<div class="input-group">
						<input type="text" id="searchText" class="form-control" placeholder="가게 이름을 입력 하세요" maxlength="25">
						<span class="input-group-btn">
							<button id="searchBtn" class="btn btn-info" type="button"><span class="glyphicon glyphicon-search" aria-hidden="true"></span></button>
						</span>
					</div>
				</div>
			</div>
			<div class="headerB2">
				<c:choose>
					<c:when test="${bid!=null}">
						<a href="ownerInfoForm.do"><img class="myPageImage" src="ceo.png"></a>
						<p>사장님 페이지</p>
					</c:when>
					<c:otherwise>
						<a href="myPage.do"><img class="myPageImage" src="myPage.png"></a>
						<p>마이 페이지</p>
					</c:otherwise>
				</c:choose>
			</div>
    	</div>
    	<div class="menuBar">
			<ul class="menuTitle">
				<li><a href="infoCompany.do" class="menuTitle">회사소개</a>
					<ul class="menuBar">
						<li class="subBar"><a class="subTitle" href="infoCompany.do">단골의 희열 소개</a></li>
						<li class="subBar"><a class="subTitle" href="infoService.do">서비스 소개</a></li>
						<li class="subBar"><a class="subTitle" href="infoBenefit.do">등급별 혜택</a></li>
						<li class="subBar"><a class="subTitle" href="infoStore.do">가맹점 현황</a></li>
						<li class="subBar">&nbsp;</li>
					</ul>
				</li>
				<li><a href="foodSort.do" class="menuTitle">카테고리</a>
					<ul class="menuBar">
						<li class="subBar"><a class="subTitle" href="foodSort.do">음식별</a></li>
						<li class="subBar"><a class="subTitle" href="themeSort.do">테마별</a></li>
						<li class="subBar"><a class="subTitle" href="areaSort.do">지역별</a></li>
						<li class="subBar"><a class="subTitle" href="recommendSort.do">추천별</a></li>
						<li class="subBar"><a class="subTitle" href="newStoreAll.do">신규매장</a></li>
					</ul>
				</li>
				<li><a href="selectEvents.do?status=all" class="menuTitle">이벤트 / 행사</a>
					<ul class="menuBar">
						<li class="subBar"><a href="selectEvents.do?status=ing" class="subTitle">진행중인 이벤트</a></li>
						<li class="subBar"><a href="selectEvents.do?status=ed" class="subTitle">종료된 이벤트</a></li>
						<li class="subBar">&nbsp;</li>
						<li class="subBar">&nbsp;</li>
						<li class="subBar">&nbsp;</li>
					</ul>
				</li>
				<li><a class="menuTitle" href="faq.do">고객센터</a>
					<ul class="menuBar">
						<li class="subBar"><a class="subTitle" href="faq.do">FAQ</a></li>
						<li class="subBar"><a class="subTitle"  href="inquiry.do">1:1 문의</a></li>
						<li class="subBar">&nbsp;</li>
						<li class="subBar">&nbsp;</li>
						<li class="subBar">&nbsp;</li>
					</ul>
				</li>
	  		</ul>
    	</div>
	</div>
</body>
</html>