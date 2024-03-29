<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이벤트등록_이벤트/행사</title>
<link rel="stylesheet" href="/css/template.css" />
<style>
	.contentsTitGroup{
		padding-top: 9.5rem;
  		padding-bottom: 6.0rem;
	    text-align: center;
	    display: block;
	}
	.contents {
		display: block;
		text-align: center;
	    width: 100%;
	    height: 550px;
	    margin: 0 auto;
	    border: 1px solid #999999;
	    border-radius: 20px;
	    margin-bottom : 30px;
	}
	.left-form {
    	width: 200px;
    	float: left;
	    line-height: 62px;
	    padding-left: 10px;
	    color: #555;
	    text-align: left;
	    font-size : 14px;
	}
	.right-form {
	    float: left;
	    width: 80%;
	    padding-top: 10px;
	    padding-bottom: 10px;
	    color: #7b6e66;
	    text-align: left;
	}
	.form-wrap {
		float: left;
		display: block;
		height: auto;
	    line-height: 100%;
	    width: 100%;
	}
	.list-basic > li {
	    border-bottom: 0.1rem solid #7a6e67;
	    white-space: nowrap;
	}
	ul, ol, li {
	    list-style: none;
	}
	.filebox label { 
		margin-top : 80px;
		display: inline-block; 
		vertical-align: middle;
		padding: .5em .75em; 
		color: #000000; 
		line-height: 25px;
		cursor: pointer; 
		border: 1px solid #000000; 
		height: 40px;
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
	.memberImg {
		display : block;
		margin: 0 auto;
		margin-top: 20px;
		width: 100px;
		height: 100px;
		float: left;
	}
</style>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.0/jquery.min.js"></script>
<script type="text/javascript">
	$(function(){
		/* 범위 선정 드롭다운 버튼 제한 */
		$("#target1").on("change",function(){
			$("#target2").show();
			var target1 = $("#target1 option:selected").val();
			switch (target1) {
			case "모두":
				  $("#target2").find("option").remove();
				  $("#target2").prepend("<option value='모두'>모두</option>");
				break;
				
			case "단골":
				  $("#target2").find("option").remove();
				  $("#target2").prepend("<option value='단골'>단골</option>");
				break;
				
			case "성골":
				  $("#target2").find("option").remove();
				  $("#target2").prepend("<option value='단골'>단골</option>");
				  $("#target2").append("<option value='성골'>성골</option>");
				break;
				
			case "진골":
				  $("#target2").find("option").remove();
				  $("#target2").prepend("<option value='단골'>단골</option>");
				  $("#target2").append("<option value='성골'>성골</option>");
				  $("#target2").append("<option value='진골'>진골</option>");
				break;

			default:
				  $("#target2").find("option").remove();
				  $("#target2").prepend("<option value='단골'>단골</option>");
				  $("#target2").append("<option value='성골'>성골</option>");
				  $("#target2").append("<option value='진골'>진골</option>");
				  $("#target2").append("<option value='범골'>범골</option>");
				break;
			}
		});
		
		$("#efile").on("change",SelectImg);
	});
	
	function SelectImg(e){//이미지 미리보기
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
	
	function cancel(){ // 취소
		history.back(-1);
	}
</script>
</head>
<body>
	<jsp:include page="/jsp/header.jsp"/>
	<div class="container">
		<div class="contentsTitGroup">
			<h2 class="contentTit" style="opacity: 1; transform: matrix(1, 0, 0, 1, 0, 0);">이벤트 등록</h2>
		</div>
		<div class="contents">
		<form action="insertEvent.do" enctype="multipart/form-data" method="post">
			<ul class="list-basic">
				<li class="clearfix form-wrap">
	            	<div class="left-form">지점 이름</div>
					<div class="right-form">
						<div class="formArea">
							<select class="inputText w300" name="snum">
								<c:forEach var="store" items="${Stores}" varStatus="status">
									<option value="${store.snum}">${store.sname}</option>
								</c:forEach>
							</select>
						</div>
					</div>
				</li>
	          	<li class="form-wrap">
	          		<div class="left-form">이벤트 제목</div>
	          		<div class="right-form">
	           			<div class="formArea">
							<input type="text" name="etitle" value="" class="inputText w300" placeholder="이벤트/행사 제목을 입력하세요" maxlength="100">
						</div>
					</div>
				</li>
				<li class="form-wrap">
	          		<div class="left-form">이벤트 기간</div>
	          		<div class="right-form">
	           			<div class="formArea">
	           				<input type="date" name="estartdate"> ~ <input type="date" name="eenddate">
						</div>
					</div>
				</li>
				<li class="form-wrap">
	          		<div class="left-form">이벤트 대상</div>
	          		<div class="right-form">
	           			<div class="formArea">
	           				<select class="inputText w100" name="etarget1" id="target1">
								<option value="모두">모두</option>
								<option value="단골">단골</option>
								<option value="성골">성골</option>
								<option value="진골">진골</option>
								<option value="범골">범골</option>
							</select> 
							<span class="spanText"> ~ </span>
							<select class="inputText w100" name="etarget2" id="target2">
								<option value="모두">모두</option>
							</select>
						</div>
					</div>
				</li>
				<li class="form-wrap">
	          		<div class="left-form">이벤트 이미지</div>
	          		<div class="right-form">
           				<img id="img" class="memberImg" src="myPage.png">
	           			<div class="filebox">
	           				<label for="efile">이미지 업로드</label>
	           				<input type="file" name="efile" id="efile" value="${event.eimage}">
						</div>
					</div>
				</li>
			</ul>
			<div class="btn-wrap">
				<button class="btn-view" type="button" onClick="cancel(); return false;">취소</button>
				<input class="btn-view btn-mint" type="submit" value="등록">
			</div>
		</form>
		</div>
	</div>
</body>
</html>