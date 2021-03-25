<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사장님_회원가입</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.main {
		margin : auto;
		margin-top: 50px;
		margin-bottom: 100px;
		width: 35%;
		border: 1px solid #dedede;
	}
	.signFormtitle {
		text-align: center;
		margin-top: 20px;
		margin-bottom: 20px;
		font-size: 24px;
		font-weight: bold;
	}
	table.signForm {	
		margin : auto;		
		font-size: 15px;
	}
	table.signForm td {
		padding : 10px;
		height: 30px;
	}
	.tagText {
		text-align: center;
		height: 10px;
		font-weight: bold;
		font-size: 15px;
	}
	.inputText {
		height: 40px;
	    line-height: 40px;
	    color: #7b6e66;
	    padding: 0 7px;
	    border: 1px solid #7b6e66;
	    background-color: transparent;
	    vertical-align: middle;
	    float: left;
	}
	.btn-view {
	    width: 200px;
        font-size: 1.4rem;
        background-color: #fff;
		color: #000000;
	    height: 4rem;
	    margin: 0 auto;
	    line-height: 3.9rem;
		font-weight: 600;
	    letter-spacing: 0.5px;
	    transition-duration: .5s;
        border: 0.1rem solid #66ccff;
	}
	.btn-mint{
		background-color: #66ccff;
		color: #fff;
	}
	.btn-wrap {
		display: block;
		text-align: center;
	    width: 100%;
	    margin: 0 auto;
	    margin-bottom : 30px;
		padding-top: 4.5rem;
	}
	.contentsTitGroup{
		padding-top: 2.0rem;
	    text-align: center;
	    display: block;
	}

</style>

<script type="text/javascript">
 $(document).ready(function(){
	 $('#pwdCheck').blur(function(){
		if(($('#pwd').val()!="")){
			if(($('#pwd').val())==($('#pwdCheck').val())){
				$('#isPwdSame').text("비밀번호가 일치합니다");
				$('#isPwdSame').css({"color" : "green"});
			}else{
				$('#isPwdSame').text("비밀번호가 일치하지 않습니다");
		  		$('#isPwdSame').css({"color" : "red"});
			}
		}else{
			$('#isPwdSame').text("비밀번호를 입력해주세요");
	  		$('#isPwdSame').css({"color" : "red"});
		}
	});
		
			 var area0 = ["시/도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청도","전라도","경상북도","경상남도","제주도"];
			  var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
			   var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구"];
			   var area3 = ["대덕구","동구","서구","유성구","중구"];
			   var area4 = ["광산구","남구","동구","북구","서구"];
			   var area5 = ["남구","달서구","동구","북구","서구","수성구","중구"];
			   var area6 = ["남구","동구","북구","중구"];
			   var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구"];
			   var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시"];
			   var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시"];
			   var area10 = ["제천시","청주시","충주시","계룡시","공주시","논산시","보령시","서산시","아산시","천안시"];
			   var area11 = ["군산시","김제시","남원시","익산시","전주시","정읍시","광양시","나주시","목포시","순천시","여수시"];
			   var area12 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시"];
			   var area13 = ["서귀포시","제주시"];

			 

				 // 시/도 선택 박스 초기화

				 $("select[class=sido1]").each(function() {
				  $selsido = $(this);
				  $.each(eval(area0), function() {
					if(this=='시/도 선택'){
						$selsido.append("<option value=''>"+this+"</option>");
					}else{
						$selsido.append("<option value='"+this+"'>"+this+"</option>");
					}
				  });
				  $selsido.next().append("<option value=''>구선택</option>");
				 });
				 

				 // 시/도 선택시 구/군 설정

				 $("select[class=sido1]").change(function() {
				  var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구 Array
				  var $gu = $(this).next(); // 선택영역 구 객체
				  $("option",$gu).remove(); // 구 초기화

				  if(area == "area0")
				   $gu.append("<option value=''>구 선택</option>");
				  else {
				   $.each(eval(area), function() {
				    $gu.append("<option value='"+this+"'>"+this+"</option>");
				   });
				  }
				 });
			
		
				//휴대폰번호 형식
			 $('#joinBtn').click(function(){
				 var num=$('#bphone').val();
				var bphone= num.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
				 if(9<num.length &&num.length<12){
				$('#bphone').val(bphone);
				 }else{
					 $('#bphone').val("");
				 }
			 });
			  $('#joinBtn').click(function(){
				 var num=$('#sphone').val();
				var sphone= num.replace(/(^02.{0}|^01.{1}|[0-9]{3})([0-9]+)([0-9]{4})/,"$1-$2-$3");
				 if(9<num.length &&num.length<12){
			
				$('#sphone').val(sphone);
				 }else{
					 $('#sphone').val("");
				 }
			 })
				//회원가입 버튼 누를 때 제한 할 사항들
		 	$("#joinBtn").click(function(){
				if(($("#isPwdSame").text() =="비밀번호가 일치합니다") && ($("#canId").text()=="사용가능한 id 입니다") && ($("#bphone").val()!="")){
						}else{
							alert("필수항목을 다시 입력해주세요")
							$('form#signUp').attr("action","");
							
						}
					});
				//가게등록 버튼 누를 때 제한 할 사항들
			 	$("#StoreBtn").click(function(){
					if(($("sname").val()!="")&&($("sphone").val()!="")&&($("slimit").val()!="")
							&&($("#saddress").val()!="")&&($("sratelv0").val()!="")&&($("sratelv1").val()!="")&&($("sratelv2").val()!="")&&($("sratelv3").val()!="")){
							}else{
								alert("필수항목을 다시 입력해주세요")
								$('form#signUp').attr("action","");
								
							}
						});
}); 

</script>
<script type="text/javascript">
	function idCheck(){ //id 체크
		var bid = $('#bid').val();
		if(bid == ''){
			alert('id를 입력해주세요');			
		}else{
			$.ajax({
				url : 'checkId.do',
				data : {
					id : bid
				},
				type : 'get',
				success : function(data) {
					if (data) {
						$('#canId').text('사용가능한 id 입니다');
					} else {
						$('#canId').text('중복된 id 입니다.');
						$('#bid').val('');
					}
				}
			});
		}
	}
</script>
</head>
<body>
<jsp:include page="header.jsp" />
	<div class="main">
		<form action="insertBoss.do" id="signUp" method="post">
			<p class="signFormtitle">가맹점주 가입</p>
			<table class="signForm">
				<colgroup>
					<col width="30%">
					<col width="*">
					<col width="30%">
				</colgroup>
				<tbody>
					<tr>
						<td><span style="color:red">* </span>아이디</td>
						<td>
							<input type="text" class="inputText" id="bid" name="bid" maxlength="10" placeholder="특수문자 없이 10자이내">
						</td>
						<td>
							<button class="btn-view btn-mint" type="button" onclick="idCheck()" style="width:100px;">중복확인</button>
						</td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td colspan="2">
							<div id="canId"></div>
						</td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>비밀번호</td>
						<td colspan="2"><input type="password" class="inputText" id="pwd" name="bpw" maxlength="13" placeholder="공백없이 13자이내"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>비밀번호 확인</td>
						<td colspan="2"><input type="password"  class="inputText" id="pwdCheck" maxlength="13" placeholder="공백없이 13자이내"></td>
					</tr>
					<tr>
						<td>&nbsp;</td>
						<td id="isPwdSame" colspan="2"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>전화번호</td>
						<td>
							<input type="text" placeholder="(-)제외  11자리를 입력하세요" maxlength="11" id="bphone"  class="inputText" name="bphone">
						</td>
						<td id="phoneCheck"></td>
					<tr>
				</tbody>
			</table>
			<div class="contentsTitGroup">
				<h4 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);"><span style="color:red">* </span>표시는 필수 입력 사항입니다.</h4>
			</div>
			<div class="btn-wrap">
				<button class="btn-view btn-mint" onclick="" type="submit" id="joinBtn">가입하기</button>
			</div>
		</form> 
	</div>
	<jsp:include page="footer.jsp" />
</body>
</html>