<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>footer</title>
<style type="text/css">
	div.footer{
		display : inline-block;
		width : 100%;
		height : 8%;
	}
	div.footerTop{
		display : inline;
	}
	div.footerBottom{
		display : inline;
		margin : auto;
		margin-left : 100px;
	}
	div.footerLeft{
		float : left;
		margin-right : 150px;
		margin-left : 50px;
	}
	img.footerImage{
		width : 260px;
		height : 100px;
	}
	img.massenger{
		width : 60px;
		height : 60px;
		margin-right : 200px;
	}
	p.footerP{
		margin : 0px;
	}
	p.footerGrey{
		margin : 0px;
		color : gray;
	}
	p.copyright{
		color : gray;
		margin-left : 100px;
	}
</style>
</head>
<body>
	<div class="footer">
	<hr style="border : solid 1px gray;">
		<div class="footerTop">
			<div class="footerLeft">
				<img class="footerImage"src="footerLogo.png">
			</div>
			<div>
				<p class="footerP">(주)단골의 희열 (대표이사 : 오랑께)&nbsp;&nbsp;&nbsp;서울특별시 강남구 테헤란로 212</p>
				<p class="footerP">사업자 등록번호 - 181-81-81818</p>
				<p class="footerP">대표전화 8282-8282</p>
				<p class="footerP">가맹점 문의 010-8701-2302</p>
				<p class="footerGrey">COPYRIGHT@HERE INC. ALL RIGHTS RESERVED.</p>
			</div>
		</div>
		<br>
		<div class="footerBottom">
			<a href="https://www.facebook.com/" target="self"><img class="massenger" src="facebook.png"></a>
			<a href="https://www.youtube.com/" target="self"><img class="massenger" src="youtube.png"></a>
			<a href="https://www.instagram.com/?hl=ko" target="self"><img class="massenger" src="instagram.png"></a>
			<a href="https://www.kakaocorp.com/" target="self"><img class="massenger" src="kakao.png"></a>
		</div>
		<br><br>
		<p class="copyright">본 사이트의 콘텐츠는 저작권법의 보호를 받는바, 무단 전재, 복사, 배포 등을 금합니다.</p>
	</div>
</body>
</html>