<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<link rel="stylesheet" href="/css/template.css" />
<meta charset="UTF-8">
<title>가게 상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.storeViewTop{
		width: 100%;
		height : 350px;
		text-align: center;
	}
	div.storeViewBottom{
		width: 100%;
		display : inline-block;
		margin-top : 15px;
	}
	div.storeLeft{
		float : left;
		width : 50%;
	}
	div.storeViewMain{
		width : 80%;
		margin : auto;
	}
	div.storeRight{
		float : right;
		width : 50%;
	}
	
	div.storeCommentOne{
		border-bottom : 2px solid #d9d9d9;
		height : 250px;
		padding-top : 5px;
	}
	div.reserveMenuOne{
		border-bottom : 2px solid #d9d9d9;
		height : 130px;
		padding-top : 5px;
	}
	div.reserveBottom{
		padding-top : 10px;
		border-top : 2px solid #d9d9d9;
	}
	div.noReserve{
		width : 80%;
		height : 400px;
		margin : auto;
		margin-top : 300px;
	}
	div.map{
		width : 100%;
		height : 300px;
	}
	img.storeCommentOne{
		margin-left : 10px;
		margin-right : 20px;
		border : 1px solid #000000;
		border-radius: 100px;
	}
	img.storeViewRight{
		margin-top : 10px; 
		margin-right : 100px;
		margin-left : 10px;
		border-radius: 0px;
		border : 1px solid #000000;
	}
	.storeTag{
		font-size : 14px;
		color : gray;
		margin-left : 20px;
	}
	.mLR20{
		margin-right : 20px;
		margin-left : 20px;
	}
	p.storeCommentOne{
		margin-right : 20px;
		margin-left : 20px;
	}
	p.reservePeople{
		margin-left : 20px;
		font-size : 15px;
		font-weight : bold;
		margin-top : 20px;
	}
	p.storeCommentOne > b{
		margin-right : 20px;
	}
	a.storeCommentOne:hover{
		color : #000000;
		text-decoration: none;
	}
	a.storeCommentOne:hover{
		cursor : pointer;
		color : gray;
	}
	a.storeCommentOne{
		font-size : 18px;
		font-weight : bold;
		color : #000000;
		margin-left : 10px;
	}
	li.star0,li.star1,li.star2,li.star3,li.star4{
		display: inline;
	}
	ul{
		padding-left : 0px;
		margin-right : 50px;
	}
	.storeTextarea{
		margin-left : 20px;
		resize: none;
		border-radius: 4px;
	}
</style>
<script type="text/javascript">
	function change(image){
		if(image.attr('src') == 'star-half.png'){
			image.attr('src','star.png');
		}else if(image.attr('src') == 'star-empty.png'){
			image.attr('src','star-half.png');	
		}else{
			image.attr('src','star-empty.png');	
		}
	}
	
	function calculate(index,type){//할인금액 계산함수
		var glevel = $('#danLevel').val();
		var	percent =  Number($('#glevel'+glevel).text());//단골 퍼센트
		var menuPrice = Number($('#menuPrice'+index).text());//메뉴 가격
		var price = Number($('#price').text());
		if(type == 'plus'){
			$('#price').text(price + menuPrice);
		}else{
			$('#price').text(price - menuPrice);
		}
		price = Number($('#price').text());
		var discount = price*percent/100;
		$('#discount').text(discount);
		$('#total').text(price-discount);
	}
	
	function numToStar(num,loc){//점수를 별로 바꾸는 함수
		var i = 0;		
		while (num > 0) {
			if(num == 0.5){
				loc.append("<li class='star"+i+"'><img class='img20' src='star-half.png'></li>");
			}else{
				loc.append("<li class='star"+i+"'><img class='img20' src='star.png'></li>");
			}
			i++;
			num--;
		}
		for(var j=i;j<5;j++){
			loc.append("<li class='star"+j+"'><img class='img20' src='star-empty.png'></li>");
		}
	}
	
	function menuBtn(index,type){//메뉴 마이너스 버튼 클릭시
		var val1 = $('#menuCnt'+index).val();
		var menuCount = Number(val1);
		if(menuCount > 0 && type == 'minus') {
			$('#menuCnt'+index).val(menuCount-1);
			calculate(index,type);
		}else if(type == 'plus'){
			$('#menuCnt'+index).val(menuCount+1);
			calculate(index,type);
		}
	}
	
	function personBtn(type){//예약 인원 버튼 클릭시
		var personCount = Number($('#dperson').val());
		if(personCount > 0 && type == 'minus'){
			$('#dperson').val(personCount-1);
		}else{
			$('#dperson').val(personCount+1);
		}
	}
	
	function likeBtn(loc){//좋아요 버튼 클릭시 이벤트
		var snum = $('#snum').val();
		var like = $(loc).find('img');
		if('${grade.glike}' != '') {
			location.href='likes.do?mid=${mid}&snum='+snum+'&like=${grade.glike}';
		}else{
			if('${mid}' == '') {
				alert('일반 사용자 로그인후 이용해주세요');
			}else {
				+alert('가게 이용후 이용해주세요');
			}
		}
	}
	
	function cancelBtn(){//예약취소 클릭시
		if(confirm("취소하면 입력한 데이터가 사라집니다.\n취소하시겠습니까?")){
			var menuSize = $('#menuList > tbody tr').length;
			$('#dperson').val(0);//예약인원
			$('#dask').val("");//요구사항
			$('#price').text("0");//할인전 금액
			$('#discount').text("0");//할인된 금액
			$('#total').text("0");//총 금액
			for(var i=0; i < menuSize; i++){//메뉴 별 주문갯수
				$('#menuCnt'+i).val(0);
			}
		}
	}
	
	function fnbhourList() {
		var hourList = [];
		for (var i = 0; i < 24; i++) {
	        var hourNm = (i <= 9 ? '0' : '') + i + ':' + '00';
	        var hourCd = (i <= 9 ? '0' : '') + i + '00';
	        var halfNm = (i <= 9 ? '0' : '') + i + ':' + '30';
	        var halfCd = (i <= 9 ? '0' : '') + i + '30';
	        
	        hourList.push({nm : hourNm, cd : hourCd});
	        hourList.push({nm : halfNm, cd : halfCd});
	    }
	    return hourList;
	};
	
	function getHours(selector, cd) {
	    if (cd == '') {
	        cd = '0000';
	    }
	    var nm = cd.substring(0,2) + ':' + cd.substring(2,4);
	    var option = '';
	    var hourList = fnbhourList();
	    for (var i = 0; i < hourList.length; i++) {
	        option = $('<option></option>');
	        option.text(hourList[i].nm);
	        option.val(hourList[i].cd);
	        if (cd == hourList[i].cd) {
	            option.prop('selected', true);
	        }
	        $(selector).append(option);
	    }
	    $(selector).closest('.storeSpan').find('.select-indi').text(nm);
	};
	
	function validationCheck(menuList){
		var reservePerson = $('#dperson').val();//예약 인원
		var reserveDate = $('#ddate').val();//예약 날짜
		
		if(menuList == ''){
			alert("메뉴를 한가지 이상 선택 해주세요");
			return false;
		}else if(reservePerson == 0){
			alert("인원을 선택해주세요");
			$('#dperson').focus();
			return false;
		}else if(reserveDate == ''){
			alert("예약날짜를 선택해주세요");
			$('#ddate').focus();
			return false;
		}
		return true;
	}
	
	function reserveBtn(){//예약완료 클릭시
		var menuSize = $('#menuList > tbody tr').length;
		var menuList='';
		for(var i=0; i < menuSize; i++){//예약 메뉴 리스트
			var menuCnt = $('#menuCnt'+i).val();
			var menuName = $('#menuName'+i).text()+'-'+menuCnt+"개";
			if(menuCnt > 0){
				if(menuList == ''){
					menuList += menuName;
				}else {
					menuList += ','+menuName;
				}
			}
		}
		
		if(validationCheck(menuList)) {
			if(confirm('예약 하시겠습니까?')){
				$('#dmenu').val(menuList);
				var $frmView = $('#frmView');
				var formAction = '/reserveStore.do';
				$frmView.attr("target","_self");
				$frmView.attr('action', formAction);
		        $frmView.submit();
			}
		}
	}
</script>
<script type="text/javascript">
$(document).ready(function(){
	getHours('#dtime', '<c:out value="${store.stime_start}"/>');
	
	switch ('${param.type}') {//선택 타입 유지
	case "my":
		$('#my').prop('selected','true');
		break;
	default :
		$('#new').prop('selected','true');
		break;
	}
	
	//점수를 별로 바꾸기
	for(i=0;i<${listSize};i++){
		var totalloc = $('div#comment'+i).children('table').find('tr:eq(1)').find('td:eq(1)').children('ul');
		var serviceloc = $('div#comment'+i).children('table').find('tr:eq(2)').find('td:eq(1)').children('ul');
		var priceloc = $('div#comment'+i).children('table').find('tr:eq(3)').find('td:eq(1)').children('ul');
		
		var total =  totalloc.find('li').text();//총점
		var service = serviceloc.find('li').text();//서비스
		var price = priceloc.find('li').text();//가격
		
		totalloc.find('li').remove();
		serviceloc.find('li').remove();
		priceloc.find('li').remove();
		
		numToStar(total,totalloc);
		numToStar(service,serviceloc);
		numToStar(price,priceloc);
	}
	
	$('#selectType').change(function(){
		var snum = $('#snum').val();
		location.href='storeView.do?snum='+snum+'&type='+this.value;
	});
	
	
	
	$('a#commentUpdate').click(function(){
		var cnum = $(this).siblings('input[type=hidden]').val();
		location.href="modifyCommentForm.do?cnum="+cnum;
	});
	
	$('a#commentDelete').click(function(){
		var snum = $('#snum').val();
		var cancel = confirm("정말 삭제 하시겠습니까?");
		if(cancel){
			var cnum = Number($(this).siblings('input[type=hidden]').val());
			location.href='removeComment.do?snum='+snum+'&cnum='+cnum;			
		}
	});
	
});
</script>
</head>
<body>
<jsp:include page="../jsp/header.jsp" />
	<div class="main">
		<div class="container">
			<div class="storeViewTop">
				<c:if test="${store.simage ne null}"><img src="downloadStoreImg.do?snum=${store.snum}"></c:if>
				<c:if test="${store.simage eq null}"><img src="image_ready.png"></c:if>
			</div>
			<form id="frmView" name="frmView" enctype="multipart/form-data" method="post">
			<input id="snum" name="snum" type="hidden" value="${store.snum}">
			<div class="storeViewBottom">
				<div class="storeViewMain">
					<div class="storeLeft">
						<span class="storeBoldSpan">${store.sname}</span><br />
						<span class="storeTag">
							<c:forEach var="stag" items="${tagList}">#${stag.avalue} </c:forEach>
						</span><br />
						<span class="storeSpan">${store.sintro}</span><br />
						<span class="storeSpan">
							<span class="glyphicon glyphicon-earphone" ></span>
							${store.sphone}  
							<a href="javascript:likeBtn(this);" class="imgBtn">
								<c:if test="${grade.glike == 1}"><img class="img50" src="mypage/likes.png"></c:if>
								<c:if test="${grade.glike != 1}"><img class="img50" src="mypage/dislike.png"></c:if>
							좋아요
							</a>
						</span><br />
						<%-- <jsp:include page="kakaoMap.jsp" /> --%>
						<span class="storeSpan"><span class="glyphicon glyphicon-map-marker"></span>  ${store.saddress} ${store.sdetailaddr}</span>
						<div class="storeViewBottom">
							<div class="storeLeft">
								<span class="storeSpan">
									<span class="glyphicon glyphicon-time"></span>  
									<fmt:parseDate var="startTime" value="${store.stime_start}"  pattern="HHmm"/>
									<fmt:formatDate value="${startTime}"  pattern="HH:mm"/> ~
									<fmt:parseDate var="endTime" value="${store.stime_end}"  pattern="HHmm"/>
									<fmt:formatDate value="${endTime}"  pattern="HH:mm"/>
								</span><br />
								<span class="storeSpan">휴무 : 
									<c:forEach var="holiday" items="${hoList}">
										${holiday}  
									</c:forEach>
								</span><br />
								<span class="storeSpan">
									<img class="img17" src="car-front.png">
									<c:if test="${store.sparking == 'yes'}">주차공간 있음</c:if>
									<c:if test="${store.sparking != 'yes'}">주차공간 없음</c:if>
								</span><br />
								<table>
									<tr>
										<td rowspan="4" style="vertical-align: top">
											<span class="storeSpan"><img class="img17" src="membership.png"></span>
										</td>
										<td><span class="storeSpan">단골</span></td>
										<td><span id="glevel3" class="storeSpan">${store.sratelv3}</span>%</td>
									</tr>
									<tr>
										<td><span class="storeSpan">성골</span></td>
										<td><span id="glevel2" class="storeSpan">${store.sratelv2}</span>%</td>
									</tr>
									<tr>
										<td><span class="storeSpan">진골</span></td>
										<td><span id="glevel1" class="storeSpan">${store.sratelv1}</span>%</td>
									</tr>
									<tr>
										<td><span class="storeSpan">범골</span></td>
										<td><span id="glevel0" class="storeSpan">${store.sratelv0}</span>%</td>
									</tr>
								</table><br />
								<table>
									<tr>
										<td rowspan="4" style="vertical-align: top">
											<span class="storeSpan"><span class="glyphicon glyphicon-user"></span></span>
											<input id="danLevel" type="hidden" value="${grade.glevel}">
										</td>
										<td><span class="storeSpan" <c:if test="${grade.glevel == 3}">style="color:red;"</c:if>>단골</span></td>
										<td><span class="storeSpan">${dangolMap.glevel3}명</span></td>
									</tr>
									<tr>
										<td><span class="storeSpan" <c:if test="${grade.glevel == 2}">style="color:red;"</c:if>>성골</span></td>
										<td><span class="storeSpan">${dangolMap.glevel2}명</span></td>
									</tr>
									<tr>
										<td><span class="storeSpan" <c:if test="${grade.glevel == 1}">style="color:red;"</c:if>>진골</span></td>
										<td><span class="storeSpan">${dangolMap.glevel1}명</span></td>
									</tr>
									<tr>
										<td><span class="storeSpan" <c:if test="${grade.glevel == 0}">style="color:red;"</c:if>>범골</span></td>
										<td><span class="storeSpan">${dangolMap.glevel0}명</span></td>
									</tr>
								</table>
							</div>
							<div class="storeRight">
								<div class="listHeader">메뉴판</div>
								<div class="listBottom h300">
								<table id="menuList" class="table table-striped">
									<colgroup>
										<col width="50%">
										<col width="*">
									</colgroup>
									<tbody>
									<c:forEach var="menu" items="${menuList}">
									<tr>
								    	<td>${menu.oname}</td>
								        <td>${menu.oprice}원</td>
								    </tr>
								    </c:forEach>
									</tbody>
								</table>
								</div>
							</div>
						</div>
						<div class="storeViewBottom">
							<span class="selectSpan">이용후기</span>
								<select id="selectType" class="inputText w100">
									<option id="new" value="new">전체</option>
									<c:if test="${mid!=null}">
										<option id="my" value="my">내글</option>
									</c:if>
								</select>
							<c:forEach var="commentMap" items="${commentMapList}" varStatus="status">
							<div class="storeCommentOne" id="comment${status.index}">
								<table>
									<tr>
										<td rowspan="4">
										<c:choose>
											<c:when test="${commentMap.mimage eq null}">
												<img class="storeCommentOne img100" src="myPage.png">
											</c:when>
											<c:otherwise>
												<img class="storeCommentOne img100" src="downloadMImage.do?mid=${commentMap.mid}">
											</c:otherwise>
										</c:choose>
										</td>
										<td><span class="mLR20">${commentMap.mid}</span></td>
										<td><span class="mLR20"><fmt:formatDate value="${commentMap.comment.cdate}" pattern="yyyy-MM-dd"/></span></td>
										<td rowspan="4">
										<input type="hidden" value="${commentMap.comment.cnum}">
										<c:if test="${commentMap.mid == mid}">
											<a id="commentUpdate" class="storeCommentOne">수정</a>
											<a id="commentDelete" class="storeCommentOne">삭제</a>
										</c:if>
										</td>
									</tr>
									<tr>
										<td><span class="mLR20">총점</span></td>
										<td>
											<ul>
												<li>${commentMap.comment.ctotal}</li>
											</ul>
										</td>
									</tr>
									<tr>
										<td><span class="mLR20">서비스</span></td>
										<td>
											<ul>
												<li>${commentMap.comment.cservice}</li>
											</ul>
										</td>
									</tr>
									<tr>
										<td><span class="mLR20">가격</span></td>
										<td>
											<ul>
												<li>${commentMap.comment.cprice}</li>
											</ul>
										</td>
									</tr>
								</table>
								<span class="mLR20"><b>맛</b> 
								<c:forTokens var="taste" items="${commentMap.comment.ctaste}" delims=",">
								${taste}
								</c:forTokens>
								</span>
								<span class="mLR20"><b>후기</b></span>
								<textarea class="storeTextarea" cols="63" rows="2" readonly="readonly">${commentMap.comment.creview}</textarea>
							</div>
							</c:forEach>
						</div>
					</div>
					<div class="storeRight h1000">
					<c:choose>
					<c:when test="${mid==null}"><!-- 일반 로그인을 하지 않았을때 -->
						<div class="noReserve"><img src="noReserve.png"></div>
					</c:when>
					<c:when test="${store.slimit==0}"><!-- 가게가 예약을 받지않을때 -->
						<div class="noReserve"><img src="noReserve2.png"></div>
					</c:when>
					<c:otherwise><!-- 로그인을 했을때 -->
						<div class="listHeader" style="margin-left:20px;">예약</div>
						<div class="listBottom reserveList h500">
							<c:forEach var="menu" items="${menuList}" varStatus="status">
							<div class="reserveMenuOne" id="menu${status.index}">
							<table>
								<tr>
									<td rowspan="3">
										<c:if test="${menu.oimage ne null}">
											<img class="storeViewRight img100"src="downloadStoreMenuImg.do?ord=${menu.ord}&snum=${store.snum}">
										</c:if>
										<c:if test="${menu.oimage eq null}">
											<img class="storeViewRight img100"src="menu_ready.png">
										</c:if>
									</td>
									<td>
										<input type="hidden" value="${menu.ord}">
										<span id="menuName${status.index}" class="storeSpan">${menu.oname}</span>
									</td>
								</tr>
								<tr>
									<td>
										<span class="storeSpan">
											<img class="img20" src="minus.png" onClick="menuBtn('${status.index}','minus');">
											<input id="menuCnt${status.index}" class="img20" type="text" value="0"> 
											<img class="img20" src="plus.png" onClick="menuBtn('${status.index}','plus');"> 
										</span>
									</td>
								</tr>
								<tr>
									<td><span id="menuPrice${status.index}" class="storeSpan">${menu.oprice}</span>원</td>
								</tr>
							</table>
							</div>
							</c:forEach>
						</div>
						<div>
							<span class="selectSpan storeSpan">예약 인원</span>
							<img class="img20" src="minus.png" style="margin-left:30px;" onClick="personBtn('minus');">
							<input id="dperson" name="dperson" class="img20" type="text" value="0"> 
							<img class="img20" src="plus.png" onClick="personBtn('plus');"> 명<br />
							<span class="selectSpan storeSpan">예약 날짜</span> 
							<input id="ddate" name="ddate" type="date" class="inputText w200" min="${currentDate}" value="${currentDate}" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}" ><br />
							<span class="selectSpan storeSpan">예약 시간</span> 
							<select class="inputText w200" id="dtime" name="dtime" title="예약 시간 선택"></select><br />
							<span class="selectSpan storeSpan">요구사항</span>
							<textarea id="dask" name="dask" cols="57" rows="2" class="storeTextarea"></textarea>
							<input id="dmenu" name="dmenu" type="hidden" value="">
						</div>
						<div class="reserveBottom">
							<table>
								<tr>
									<td><span class="storeSpan">할인전 금액</span></td>
									<td><span id="price" class="storeSpan">0</span>원</td>
								</tr>
								<tr>
									<td><span class="storeSpan">할인 금액</span></td>
									<td><span id="discount" class="storeSpan">0</span>원</td>
								</tr>
								<tr>
									<td><span class="storeSpan">총 금액</span></td>
									<td><span id="total" class="storeSpan">0</span>원</td>
								</tr>
							</table>
							<div class="btn-wrap">
								<button class="btn-view" type="button"  style="margin-right:20px;" onClick="cancelBtn();">예약취소</button>
								<button class="btn-view" type="button" onClick="reserveBtn();">예약완료</button>
							</div>
						</div>
					</c:otherwise>
					</c:choose>
					</div>
				</div>
			</div>
			</form>
		</div>
	</div>
<jsp:include page="../jsp/footer.jsp" />	
</body>
</html>