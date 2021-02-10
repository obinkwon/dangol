<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
.main {
	position: relative;
	margin-left: 300px;
	margin-bottom: 100px;
	margin-top : 100px;
	width: 700px;
	border: 1px solid #dedede;
}

.sub {
	position: relative;
	width: 700px;
}

.line {
	border: solid #000000;
	border-width: 1px;
}

.storeList {
	border: 2px solid;
	text-align: center;
}

img {
	width: 50px;
	height: 50px;
}
img.menuImg{
	margin-top :10px;
	margin-left : 160px;
	width : 130px;
	height : 100px;
}
#storeImg {
	width: 175px;
	height: 130px;
}
img#img2{
	width : 100%;
	height : 200px;
}
.plus {
	width: 80px;
	height: 80px;
}
p.img2{
	width : 70px;
}
.tagCancel{
width : 5px;
height:5px;}
</style>

<script type="text/javascript">
 $(document).ready(function(){
		$('#pwdCheck').blur(function(){
			if(($('#pwd').val()!="")){
				
				
				if(($('#pwd').val())==($('#pwdCheck').val())){
			  		$('#isPwdSame').text("비밀번호가 일치합니다");
				}
				else{
					$('#isPwdSame').text("비밀번호가 일치하지 않습니다");
			}
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
				 
				//태그 제한
				
				$('#addTag').click(function(){
					var tag = $('#tag').val();
				if(tag!=null){ //처음 값 append 막기
					
				$('#addLine').append('<tr><td><input type="text" name="tag" value="'+tag
						+'" readonly="readonly"></td><td><input type="button" class="delBtn"><img class="img1" src="jsp/cancel.png" ></td></tr>');
				$('#tag option:eq(0)').prop("selected", true); //select 초기값 설정
				var count=$('#addLine tr').length;
				 if(count<7){
					 $('#addTag').attr('disabled',false);
				}else {
					 $('#addTag').attr('disabled',true);					
				}	
						//태그삭제
						$('.delBtn').click(function(){
							$(this).closest('tr').remove();
							var count=$('#addLine tr').length;
			 			 if(count<7){
							 $('#addTag').attr('disabled',false);
							}else{
						 $('#addTag').attr('disabled',true);
						}  
						})
				 
				 
				}
				
				})
}); 

</script>
<script type="text/javascript">
	$(document).ready(function() {
		$('#overlap_check').attr("disabled", true);
		$('#bid').bind("click", function() {
			$('#overlap_check').attr("disabled", false);
			$('#overlap_check').click(function() {
				$.ajax({
					url : "checkId.do",
					data : {
						id : $('#bid').val()
					},
					type : "get",
					success : function(data) {
					
						if (data) {
						
							$('#canId').text("사용가능한 id 입니다");
						} else {
							
							$('#canId').text("중복된 id 입니다.");
							$('#bid').val("");

						}
					}
				})
			})
		})
		//추가한 메뉴 불러오기
	 	$('#addMenu').click(function(){
			$.ajax({
				url: "addMenuList.do",
				data:{
					oname:$('#omenu').val(),
					oprice:$('#oprice').val(),
					oimage:$('#oimage').val()},
				type: "post",
				success: function(data){
					var table = "";
					$('#addMenuList tr:eq(2)').remove();
					for( var key in data){
						table += '<tr>';
						table += '<td><input type="text" name="oimage" value="' + data[key].oimage + '" readonly="readonly"></td>';
						table += '<td><input type="text" name="oname" value="' + data[key].oname + '" readonly="readonly"></td>';
						table += '<td><input type="text" name="oprice" value="' + data[key].oprice + '" readonly="readonly"></td>';
						table += '<td><img src="jsp/cancel.png"</td>';
						table += '</tr>';
			
					} 
					$('#addMenuList tr:eq(1)').after(table);
				
				}	
			})
			
		}) 
		

	
	})
</script>
<script type="text/javascript">
	var sel_files = [];
	
	$(document).ready(function(){
		$("#file").on("change",SelectImg1);
		$("#file2").on("change",SelectImg2);
	});
	function SelectImg1(e){
		var files=e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			sel_file = f;
			var reader = new FileReader();
			reader.onload = function(e){
				$("#img").attr("src",e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	function SelectImg2(e){
		var files=e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			sel_file = f;
			var reader = new FileReader();
			reader.onload = function(e){
				$("#img2").attr("src",e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
</script>
</head>
<body>
	<jsp:include page="header.jsp" />
	<div class="main">
	<form action="insertBoss.do" id="signUp">
		<table class="sub">
			<tr>
				<td colspan="3"><p>가맹점주 가입</p></td>
			</tr>
			<tr>
				<td>*아이디</td>
				<td><input type="text" id="bid" name="bid"></td>
				<td><input type="button" value="중복확인" id="overlap_check"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="2"><div id="canId"></div></td>
			</tr>
			<tr>
				<td>*비밀번호</td>
				<td colspan="2"><input type="password" name="bpw" id="pwd"></td>
			</tr>
			<tr>
				<td>*비밀번호 확인</td>
				<td colspan="2"><input type="password" id="pwdCheck"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="2" id="isPwdSame"></td>
			</tr>
			<tr>
				<td>*전화번호</td>
				<td><input type="text" placeholder="(-)제외  13자리를 입력하세요"
					maxlength="13" id="bphone" name="bphone"></td>
		</table>
			
		<hr class="line">

		<table width="700px" class="storeList">
			<tr>
				<td rowspan="3" width="25%"><img src="jsp/cafe.jpg" id="storeImg"></td>
				<td width="50%">가게이름</td>
				<td rowspan="3" width="25%"><img src="jsp/cancel.png"></td>
			</tr>
			<tr>
				<td>주소</td>
			</tr>
			<tr>
				<td>전화번호</td>
			</tr>

			<tr>
				<td rowspan="3" colspan="3"><img src="jsp/plus.png"
					class="plus"></td>
			</tr>
		</table>
		
		
		<hr class="line">
		
		<table width="700px">
			<tr>
				<td>*가게 업종 분류</td>
				<td><select name="stype">
						<c:forEach var="foodTagList" items="${foodTagList}">
							<option value="${foodTagList.avalue}">#${foodTagList.avalue}</option>
						</c:forEach>
				</select></td>
			</tr>
			<tr>
				<td>*가게 이름</td>
				<td><input type="text" id="sname" name="sname"></td>
			</tr>
			<tr>
				<td>*주소</td>
					<td><select class="sido1" id="saddress" name="saddress"></select> <select
						class="sido1" name="saddress"></select></td>
			</tr>
			<tr>
				<td>상세주소</td>
				<td><input type="text" placeholder="상세주소를 입려해주세요" name="sdetailaddr"></td>
			</tr>
			<tr>
				<td>*가게번호</td>
				<td><input type="text" placeholder="(-)제외한 변호를 입력해주세요" id="sphone" name="sphone"></td>
			</tr>
			<tr>
				<td>*주차가능 여부</td>
				<td><input type="radio" name="sparking" value="yes" checked="checked">가능
					&nbsp;&nbsp; <input type="radio" name="sparking" value="no">불가능
				</td>
			</tr>
			<tr>
				<td>*예약가능 인원</td>
				<td><input type="text" id="slimit" name="slimit" placeholder="최소0명 이상 입력해주세요">명</td>
			<tr>
				<td colspan="2">&nbsp;&nbsp;&nbsp;&nbsp; 점심/저녁 시간대의 예약가능 최대 인원
					수 (기본값)</td>
			</tr>
			<tr>
				<td>*영업시간 영업일</td>
				<td><select name="stime">	 
 				<script>
				var i;
				for(i=0;i<24;i++){
				 document.write("<option>"+i+"시</option>");
				}
				</script>
				</select> <select name="stime">
						<option value="00분">00&nbsp;분</option>
						<option value="30분">30&nbsp;분</option>
				</select> ~
				<select name="stime">	 
 				<script>
				var i;
				for(i=0;i<24;i++){
				 document.write("<option>"+i+"시</option>");
				}
				</script>
				</select><select name="stime">
						<option value="00분">00&nbsp;분</option>
						<option value="30분">30&nbsp;분</option>
				</select></td>
			</tr>
			<tr>
				<td>휴무일</td>
				<td><input type="checkbox" name="sholiday" value="mon" >월요일</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="checkbox" name="sholiday" value="tue" >화요일</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="checkbox" name="sholiday" value="wed" >수요일</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="checkbox" name="sholiday" value="thu" >목요일</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="checkbox" name="sholiday" value="fri" >금요일</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="checkbox" name="sholiday" value="sat" >토요일</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td><input type="checkbox" name="sholiday" value="sun" checked="checked">일요일</td>
			</tr>
			<tr>
				<td>*멤버쉽</td>
				<td>범골 <input type="text" id="sratelv0" name="sratelv0" placeholder="3%이상 ">%
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>진골 <input type="text" id="sratelv1" name="sratelv1" placeholder="3%이상 ">%
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>성골 <input type="text" id="sratelv2" name="sratelv2" placeholder="3%이상 ">%
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>단골 <input type="text" id="sratelv3" name="sratelv3" placeholder="3%이상 ">%
				</td>
			</tr>
	
			<tr>
				<td>자기소개</td>
				<td><textarea class="form-control" name="sintro"rows="3"></textarea></td>
				
			</tr>
					</table>
		
	

		<table width="700px" id="addMenuList">
			<tr>
				<td colspan="2"><img id="img" class="menuImg" src="menu_ready.png"></td>
				<td><input id="file" type="file" name="ufile" id="oimage" ></td>
			</tr>
			<tr>
				<td rowspan="2" width="20%" >메뉴</td>
				<td width="30%"><input type="text" placeholder="메뉴명" id="omenu"></td>
				<td width="30%"><input type="text" placeholder="가격" id="oprice"></td>
				<td width="20%"><input type="button" id="addMenu" value="추가"></td>
			</tr>
		
		</table>
	
		<table width="700px">
			<tr>
					<td>해시태그</td>
					<td><select id="tag">
							<option  id="click" selected disabled hidden>#해시태그</option>
							<c:forEach var="themeList" items="${themeList}">
								<option value="${themeList.avalue}">#${themeList.avalue}</option>
							</c:forEach>
					</select>&nbsp;<input type="button" id="addTag" value="추가"></td>
				</tr>
				<tr>
					<td>&nbsp;</td>
					<td>
						<table id="addLine">
						
						</table>
					</td>
				</tr>
				<tr>
					<td colspan="2">해시태그는 회원별 추천에 사용됩니다.</td>
				</tr>
				<tr>
					<td colspan="2">※태그최대 등록 갯수: 7개</td>
				</tr>
			<tr>
				<td><p class="img2">가게이미지</p></td>
				<td><img id="img2" src="image_ready.png"></td>
			</tr>
			<tr>
				<td colspan="2"><input id="file2" type="file" name="ufile" id="simage" ></td>
			</tr>
		</table>
		<input type="button" id="storeBtn" value="가맹점 등록">
		*표시는 필수 입력 사항입니다.
		
		<input type="submit" id="joinBtn" value="가입하기">
		</form> 
	</div>
	<jsp:include page="footer.jsp" />
</body>
</body>
</html>