 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>결제시스템(관리자)</title>
  <link rel="stylesheet" href="css/total.css" />
  <link rel="stylesheet" href="css/admin.css" />
  <script src="js/jquery-3.7.1.min.js"></script>
  <script src="js/jquery.min.js"></script>
  <script src="js/main.js"></script>
</head>
<body>

<script>


$(function(){
	
	 // 숫자 입력 시 천 단위 쉼표
    $('#pprice').on('input', function (e) {
        let value = e.target.value.replace(/[^0-9]/g, ''); // 숫자만 허용
        if (value !== "") {
            value = parseInt(value, 10).toLocaleString();  // 천 단위 콤마 추가
        }
        e.target.value = value;
    });
	
	$("#btn_submit").click(function() {
		

		let pname = $("#pname").val();
		pname = $.trim(pname);
		$("#pname").val(pname);

		let pprice  = $("#pprice").val().replace(/,/g, ''); // 쉼표 제거!
        pprice = $.trim(pprice);
        $("#pprice").val(pprice);
        
        let psale = $("#psale").val();
        psale = $.trim(psale);
		$("#psale").val(psale);
        
		
		if( pname == "" ) {
			alert("상품명을 입력해주세요.");
			$("#pname").focus();
			return false;
		}
		if( pprice == "" ) {
			alert("상품가격을 입력해주세요.");
			$("#pprice").focus();
			return false;
		}
		
		if( psale == "" ) {
			alert("할인율을 입력해주세요.\n(할인율이 없을 경우 0 입력)");
			$("#psale").focus();
			return false;
		}
		
		let fileInput = document.getElementById("input_file");
		if (!fileInput.files || fileInput.files.length === 0) {
		    alert("상품 이미지를 선택해주세요.");
		    fileInput.focus();
		    return false;
		}
		
		
		// let form = $("#frm").serialize();
		// {파일} 전송을 위한 폼설정
		let form = new FormData(document.getElementById('frm'));
		$.ajax({
			type : "post",
			url  : "/adminProductInsert",
			data : form,
			
			processData: false, // 전송데이터의 인식을 위한 세팅
			contentType: false, // 전송데이터의 인식을 위한 세팅
			
			dataType : "text",
			success  : function(data){
				if(data == "ok") {
					alert("저장완료");
					location = "/adminProductList";
				} else {
					alert("저장실패");
				}
			},
			error    : function(){
				alert("오류발생!!");
			}
		});

	});
	
});



</script>

    <!-- skip 네비게이션 영역 -->
    <nav id="skipToContent">
        <ul>
            <li><a href="#container">Skip to Main Content</a></li>
            <li><a href="#gnb">Skip to Main Menu</a></li>
            <li><a href="#header">Skip to Upeer Menu</a></li>
            <li><a href="#footers">Skip to Lower Menu</a></li>
        </ul>
    </nav>
    <!-- skip 네비게이션 영역 -->

    <section id="admin_wrap">
          <aside class="aside">
            <a href="/adminMain" class="tit_wrap">
                    <h1 class="tit_h1">
                        <span class="blind">logo</span>
                    </h1>
                </a>
            <ul>
                <li>
                    <a href="#none" class="menu01">회원 관리</a>
                    <ul class="menu02">
                        <li>
                            <a href="/adminMemberList">회원 목록</a>
                        </li>
                        <li>
                            <a href="/adminMemberDeleteList">삭제 회원 목록</a>
                        </li>
                        <li>
                            <a href="/adminMemberBlockList">차단 회원 목록</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#none" class="menu01">상품 관리</a>
                    <ul class="menu02">
                        <li>
                            <a href="/adminProductList">상품 목록</a>
                        </li>
                        <li>
                            <a href="/adminProductWrite">상품 등록</a>
                        </li>
                    </ul>
                </li>
                <li>
                    <a href="#none" class="menu01">주문 관리</a>
                    <ul class="menu02">
                        <li>
                            <a href="/adimOrderItemList">주문 목록</a>
                        </li>
                        <li>
                            <a href="/adimCancelOrderList">취소 목록</a>
                        </li>
                    </ul>
                </li>
            </ul>
        </aside>

        <section id="admin_content">
            <div class="content_wrap">
                <header id="admin_header">
                    <ul class="snb">
                        <li>
                            <a href="#none">로그아웃</a>
                        </li>
                    </ul>
                </header>

                <!-- 작업 공간 -->
                <section id="admin_section">
                
                	<h2>상품 관리</h2>
                
                	<h3>⦁ 상품 등록</h3> 
                	<div class="listRight" style="text-align:right; font-weight:bolder"><a href="/adminProductList">[상품목록]</a></div>
                
                 <hr class="shr">
                
                <form id="frm" enctype="multipart/form-data">
                <table class="ptable">
                
                <colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
                
                	<tr>
                		<th class="ptablethd"><label for="pname">상품명</label></th>
                		
                		<td class="ptablethd"><input type="text" id="pname" name="product_name" class="sinput" placeholder="예) 홍삼"></td>
                	</tr>
                	<tr>
                		<th class="ptablethd">상품번호</th>
                		
                		<td class="ptablethd">자동생성</td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="pdescription">상품설명</label></th>
                		
                		<td class="ptablethd"><textarea id="pdescription" name="product_description" class="stextarea" placeholder="[0/255]"></textarea></td>
                	</tr>
                	
                	 <tr>
                		<th class="ptablethd"><label for="pimage">상품 이미지 등록</label></th>
                		
                		<td class="ptablethd"><label class="input_file_button" for="input_file">
							  업로드
							</label>
							<input type="file" name="file1" id="input_file" style="display:none"/> 
							<img id="preview" alt="미리보기" src="" style="max-width:300px; display:none;">
							<p id="file-name">선택된 파일 없음</p>
							
						</td>
                	</tr>
                	
                	<tr>
                		<th class="ptablethd"><label for="pprice">상품가격</label></th>
                		
                		<td class="ptablethd"><input type="text" name="product_price" id="pprice" class="sinput" placeholder="숫자만 입력하세요."></td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="psale">할인율(%)</label></th>
                		<td class="ptablethd"><input type="text" id="psale" name="product_sale" class="sinput" placeholder="숫자만 입력하세요."></td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="psale">상품URL</label></th>
                		<td class="ptablethd"><input type="text" id="product_url" name="product_url" class="sinput" placeholder="상품 URL을 입력해주세요."></td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="psale">배송방법</label></th>
                		<td class="ptablethd">택배</td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="psale">배송비</label></th>
                		<td class="ptablethd"> 무료</td>
                	</tr>
                	
                	
                </table>
                
                 <div style="display: flex; gap:10px; align-items: center; justify-content: center; margin: 15px 0;">
				   <button type="button" id="btn_submit" class="blue_border_btn">등록</button>
				    <button type="reset" class="blue_btn" >취소</button>
				 </div>
                
                
                </form>

                </section>
                <!-- 작업 공간 -->

            </div>

        </section>

    </section>
    
    <!-- 이미지 등록 표시 -->
	<script>

	document.getElementById('input_file').addEventListener('change', function(event) {
		  const file = event.target.files[0]; // 선택된 파일
		
		  if (file) {
		    // 파일 이름 표시
		    document.getElementById('file-name').textContent = file.name;
		
		    // 이미지 미리보기
		    const reader = new FileReader();
		    reader.onload = function(e) {
		      const preview = document.getElementById('preview');
		      preview.src = e.target.result;
		      preview.style.display = 'block';
		    };
		    reader.readAsDataURL(file);
		  } else {
		    // 파일 선택 안 했을 경우 초기화
		    document.getElementById('file-name').textContent = '선택된 파일 없음';
		    document.getElementById('preview').style.display = 'none';
		  }
		});
	
</script>


</body>
</html>