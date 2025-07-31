 <%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>상품 목록 상세 화면</title>
  <link rel="stylesheet" href="/css/total.css" />
  <link rel="stylesheet" href="/css/admin_style.css" />
  <script src="/js/jquery-3.7.1.min.js"></script>
  <script src="/js/jquery.min.js"></script>
  <script src="/js/main.js"></script>
</head>

<script>

function fn_check(no,msg) {
    if (no == null || no === '' || no === 'null') {
        alert(msg);
        return false;   // 링크 이동 막기
    }

    return true; // 다음 페이지 있을 경우 정상 이동
}

function fn_delete(product_no){
	
	if(confirm("정말 삭제하시겠습니까?")){
		
		// json 설정
		let sendData = "product_no="+product_no;		
		$.ajax({
			type:"post",
			data:sendData,
			url: "/adminDetailDelete",				
			dataType: "text",
			success:function(data){
				if(data=="1"){
					alert("삭제완료");
					location="/adminProductList";
				}else{
					alert("삭제실패");
				}
			},
			error:function(){
				
			}
			
		});
		
	}
	
}

</script>
<body>

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
                
              
                	<h2 class="htitle">상품 관리</h2>
                	<h3>⦁ 상품 목록 상세</h3>
                	<div class="listRight" style="text-align:right; font-weight:bolder"><a href="/adminProductList">[상품목록]</a></div>
                
                <hr class="shr">
                
                <form id="frm">
                <table class="ptable">
                
                <colgroup>
					<col width="20%" />
					<col width="*" />
				</colgroup>
                
                	<tr>
                		<th class="ptablethd"><label for="pname">상품명</label></th>
                		
                		<td class="ptablethd">${dto.product_name }</td>
                	</tr>
                	<tr>
                		<th class="ptablethd">상품번호</th>
                		
                		<td class="ptablethd">${dto.product_no }</td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="pdescription">상품설명</label></th>
                		
                		<td class="ptablethd">${dto.product_description }</td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="pimage">상품 이미지</label></th>
                		
                		<td class="ptablethd">
							<img id="preview" alt="미리보기" src="${dto.filepath }${dto.product_img}" style="max-width:300px;">
							
						</td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="pprice">상품가격</label></th>
                		
                		<td class="ptablethd">${dto.product_price }</td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="pdelivery_mth">배송방법</label></th>
                		
                		<td class="ptablethd">${dto.delivery_mth }</td>
                	</tr>
                	<tr>
                		<th class="ptablethd"><label for="pdelivery_fee">배송비</label></th>
                		
                		<td class="ptablethd">${dto.delivery_fee }</td>
                	</tr>
                	<tr>
                		<th class="ptablethd">판매가격 (할인율(%))</th>
                		<td class="ptablethd">${dto.product_final_price } (${dto.product_sale }%)</td>
                	</tr>
                	<tr>
                		<th class="ptablethd">판매 URL</th>
                		<td class="ptablethd"><a href="${dto.product_url }"style="color:#2360E6; font-weight:bold">${dto.product_url }</a></td>
                	</tr>
                	<tr>
                		<th class="ptablethd">등록일</th>
                		<td class="ptablethd">${dto.registration_date }</td>
                	</tr>
                	<tr>
                		<th class="ptablethd">수정일</th>
                		<td class="ptablethd">${dto.updated_date }</td>
                	</tr>
                	<tr>
                		<th class="ptablethd">판매수량</th>
                		<td class="ptablethd">${dto.sales_cnt }</td>
                	</tr>
                	
                	
                </table>
                
                 <div class="div_button_area">
                 	<div class="div_page">

					   <c:if test="${bbutton != null}">
					    <a href="/adminProductDetail/${bbutton}" onclick="return fn_check('${bbutton}', '이전 페이지가 없습니다.');" class="blue_border_btn page_arrow"
					    style="color:#2360E6;"
					    >이전</a>
					  </c:if>
					
					  <c:if test="${nbutton != null}">
					   <a href="/adminProductDetail/${nbutton}"onclick="return fn_check('${nbutton}', '다음 페이지가 없습니다.');" class="blue_btn page_arrow"
					   style="color:white;"
					   >다음</a>
					  </c:if>
					
					</div>
				    <div>
				    	<button type="button" id="btn_submit" onClick="location='/adminProductModify?product_no=${dto.product_no}'" class="blue_border_btn">수정</button>
				    	<button type="button" onClick="fn_delete(${dto.product_no})" class="blue_btn">삭제</button>
				    </div>
				    
				 </div>
                
                
                </form>


                </section>
                <!-- 작업 공간 -->

            </div>

        </section>

    </section>
    
  


</body>
</html>