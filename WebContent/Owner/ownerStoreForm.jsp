<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가게정보 추가_사장님</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.main {
		margin : auto;
		margin-top: 50px;
		margin-bottom:100px;
		width: 100%;
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
	.contentsTitGroup{
		padding-top: 2.0rem;
	    text-align: center;
	    display: block;
	}
	.btn-view {
	    width: 100px;
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
	.w300 {
	    width: 300px;
	}
	.w70 {
	    width: 70px;
	}
	.btn-mint{
		background-color: #66ccff;
		color: #fff;
	}
	.inputRadio, .inputCheckbox{
	    margin: 0;
	    width: 15px;
	    height: 15px;
	    border: 0;
	    margin-right: 20px;
	}
	.inputTextArea{
		width:70%;
		height:200px;
		resize: none;
	}
	.formArea{
		vertical-align: middle;
		height: 40px;
    	line-height: 40px;
	}
	.formArea label{
		margin-left: 10px;
		vertical-align: middle;
    	line-height: 40px;
	}
	.formArea ul {
	    padding-inline-start: 0px;
	    overflow: hidden;
	    height: 100%;
	    width: 100%;
	    margin-bottom : 0px;
	}
	.formArea li {
	    vertical-align: middle;
	    display: block;
	    float: left;
	    overflow: hidden;
	    margin-right: 25px;
	}
	.spanPlat{
	    padding: 0;
	    width: 2%;
	    text-align: center;
	    display: block;
	    float: left;
	    line-height: 40px;
	    vertical-align: middle;
	}
	.spanText{
	    padding: 0;
	    width: 5%;
	    text-align: center;
	    display: block;
	    float: left;
	    line-height: 40px;
	    vertical-align: middle;
	}
	.ttip {
		position: relative;
		display: inline-block;
	}
	.ttiptext {
		visibility: hidden;
		width: 400px;
		background-color: #e6e6e6;
		text-align: center;
		padding: 5px 0;
		border-radius: 6px;
		position: absolute;
		margin-top: 5px;
		margin-left : 20px;
	}
	.top{
		width: 250px;
		bottom: 150%;
		left: 50%;
		margin-left: 0px;
	}
	.ttip:hover .ttiptext {
		visibility: visible;
	}
	.img30{
		margin-top: 10px;
		margin-left : 30px;
		width: 20px;
		height : 20px;
	}
	.storeImg{
		width : 70%;
		height : 250px;
	}
	.filebox{
		width : 70%;
		height : 50px;
	}
	.filebox label { 
		margin-top : 30px;
		display: inline-block; 
		vertical-align: middle;
		padding: .5em .75em; 
		color: #000000; 
		line-height: 25px;
		cursor: pointer; 
		border: 1px solid #000000; 
		height: 40px;
		float:right;
	} 
	.filebox input[type="file"] { 
		/* 파일 필드 숨기기 */ 
		position: absolute; 
		width: 1px; 
		height: 1px; 
		padding: 0; 
		margin: -1px; 
		overflow: hidden; 
		clip:rect(0,0,0,0); 
		border: 0; 
	}
	.btn-wrap {
		display: block;
		text-align: center;
	    width: 100%;
	    margin: 0 auto;
	    margin-bottom : 30px;
		padding-top: 4.5rem;
	}
	.cancelImg {
		width: 100%;
    	height: 100%;
	}
	.tl{
		text-align : left;
	}
	.delBtn {
	    padding: 0px;
	    width: 30px;
	    height: 30px;
	    border: 0px;
	    background-color: white;
	    outline: 0;
	}
</style>
<script type="text/javascript">
$(function(){
	$("#sfile").on("change",SelectImg);
}); 
</script>
<script type="text/javascript">
	var stag = new Array();
	var final_stag = new Array();
	var sel_files = [];
	function goPopup(){// 주소검색을 수행할 팝업 페이지를 호출합니다.
		var pop = window.open("jusoPopup.do?index=0","pop","width=570,height=420, scrollbars=yes, resizable=yes,left=400,top=300");
	}
	
	function jusoCallBack(roadAddrPart1,addrDetail,index){ 
		$("#storeaddr").val(roadAddrPart1);    
		$("#storeaddrDetail").val(addrDetail);    
	}
	
	function SelectImg(e){//이미지 미리보기
		var files = e.target.files;
		var filesArr = Array.prototype.slice.call(files);
		
		filesArr.forEach(function(f){
			sel_file = f;
			var reader = new FileReader();
			reader.onload = function(e){
				$("#simage").attr("src",e.target.result);
			}
			reader.readAsDataURL(f);
		});
	}
	
	function addTag(){ // 태그 추가
		var tagVal = $('#ttag').val();
		var tagStatus = $('#ttag option:checked').prop('disabled');
		if(tagStatus){
			alert('중복된 태그 입니다. 다시 선택해주세요');
		}else{
			var tagText = $('#ttag option:checked').text();
			var tagList = $('#themeTag').text();
			var deleteBtn = '<span style="margin-left:20px;" id="themeTag_'+tagVal+'">'+tagText;
			deleteBtn += '<button class="delBtn" type="button" onClick="delTag('+tagVal+')"><img class="cancelImg" src="/jsp/cancel.png"></button>';
			deleteBtn += '</span>';
			$('#tagDiv').append(deleteBtn);
			$('#ttag option:checked').attr('disabled','disabled');
			stag[stag.length] = tagVal;
		}
	}
	
	function delTag(val){ //태그 삭제
		$('#themeTag_'+val).remove();
		$('#ttag option[value*='+val+']').prop('disabled',false);
	}
	
	function addStore(){ //가맹점 등록
		if(confirm('이대로 등록하시겠습니까?')){
			$.each(stag,function(i,value){
			    if(final_stag.indexOf(value) == -1 ) final_stag.push(value);
			});
			var start_si = $('#start_si').val();
			var start_bun = $('#start_bun').val();
			var end_si = $('#end_si').val();
			var end_bun = $('#end_bun').val();
			
			$('#stime_start').val(start_si + start_bun);
			$('#stime_end').val(end_si + end_bun);
			$('#stag').val(final_stag);
			$('#frmList').submit();
		}
	}
</script>
</head>
<body>
	<jsp:include page="/jsp/header.jsp" />
	<div class="main">
		<div class="nav">
			<ul class="nav nav-pills nav-stacked">
				<li class="navTitle"><a class="navTitle">사장님 페이지</a></li>
				<li><a class="nav" href="ownerInfoForm.do">내 정보</a></li>
				<li class="active"><a class="nav" href="ownerStore.do">내 가게</a></li>
				<li><a class="nav" href="selectDetailsBySnum.do">예약현황</a></li>
			</ul>
		</div>
		<div class="container">
			<div class="contentsTitGroup">
				<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">가게 등록</h2>
			</div>
			<form id="frmList" action="insertStore.do" enctype="multipart/form-data" method="post">
				<input type="hidden" name="bid" value="${bid}">
				<input type="hidden" id="stime_start" name="stime_start" value="">
				<input type="hidden" id="stime_end" name="stime_end" value="">
				<table class="table">
					<colgroup>
						<col width="20%"/>
						<col width="*"/>
					</colgroup>
					<tr>
						<td><span style="color:red">* </span>가게 업종 분류</td>
						<td>
							<select class="inputText w300" name="stype">
								<c:forEach var="foodTag" items="${foodTagList}">
									<option value="${foodTag.anum}" <c:if test="${foodTag.anum == store.stype}">selected</c:if>>${foodTag.avalue}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>가게 이름</td>
						<td><input class="inputText w300" type="text" name="sname" id="sname" value="${store.sname}"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>주소</td>
						<td>
							<input class="inputText w300" type="text" id="storeaddr" name="saddress" required="required" readonly="readonly" value="${store.saddress}">
							<button type="button" class="btn-view btn-mint" onclick="goPopup();">주소검색</button>
						</td>
					</tr>
					<tr>
						<td>상세주소</td>
						<td><input class="inputText w300" type="text" id="storeaddrDetail" name="sdetailaddr" placeholder="상세주소를 입력해주세요" value="${store.sdetailaddr}"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>가게번호</td>
						<td><input class="inputText w300" type="text" id="sphone" name="sphone" placeholder="(-)제외한 변호를 입력해주세요" value="${store.sphone}"></td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>주차가능 여부</td>
						<td>
							<div class="formArea">
								<ul>
									<li>
										<input class="inputRadio" type="radio" name="sparking" id="sparking-y" value="yes" <c:if test="${store.sparking == 'yes' or store.sparking eq null}">checked</c:if>>
										<label for="sparking-y">가능</label>
									</li>
									<li>
										<input class="inputRadio" type="radio" name="sparking" id="sparking-n" value="no" <c:if test="${store.sparking == 'no'}">checked</c:if>>
										<label for="sparking-n">불가능</label>
									</li>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>예약가능 인원</td>
						<td>
							<input class="inputText w300" type="text" id="slimit" name="slimit" placeholder="최소 0명 이상 입력해주세요" value="${store.slimit}">
							<span class="spanPlat">명</span>
							<div class="ttip">
								<img class="img30" alt="" src="/jsp/question-mark.png">
								<span class="ttiptext">점심/저녁 시간대의 예약가능 최대 인원수 (기본값)</span>
							</div>
						</td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>영업시간 영업일</td>
						<td>
							<select class="inputText w70" id="start_si">
								<c:set var="n" value="0" />
								<c:forEach begin="0" end="23">
									<option value="${n}" <c:if test="${stime[0] == n}">selected</c:if>>${n }</option>
								<c:set var="n" value="${n+1}" />
								</c:forEach>
							</select>
							<span class="spanPlat">시</span>
							<select class="inputText w70" id="start_bun">
								<option value="00" <c:if test="${stime[1] == '00'}">selected</c:if>>00</option>
								<option value="30" <c:if test="${stime[1] == '30'}">selected</c:if>>30</option>
							</select> 
							<span class="spanPlat">분</span>
							<span class="spanPlat">~</span>
							<select class="inputText w70" id="end_si">
								<c:set var="n" value="0" />
								<c:forEach begin="0" end="23">
									<option value="${n}" <c:if test="${stime[2] == n}">selected</c:if>>${n }</option>
								<c:set var="n" value="${n+1}" />
								</c:forEach>
							</select>
							<span class="spanPlat">시</span>
							<select class="inputText w70" id="end_bun">
								<option value="00" <c:if test="${stime[3] == '00'}">selected</c:if>>00</option>
								<option value="30" <c:if test="${stime[3] == '30'}">selected</c:if>>30</option>
							</select>
							<span class="spanPlat">분</span>
						</td>
					</tr>
					<tr>
						<td>휴무일</td>
						<td>
							<div class="formArea">
								<ul>
									<li>
										<input class="inputCheckbox" type="checkbox" name="sholiday" value="mon" id="sholiday-mon" <c:if test="${sholiday.mon}">checked</c:if>>
										<label for="sholiday-mon">월요일</label>
									</li>
									<li>
										<input class="inputCheckbox" type="checkbox" name="sholiday" value="tue" id="sholiday-tue" <c:if test="${sholiday.tue}">checked</c:if>>
										<label for="sholiday-tue">화요일</label>
									</li>
									<li>
										<input class="inputCheckbox" type="checkbox" name="sholiday" value="wed" id="sholiday-wed" <c:if test="${sholiday.wed}">checked</c:if>>
										<label for="sholiday-wed">수요일</label>
									</li>
									<li>
										<input class="inputCheckbox" type="checkbox" name="sholiday" value="thu" id="sholiday-thu" <c:if test="${sholiday.thu}">checked</c:if>>
										<label for="sholiday-thu">목요일</label>
									</li>
									<li>
										<input class="inputCheckbox" type="checkbox" name="sholiday" value="fri" id="sholiday-fri" <c:if test="${sholiday.fri}">checked</c:if>>
										<label for="sholiday-fri">금요일</label>
									</li>
									<li>
										<input class="inputCheckbox" type="checkbox" name="sholiday" value="sat" id="sholiday-sat" <c:if test="${sholiday.sat}">checked</c:if>>
										<label for="sholiday-sat">토요일</label>
									</li>
									<li>
										<input class="inputCheckbox" type="checkbox" name="sholiday" value="sun" id="sholiday-sun" <c:if test="${sholiday.sun or (sholiday eq null)}">checked</c:if>>
										<label for="sholiday-sun">일요일</label>
									</li>
								</ul>
							</div>
						</td>
					</tr>
					<tr>
						<td><span style="color:red">* </span>멤버쉽</td>
						<td> 
							<span class="spanText">범골</span>
							<input class="inputText w70" type="text" id="sratelv0" name="sratelv0" placeholder="3%이상 " value="${store.sratelv0}">
							<span class="spanPlat">%</span>
							<span class="spanText">진골</span>
							<input class="inputText w70" type="text" id="sratelv1" name="sratelv1" placeholder="3%이상 " value="${store.sratelv1}">
							<span class="spanPlat">%</span>
							<span class="spanText">성골</span>
							<input class="inputText w70" type="text" id="sratelv2" name="sratelv2" placeholder="3%이상 " value="${store.sratelv2}">
							<span class="spanPlat">%</span>
							<span class="spanText">단골</span>
							<input class="inputText w70" type="text" id="sratelv3" name="sratelv3" placeholder="3%이상 " value="${store.sratelv3}">
							<span class="spanPlat">%</span>
						</td>
					</tr>
					<tr>
						<td>가게소개</td>
						<td>
							<textarea class="inputTextArea" name="sintro">${store.sintro}</textarea>
						</td>
					</tr>
					<tr>
						<td>가게이미지</td>
						<td>
							<c:if test="${store.simage eq null}">
								<img id="simage" class="storeImg" src="image_ready.png">
							</c:if>
							<c:if test="${store.simage ne null}">
								<img id="simage" class="storeImg" src="downloadStoreImg.do?snum=${store.snum}" >
							</c:if>
							<div class="filebox">
								<label for="sfile">이미지 업로드</label>
								<input id="sfile" type="file" name="sfile">
							</div>
						</td>
					</tr>
					<tr>
						<td>해시태그
							<div class="ttip">
								<img class="img30" alt="" src="/jsp/question-mark.png">
								<span class="ttiptext top">해시태그는 회원별 추천에 사용됩니다. (※태그최대 등록 갯수: 7개)</span>
							</div>
						</td>
						<td>
							<select class="inputText w300" id="ttag">
								<c:forEach var="themeTag" items="${themeTagList}">
									<option value="${themeTag.anum}">#${themeTag.avalue}</option>
								</c:forEach>
							</select>
							<button id="addBtn" type="button" class="btn-view btn-mint" onClick="addTag();">추가</button>
							<div id="tagDiv" class="btn-wrap tl">
							<c:forEach var="stag" items="${stagList}" varStatus="status">
								<span style="margin-left:20px;" id="themeTag_${stag}">
									<button class="delBtn" type="button" onClick="delTag('${stag}')"><img class="cancelImg" src="/jsp/cancel.png"></button>
								</span>
							</c:forEach>
							</div>
							<input id="stag" type="hidden" name="stag" value="">
						</td>
					</tr>
				</table>
				<div style="text-align: center;">
					<span style="color:red">* </span>표시는 필수 입력 사항입니다.
				</div>
				<div class="btn-wrap">
					<button class="btn-view w300" type="button" onClick="addStore();">가맹점 등록</button>
				</div>
			</form> 
		</div>
	</div>
	<jsp:include page="/jsp/footer.jsp" />
</body>
</html>