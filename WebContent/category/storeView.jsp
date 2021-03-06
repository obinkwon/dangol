<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<link rel="icon" href="favicon.png">
<meta charset="UTF-8">
<title>가게 상세보기</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<style type="text/css">
	div.storeViewTop{
		width : 100%;
		height : 350px;
		margin-top : 20px;
		text-align: center;
	}
	div.storeViewBottom{
		width : 100%;
		display : inline-block;
		margin-top : 15px;
	}
	div.storeViewMain{
		width : 80%;
		margin : auto;
	}
	div.storeViewLeft,div.storeMenuLeft{
		float : left;
		width : 50%;
	}
	div.storeViewRight,div.storeMenuRight{
		float : right;
		width : 50%;
	}
	div.storeViewRight{
		height : 1000px;
	}
	div.storeMenu{
		width : 100%;
		display : inline-block;
	}
	div.menuList,div.reserveMenu{
		overflow: auto;
		height : 300px;
	}
	div.reserveMenu{
		margin-left : 20px;
		height : 500px;
		border : 1px solid #d9d9d9;
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
	img.storeViewMain{
		width : 80%;
		height : 350px;
	}
	img.storeParking,img.storeMembership{
		width : 17px;
		height : 17px;
	}
	img.storeCommentOne,img.storeViewRight{
		margin-left : 10px;
		margin-right : 20px;
		width : 100px;
		height : 100px;	
		border : 1px solid #000000;
		border-radius: 100px;
	}
	img.commentStar,img.reserveMenu,img.reservePeople{
		width : 20px;
		height : 20px;
	}
	img.reserveMenu:hover,img.reservePeople:hover{
		cursor: pointer;
	}
	img.reservePeople{
		margin-left : 170px;
	}
	img.storeViewRight{
		margin-top : 10px; 
		margin-right : 100px;
		border-radius: 0px;
	}
	img.likes {
		width: 50px;
		height: 50px;
	}
	p.storeName,p.storeViewRight{
		font-size : 24px;
		font-weight : bold;
		margin-left : 20px;
	}
	p.storeViewRight{
		text-align : center;
		margin-bottom : 0px;
		background-color : #d9d9d9;
	}
	p.storeTag{
		font-size : 14px;
		color : gray;
		margin-left : 20px;
	}
	p.storeIntro{
		font-size : 18px;
		margin-left : 20px;
	}
	p.storePhone,p.storeAddress,p.storeTime,p.storeParking,p.storeMembership{
		font-size : 15px;
		font-weight : bold;
		margin-left : 20px;
	}
	p.menuList{
		font-size : 18px; 
		padding-top : 7px;
		padding-left : 15px;
		border-radius : 4px;	
		background-color : #d9d9d9;
		height : 40px;
		margin-bottom : 0px;
		font-weight : bold;
	}
	p.storeCommentOne{
		margin-right : 20px;
		margin-left : 20px;
	}
	p.storeCommentOne > b{
		margin-right : 20px;
	}
	p.reserveMenu,p.reservePeople{
		margin-left : 20px;
		font-size : 15px;
		font-weight : bold;
	}
	p.reservePeople{
		margin-top : 20px;
		
	}
	a.storeCommentList{
		font-size : 18px;
		font-weight : bold;
		color : #000000;
		margin : 20px;
	}
	a.storeCommentList:hover,a.storeCommentOne:hover,a.likes:hover{
		color : #000000;
		text-decoration: none;
	}
	a.storeCommentOne:hover,a.likes:hover{
		cursor : pointer;
		color : gray;
	}
	a.storeCommentOne{
		font-size : 18px;
		font-weight : bold;
		color : #000000;
		margin-left : 10px;
	}
	a.likes{
		margin-left : 170px;
		color : #000000;
	}
	select#selectType{
		width : 100px;
		height : 30px;
		margin-left : 250px;
		margin-bottom : 10px;
	}
	li.star0,li.star1,li.star2,li.star3,li.star4{
		display: inline;
	}
	ul{
		padding-left : 0px;
		margin-right : 50px;
	}
	textarea.storeCommentOne{
		margin-left : 20px;
		resize: none;
		border-radius: 4px;
	}
	span.reserveMenu{
		margin-left : 155px;
	}
	input.currentDate,input.reserveBtn{
		width : 262px;
		text-align : center;
		border : 1px solid #d9d9d9;
	}
	input.reserveBtn{
		width : 100px;
		margin-left : 100px;
		margin-top : 50px;
	}
	input#reserveBtn{
		float: right;
		margin-left : 0px;
		margin-right : 100px;
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
</script>
<script type="text/javascript">
$(document).ready(function(){
	function numToStar(num,loc){//점수를 별로 바꾸는 함수
		var i = 0;		
		while (num > 0) {
			if(num == 0.5){
				loc.append("<li class='star"+i+"'><img class='commentStar' src='star-half.png'></li>");
			}else{
				loc.append("<li class='star"+i+"'><img class='commentStar' src='star.png'></li>");
			}
			i++;
			num--;
		}
		for(var j=i;j<5;j++){
			loc.append("<li class='star"+j+"'><img class='commentStar' src='star-empty.png'></li>");
		}
	}
	function calculate(loc,type){//할인금액 계산함수
		var percent = 0;
		var menuPrice = Number(loc.parents('table').find('span#menuPrice').text());
		var price = Number($('span#price').text());
		if(type=='plus'){
			$('span#price').text(price + menuPrice);
		}else{
			$('span#price').text(price - menuPrice);
		}
		price = Number($('span#price').text());
		switch ("${grade.glevel}") {
		case "1":
			percent = ${store.sratelv1};
			break;
		case "2":
			percent = ${store.sratelv2};
			break;
		case "3":
			percent = ${store.sratelv3};
			break;
		default:
			percent = ${store.sratelv0};
			break;
		}
		$('span#discount').text(price*percent/100);
		var discount = Number($('span#discount').text());
		$('span#total').text(price-discount);
	}
	switch ('${param.type}') {//선택 타입 유지
	case "my":
		$('#my').prop('selected','true');
		break;
	default :
		$('#new').prop('selected','true');
		break;
	}
	if(${grade.glevel==1}) $('p#glevel1').css({'color':'red'});
	else if(${grade.glevel==2}) $('p#glevel2').css({'color':'red'});
	else if(${grade.glevel==3}) $('p#glevel3').css({'color':'red'});
	else $('p#glevel0').css({'color':'red'});
	
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
	
	$('a.likes').click(function(){//좋아요 버튼 클릭시 이벤트
		var like = $(this).find('img');
		if('${grade.glike}'!='') {
			location.href="likes.do?mid=${mid}&snum=${store.snum}&like=${grade.glike}";
		}else{
			if('${mid}'=='') alert('일반 사용자 로그인후 이용해주세요');
			else alert('가게 이용후 이용해주세요');
		}
	});
	$('input.currentDate').change(function(){//날짜 선택 할시 이벤트 
		$(this).val();
	});
	$('input#reserveBtn').click(function(){//예약완료 클릭할시
		var menuList='';
		for(var i=0;i<${menuSize};i++){
			var menu = Number($('#menu'+i).children('table').find('tr:eq(1)').find('span').text());
			var menuName = $('#menu'+i).children('table').find('tr:eq(0)').find('td:eq(1)').find('p.reserveMenu').text()+menu+"개";
			if(menu > 0){
				if(menuList=='') menuList += menuName;
				else menuList += ','+menuName;
			}
		}
		var reservePerson = $('#personMinus').siblings('span').text();
		var reserveTime = $('#hour').val()+"시"+$('#time').val()+"분";
		var reserveDate = $('#rdate').val();
		var reserveAsk = $('#request').val();
		if(menuList=='') alert("메뉴를 한가지 이상 선택 해주세요");
		else if(reservePerson==0) alert("인원을 선택해주세요");
		else{
			location.href="reserveStore.do?dperson="+reservePerson+"&ddate="+reserveDate+"&dtime="+reserveTime
					+"&dask="+reserveAsk+"&dmenu="+menuList+"&snum=${store.snum}";
		}
	});
	$('img#menuMinus').click(function(){//메뉴 - 버튼 누를때 이벤트
		var loc = $(this);
		var type = 'minus';
		var menuCount = $(this).parent('p.reserveMenu').text();
		if(menuCount!=0) {
			$(this).parent('p.reserveMenu').children('span').text(menuCount-1);
			calculate(loc,type);
		}
	});
	$('img#menuPlus').click(function(){//메뉴 + 버튼 누를때 이벤트
		var loc = $(this);
		var type = 'plus';
		var menuCount = $(this).parent('p.reserveMenu').text();
		$(this).parent('p.reserveMenu').children('span').text(Number(menuCount)+1);
		calculate(loc,type);
	});
	$('img#personMinus').click(function(){//인원 - 버튼 누를때 이벤트
		var menuCount = $(this).parent('p.reservePeople').children('span').text();
		if(menuCount!=0) $(this).parent('p.reservePeople').children('span').text(menuCount-1);
	});
	$('img#personPlus').click(function(){//인원 + 버튼 누를때 이벤트
		var menuCount = $(this).parent('p.reservePeople').children('span').text();
		$(this).parent('p.reservePeople').children('span').text(Number(menuCount)+1);
	});
	$('#selectType').change(function(){
		location.href="storeView.do?snum=${store.snum}&type="+this.value;
	});
	
	$('#cancelBtn').click(function(){
		var cancel = confirm("취소하면 입력한 데이터가 사라집니다.\n취소하시겠습니까?");
		if(cancel){
			$('#personMinus').siblings('span').text("0");
			$('#request').val("");
			$('#price').text("0");
			$('#discount').text("0");
			$('s#total').text("0");
			for(var i=0;i<${menuSize};i++){
				$('#menu'+i).children('table').find('tr:eq(1)').find('span').text("0");
			}
		}
	});
	
	$('a#commentUpdate').click(function(){
		var cnum = $(this).siblings('input[type=hidden]').val();
		location.href="modifyCommentForm.do?cnum="+cnum;
	});
	
	$('a#commentDelete').click(function(){
		var cancel = confirm("정말 삭제 하시겠습니까?");
		if(cancel){
			var cnum = Number($(this).siblings('input[type=hidden]').val());
			location.href="removeComment.do?snum=${store.snum}&cnum="+cnum;			
		}
	});
});
</script>
</head>
<body>
<jsp:include page="../jsp/header.jsp" />
	<div class="main">
		<div class="storeViewTop">
		<c:choose>
			<c:when test="${store.simage!=null}">
				<img class="storeViewMain" src="downloadStoreImg.do?snum=${store.snum}">
			</c:when>
			<c:otherwise>
				<img class="storeViewMain" src="image_ready.png">
			</c:otherwise>
		</c:choose>
		</div>
		<div class="storeViewBottom">
			<div class="storeViewMain">
				<div class="storeViewLeft">
					<p class="storeName">${store.sname}</p>
					<p class="storeTag">
					<c:forEach var="stag" items="${tagList}">
					#${stag} 
					</c:forEach>
					</p>
					<p class="storeIntro">${store.sintro}</p>
					<p class="storePhone">
						<span class="glyphicon glyphicon-earphone"></span>  ${store.sphone}  
						<a class="likes">
						<c:choose>
							<c:when test="${grade.glike==1}">
								<img class="likes" src="mypage/likes.png">좋아요
							</c:when>
							<c:otherwise>
								<img class="likes" src="mypage/dislike.png">좋아요
							</c:otherwise>
						</c:choose>
						</a>
					</p>
					<div id="map" style="width:100%;height:350px;"></div>
					<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=d9fd572bbbe828231a9aae53eb84ac9a"></script>
					<script>
					var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
					    mapOption = { 
					        center: new kakao.maps.LatLng(${store.slatitude}, ${store.slongitude}), // 지도의 중심좌표
					        level: 3 // 지도의 확대 레벨
					    };
					
					var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
					
					// 마커가 표시될 위치입니다 
					var markerPosition  = new kakao.maps.LatLng(${store.slatitude}, ${store.slongitude}); 
					
					// 마커를 생성합니다
					var marker = new kakao.maps.Marker({
					    position: markerPosition
					});
					// 마커가 지도 위에 표시되도록 설정합니다
					marker.setMap(map);
					</script>
					<p class="storeAddress"><span class="glyphicon glyphicon-map-marker"></span>  ${store.saddress} ${store.sdetailaddr}</p>
					<div class="storeMenu">
						<div class="storeMenuLeft">
							<p class="storeTime">
								<span class="	glyphicon glyphicon-time"></span>  
								<fmt:parseDate var="startTime" value="${store.stime_start}"  pattern="HHmm"/>
								<fmt:formatDate value="${startTime}"  pattern="HH:mm"/> ~
								<fmt:parseDate var="endTime" value="${store.stime_end}"  pattern="HHmm"/>
								<fmt:formatDate value="${endTime}"  pattern="HH:mm"/>
							</p>
							<p class="storeTime">
							<c:forEach var="holiday" items="${hoList}">
								${holiday}  
							</c:forEach>휴무  
							</p>
							<p class="storeParking">
								<c:choose>
									<c:when test="${store.sparking=='yes'}">
										<img class="storeParking" src="car-front.png">  주차공간 있음
									</c:when>
									<c:otherwise>
										<img class="storeParking" src="car-front.png">  주차공간 없음
									</c:otherwise>
								</c:choose>
							</p>
							<table>
								<tr>
									<td rowspan="4" style="vertical-align: top"><p class="storeMembership"><img class="storeMembership" src="membership.png"></p></td>
									<td><p class="storeMembership">단골</p></td>
									<td><p class="storeMembership">${store.sratelv3}%</p></td>
								</tr>
								<tr>
									<td><p class="storeMembership">성골</p></td>
									<td><p class="storeMembership">${store.sratelv2}%</p></td>
								</tr>
								<tr>
									<td><p class="storeMembership">진골</p></td>
									<td><p class="storeMembership">${store.sratelv1}%</p></td>
								</tr>
								<tr>
									<td><p class="storeMembership">범골</p></td>
									<td><p class="storeMembership">${store.sratelv0}%</p></td>
								</tr>
							</table><br>
							<table>
								<tr>
									<td rowspan="4" style="vertical-align: top"><p class="storeMembership"><span class="glyphicon glyphicon-user"></span></p></td>
									<td><p id="glevel3" class="storeMembership">단골</p></td>
									<td><p class="storeMembership">${glevel3}명</p></td>
								</tr>
								<tr>
									<td><p id="glevel2" class="storeMembership">성골</p></td>
									<td><p class="storeMembership">${glevel2}명</p></td>
								</tr>
								<tr>
									<td><p id="glevel1" class="storeMembership">진골</p></td>
									<td><p class="storeMembership">${glevel1}명</p></td>
								</tr>
								<tr>
									<td><p id="glevel0" class="storeMembership">범골</p></td>
									<td><p class="storeMembership">${glevel0}명</p></td>
								</tr>
							</table>
						</div>
						<div class="storeMenuRight">
							<p class="menuList">메뉴판</p>
							<div class="menuList">
							<table class="table table-striped">
								<c:forEach var="menu" items="${menuList}">
								<tr>
							    	<td>${menu.oname}</td>
							        <td>${menu.oprice}원</td>
							    </tr>
							    </c:forEach>
							</table>
							</div>
						</div>
					</div>
					<div class="storeCommentList">
						<a class="storeCommentList">이용후기</a>
						<select id="selectType">
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
										<c:when test="${commentMap.mimage==null}">
											<img class="storeCommentOne" src="myPage.png">
										</c:when>
										<c:otherwise>
											<img class="storeCommentOne" src="downloadMImage.do?mid=${commentMap.mid}">
										</c:otherwise>
									</c:choose>
									</td>
									<td><p class="storeCommentOne">${commentMap.mid}</p></td>
									<td><p class="storeCommentOne"><fmt:formatDate value="${commentMap.comment.cdate}" pattern="yyyy-MM-dd"/></p></td>
									<td rowspan="4">
									<input type="hidden" value="${commentMap.comment.cnum}">
									<c:if test="${commentMap.mid == mid}">
										<a id="commentUpdate" class="storeCommentOne">수정</a>
										<a id="commentDelete" class="storeCommentOne">삭제</a>
									</c:if>
									</td>
								</tr>
								<tr>
									<td><p class="storeCommentOne">총점</p></td>
									<td>
										<ul>
											<li>${commentMap.comment.ctotal}</li>
										</ul>
									</td>
								</tr>
								<tr>
									<td><p class="storeCommentOne">서비스</p></td>
									<td>
										<ul>
											<li>${commentMap.comment.cservice}</li>
										</ul>
									</td>
								</tr>
								<tr>
									<td><p class="storeCommentOne">가격</p></td>
									<td>
										<ul>
											<li>${commentMap.comment.cprice}</li>
										</ul>
									</td>
								</tr>
							</table>
							<p class="storeCommentOne"><b>맛</b> 
							<c:forTokens var="taste" items="${commentMap.comment.ctaste}" delims=",">
							${taste}
							</c:forTokens>
							</p>
							<p class="storeCommentOne"><b>후기</b></p>
							<textarea class="storeCommentOne" cols="63" rows="2" readonly="readonly">${commentMap.comment.creview}</textarea>
						</div>
						</c:forEach>
					</div>
				</div>
				<div class="storeViewRight">
				<c:choose>
				<c:when test="${mid==null}"><!-- 일반 로그인을 하지 않았을때 -->
					<div class="noReserve">
						<img class="noReserve" src="noReserve.png">
					</div>
				</c:when>
				<c:when test="${store.slimit==0}"><!-- 가게가 예약을 받지않을때 -->
					<div class="noReserve">
						<img class="noReserve" src="noReserve2.png">
					</div>
				</c:when>
				<c:otherwise><!-- 로그인을 했을때 -->
					<p class="storeViewRight">예약</p>
					<div class="reserveMenu">
						<c:forEach var="menu" items="${menuList}" varStatus="status">
						<div class="reserveMenuOne" id="menu${status.index}">
						<table>
							<tr>
								<td rowspan="3">
								<c:choose>
									<c:when test="${menu.oimage != null}">
										<img class="storeViewRight"src="downloadStoreMenuImg.do?onum=${menu.onum}">
									</c:when>
									<c:otherwise>
										<img class="storeViewRight"src="menu_ready.png">
									</c:otherwise>
								</c:choose>
								</td>
								<td><input type="hidden" value="${menu.onum}"><p class="reserveMenu">${menu.oname}</p></td>
							</tr>
							<tr>
								<td><p class="reserveMenu"><img id="menuMinus" class="reserveMenu" src="minus.png"> <span>0</span> <img id="menuPlus" class="reserveMenu" src="plus.png"></p></td>
							</tr>
							<tr>
								<td><p class="reserveMenu"><span id="menuPrice">${menu.oprice}</span>원</p></td>
							</tr>
						</table>
						</div>
						</c:forEach>
					</div>
					<div>
						<p class="reservePeople">예약 인원<img id="personMinus" class="reservePeople" src="minus.png"> <span>0</span> <img id="personPlus" class="reserveMenu" src="plus.png">명</p>
						<p class="reserveMenu">예약 날짜<span class="reserveMenu"><input id="rdate" type="date" class="currentDate" min="${currentDate}" value="${currentDate}" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2}"></span></p>
						<p class="reserveMenu">예약 시간
							<span class="reserveMenu">
								<select id="hour">
									<c:forEach begin="${time[0]}" end="${time[2]}" step="1" varStatus="status">
									<option value="${status.index}">${status.index}</option>
									</c:forEach>
								</select>시
								<select id="time">
									<option value="00">00</option>
									<option value="30">30</option>
								</select>분
							</span>
						</p>
						<p class="reserveMenu">요구사항</p>
						<textarea id="request" cols="63" rows="2" class="storeCommentOne"></textarea>
					</div>
					<div class="reserveBottom">
						<table>
							<tr>
								<td><p class="reserveMenu">할인전 금액</p></td>
								<td><p class="reserveMenu"><span id="price" class="reserveMenu">0</span>원</p></td>
							</tr>
							<tr>
								<td><p class="reserveMenu">할인 금액</p></td>
								<td><p class="reserveMenu"><span id="discount" class="reserveMenu">0</span>원</p></td>
							</tr>
							<tr>
								<td><p class="reserveMenu">총 금액</p></td>
								<td><p class="reserveMenu"><span id="total" class="reserveMenu">0</span>원</p></td>
							</tr>
						</table>
						<p class="reserveMenu"><input id="cancelBtn" type="button" class="reserveBtn" value="예약취소"><input id="reserveBtn" type="button" class="reserveBtn" value="예약완료"></p>
					</div>
				</c:otherwise>
				</c:choose>
				</div>
			</div>
		</div>
	</div>
<jsp:include page="../jsp/footer.jsp" />	
</body>
</html>