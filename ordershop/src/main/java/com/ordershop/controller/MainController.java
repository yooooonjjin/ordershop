package com.ordershop.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ordershop.dto.AdminDto;
import com.ordershop.dto.MemberDto;
import com.ordershop.dto.UCartDto;
import com.ordershop.dto.UInfoDto;
import com.ordershop.dto.UOrderDto;
import com.ordershop.dto.UPaymentDto;
import com.ordershop.dto.UProductDto;
import com.ordershop.service.AdminService;
import com.ordershop.service.MainService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MainController {

	@Autowired
	MainService mainService;
	
	@Autowired
	AdminService adminService;
	   
	   //메인페이지
	   @GetMapping("main")
	   public String main(UProductDto dto, ModelMap model) throws Exception {
	      // DefaultDto 의 검색 / 페이징 / 정렬 필드를 UProductDto가 모두 상속
	         
	      // 페이징 계산
	      dto.setFirstIndex((dto.getPageIndex() - 1) * dto.getPageUnit() + 1);   // 첫번째 번호
	      dto.setLastIndex(dto.getFirstIndex() + dto.getPageUnit() - 1 );         // 마지막 번호
	            
	      // 전체 데이터 개수 조회 (검색 / 정렬 조건 반영 O)
	      int totalCnt = mainService.selectListTotal(dto);
	      dto.setTotal(totalCnt);         // 전체 데이터 개수 DTO에 저장
	      dto.setTotalPage(totalCnt);      // 전체 페이지 수 계산해서 DTO에 저장
	      
	      // 실제 리스트 데이터 조회 (검색 / 정렬 / 페이징 조건 모두 반영 O)
	      List<?> productList = mainService.selectuserProductList(dto);
	
	            
	      model.addAttribute("productList", productList);      // 상품 데이터
	      model.addAttribute("listTotal", totalCnt);         // 전체 데이터 개수
	      model.addAttribute("dto", dto);                  // 검색, 정렬, 페이징 정보
	        
	      return "user/main";
	   }
	   
	   //로그인 페이지
	   @GetMapping("login")
	   public String login() {
	      
	      return "user/login";
	   }
	   
	   
	   
	   
	   @PostMapping("loginConfirm")
	   @ResponseBody
	   public String loginConfirm(MemberDto memberdto, HttpSession session) throws Exception {

	       String msg = "1";

	       // 1) 아이디 패스워드 확인
	       int cnt = mainService.selectLoginCheck(memberdto);

	       if (cnt == 0) {
	           msg = "2"; // 로그인 실패
	       } else {
	           // 2) 로그인 성공 시, USER_ID로 회원 정보 전체 조회 (USER_NO 포함)
	           MemberDto fullMember = mainService.selectMemberInfoByUserId(memberdto.getUser_id());

	           // 3) 세션에 USER_ID 저장
	           session.setAttribute("SESSION_USERID", fullMember.getUser_id());

	           // 4) 세션에 USER_NO 저장
	           session.setAttribute("SESSION_USERNO", fullMember.getUser_no());
	           Integer userNo = (Integer) session.getAttribute("SESSION_USERNO");
	    

	           // 5) 세션 유지 시간 설정 (1시간)
	           session.setMaxInactiveInterval(60 * 60);
	       }
	       

	       return msg;
	   }
	   
	 


	   

	   //관리자 로그인
	   @PostMapping("adminConfirm")
	   @ResponseBody
	   public String adminConfirm(AdminDto adminDto, HttpSession session) throws Exception {
	

	       int cnt = 0;
	       try {
	           cnt = adminService.selectAdminCheck(adminDto);
	      
	       } catch (Exception e) {
	           e.printStackTrace();  // 에러 로그 찍기
	           return "error";  // 필요시 클라이언트로도 에러 알리기
	       }

	       if (cnt == 0) {
	           return "2"; // 로그인 실패
	       } else {
	           session.setAttribute("SESSION_ADMIN", adminDto.getAdmin_id());
	           session.setMaxInactiveInterval(60 * 60);
	           return "1"; // 로그인 성공
	       }
	   }
	   
	   // 로그아웃
	   @PostMapping("logout")
	   @ResponseBody
	   public String logout(HttpSession session) throws Exception {
	       session.invalidate();
	       return "success";
	   }
	   
	 //회원가입 약관
	   @GetMapping("joinAgree")
	   public String memberWrite() throws Exception{
	      return "user/joinAgree";

	   }

	// 회원가입 약관에서 아이디설정페이지로 이동
	   @GetMapping("joinForm")  // 여기서 joinFrom -> joinForm 으로 변경
	   public String showJoinForm() throws Exception {
	       return "user/joinForm";  // 뷰도 joinForm.jsp 가 맞는지 확인
	   }

	   @PostMapping("joinForm") 
	   public String handleAgreeSubmit(@RequestParam Map<String, String> params) throws Exception {
	       // 약관 체크 등 서버에서 검증 처리 가능
	       return "redirect:/joinForm";  // joinForm 으로 통일
	   }
	   

	   //아이디 유효 체크
	   @PostMapping("useridCheck")
	   @ResponseBody
	   public String useridCheck(String userid) throws Exception {
	     
	       String msg = "1";

	       if (userid == null || userid.trim().isEmpty()) {
	           return "2";
	       }

	       String pattern = "^[a-zA-Z]{1}[a-zA-Z0-9_\\-#]{5,19}";
	       boolean result = userid.matches(pattern);

	       if (!result) {
	           msg = "2";
	       } else {
	           int cnt = mainService.selectMemberUserid(userid);
	           if (cnt > 0) {
	               msg = "3";
	           }
	       }

	       return msg;
	   }
	   
	   //회원가입 후 회원 저장
	   @PostMapping("memberInsert")
	   @ResponseBody
	   public String memberInsert(MemberDto dto) throws Exception{
	      //저장완료, 저장실패, 중복체크
	      String msg ="1";
	      
	      //아이디 중복체크
	      int cnt = mainService.selectMemberUser_id(dto.getUser_id());
	      
	      if(cnt > 0) {
	         msg="2";
	      }else {
	   
	         //저장처리
	         int result= mainService.insertMember(dto);
	         if(result == 0) {
	            msg="3";
	         }
	      }

	      return msg;
	   }
	   
	   


	   // 사용자_상품 목록 화면
	   @GetMapping("userProductList")
	   public String userProductList( UProductDto dto, ModelMap model) throws Exception {
	      // DefaultDto 의 검색 / 페이징 / 정렬 필드를 UProductDto가 모두 상속
	      
	      // 페이징 계산
	      dto.setFirstIndex((dto.getPageIndex() - 1) * dto.getPageUnit() + 1);   // 첫번째 번호
	      dto.setLastIndex(dto.getFirstIndex() + dto.getPageUnit() - 1 );         // 마지막 번호
	            
	      // 전체 데이터 개수 조회 (검색 / 정렬 조건 반영 O)
	      int totalCnt = mainService.selectListTotal(dto);
	      dto.setTotal(totalCnt);         // 전체 데이터 개수 DTO에 저장
	      dto.setTotalPage(totalCnt);      // 전체 페이지 수 계산해서 DTO에 저장

	      // 실제 리스트 데이터 조회 (검색 / 정렬 / 페이징 조건 모두 반영 O)
	      List<?> productList = mainService.selectuserProductList(dto);
	            
	      model.addAttribute("productList", productList);      // 상품 데이터
	      model.addAttribute("listTotal", totalCnt);         // 전체 데이터 개수
	      model.addAttribute("dto", dto);                  // 검색, 정렬, 페이징 정보
	      
	      return "user/userProductList";
	   }
	   
	   
	   // 사용자_상품 상세 화면
	   @GetMapping("userProductDetail/{product_no}")
	   public String selectUserProductDetail(@PathVariable String product_no,
	                                          ModelMap model) throws Exception {
	      
	      mainService.updateProductListViewCnt(product_no);
	      
	      UProductDto dto = mainService.selectUserProductDetail(product_no);
	    
	      model.addAttribute("dto", dto);
	      
	      
	      return "user/userProductDetail";
	   }
	   
	   @GetMapping("userCart")
	   public String userCart(UCartDto cartDto, ModelMap model, HttpSession session) throws Exception {

	       // 1. 세션에서 USER_NO 가져오기
	       Integer userNo = (Integer) session.getAttribute("SESSION_USERNO");

	       // 2. null 체크 (로그인 안 된 경우 처리)
	       if (userNo == null) {
	           // 로그인 안 된 사용자 처리: 예를 들어 로그인 페이지로 리다이렉트
	           return "redirect:/login";
	       }

	       // 3. cartDto에 세션 유저 번호 세팅
	       cartDto.setUser_no(userNo);

	       // 4. 기본값 세팅 (안 들어올 때 대비)
	       if (cartDto.getPageIndex() == 0) cartDto.setPageIndex(1);
	       if (cartDto.getPageUnit() == 0) cartDto.setPageUnit(10);

	       // 5. 페이징 계산
	       cartDto.setFirstIndex((cartDto.getPageIndex() - 1) * cartDto.getPageUnit() + 1);
	       cartDto.setLastIndex(cartDto.getFirstIndex() + cartDto.getPageUnit() - 1);

	       // 6. 전체 장바구니 건수
	       int totalCnt = mainService.selectCartListTotalCnt(cartDto);
	       cartDto.setTotal(totalCnt);
	       cartDto.setTotalPage(totalCnt);

	       // 7. 페이징 적용 장바구니 리스트
	       List<?> cartList = mainService.selectCartList(cartDto);
	       System.out.println("cnt::::::"+cartList);

	       model.addAttribute("cartList", cartList);
	       model.addAttribute("cartListTotal", totalCnt);
	       model.addAttribute("dto", cartDto);

	       return "user/userCart";
	   }


	   @PostMapping("userCartInsert")
	   @ResponseBody
	   public String insertCartList(UCartDto cartDto, HttpSession session) throws Exception {

	       // 세션에서 USER_NO 가져오기
	       Integer userNo = (Integer) session.getAttribute("SESSION_USERNO");

	       if (userNo == null) {
	           // 로그인 안 된 상태라면 실패 처리 (예: 에러 리턴)
	           return "fail";
	       }

	       // cartDto에 세션에서 가져온 USER_NO 세팅
	       cartDto.setUser_no(userNo);

	       int cnt = mainService.countCartList(cartDto);

	       if (cnt > 0) {
	           mainService.updateCartList(cartDto);
	       } else {
	           mainService.insertCartList(cartDto);
	       }

	       return "success";
	   }

	   // 장바구니 리스트 삭제
	   @PostMapping("cartListDelete")
	   @ResponseBody
	   public String deleteCartList(UCartDto cartDto, String product_no) throws Exception {
	      
	      mainService.deleteCartList(cartDto);
	      
	      return "user/userCart";
	   }
	  
	   
	   // 장바구니 리스트 선택 삭제
	   @PostMapping("cartDeleteEach")
	   @ResponseBody
	   public String cartDeleteEach(String datas) throws Exception {
	      
	      String msg = "ok";
	      
	      datas = datas.substring(0, datas.length()-1);
	      
	      int result = mainService.cartDeleteEach(datas);
	      if( result == 0 ) msg = "fail";
	      
	      return msg;
	   }   
	   
	   


	   // 결제하기 리스트 화면
	   @PostMapping("userPayment")
	   public String userPayment(   UInfoDto userInfoDto
	                        ,String product_no
	                        ,String product_name
	                        ,String product_description
	                        ,int product_price
	                        ,int price_snapshot
	                        ,int order_cnt
	                        ,ModelMap model
	                        ,HttpSession session) throws Exception {
	      
	      

	      // 세션에서 USER_NO 가져오기
	       Integer userNo = (Integer) session.getAttribute("SESSION_USERNO");

	       if (userNo == null) {
	           // 로그인 안 된 상태라면 실패 처리 (예: 에러 리턴)
	           return "fail";
	       }
	       userInfoDto.setUser_no(userNo);	// 회원번호
	      
	      UInfoDto user = mainService.selectUserInfo(userInfoDto);
	      
	      // 수량 * 가격
	      int total_price = product_price * order_cnt;
	      int final_price = price_snapshot * order_cnt;   
	      
	      model.addAttribute("user", user);
	      model.addAttribute("user_no", userNo);
	      model.addAttribute("product_no", product_no);
	      model.addAttribute("product_name", product_name);
	      model.addAttribute("product_description", product_description);
	      model.addAttribute("product_price", product_price);
	      model.addAttribute("price_snapshot", price_snapshot);
	      model.addAttribute("order_cnt", order_cnt);
	      model.addAttribute("total_price", total_price);
	      model.addAttribute("final_price", final_price);
	      model.addAttribute("filepath", userInfoDto.getFilepath());
	      model.addAttribute("product_img", userInfoDto.getProduct_img());
	      
	      return "user/userPayment";
	   }
	   

	   

	   
	   // 결제하기 데이터 insert (결제 테이블, 주문 테이블)
	   @PostMapping("userOrdPayInsert")
	   @ResponseBody
	   @Transactional
	   public String userOrdPayInsert(UOrderDto orderDto, UPaymentDto paymentDto) throws Exception {
	      
		   
		   // 결제 수단 값 가져오기
		   String pay_method = paymentDto.getPay_method();
	      
	      // 결제 상태 설정
	      if ("무통장입금".equals(pay_method)) {
	    	  paymentDto.setPay_status("N");
	      } else {
	    	  paymentDto.setPay_status("Y");
	      }
	      
	      // 주문 상태 기본 설정
	      orderDto.setOrder_status("Y");
	      
	      // 관리다 아이디 임시 설정
	      orderDto.setAdmin_id("ds1004"); // 이거 고쳐야됨
	      
	      // order_id 시퀀스 추출
	      String order_id = mainService.selectOrderId();
	      
	
	      
	      // 주문 dto에 order_id 세팅
	      orderDto.setOrder_id(order_id);
	      // 주문 정보 insert
	      mainService.insertOrder(orderDto);
	      
	      // 결제 dto에 order_id 세팅
	      paymentDto.setOrder_id(order_id);
	      // 결제 정보 insert
	      mainService.insertPayment(paymentDto);
	       
	        
	        return "user/userDelivery"; 
	   }
	   
	   
	// 주문내역 화면
		@GetMapping("userDelivery")
		public String userDelivery(	@RequestParam(value = "pay_status", required = false, defaultValue = "ALL") String pay_status,
									HttpSession session
									,ModelMap model
									,UOrderDto uorderDto ) throws Exception {
			
		
			   // 1. 세션에서 USER_NO 가져오기
		       Integer userNo = (Integer) session.getAttribute("SESSION_USERNO");

		       // 2. null 체크 (로그인 안 된 경우 처리)
		       if (userNo == null) {
		           // 로그인 안 된 사용자 처리: 예를 들어 로그인 페이지로 리다이렉트
		           return "redirect:/login";
		       }

		       // 3. cartDto에 세션 유저 번호 세팅
		       uorderDto.setUser_no(userNo);

			
			
			
			if (!"ALL".equals(pay_status)) {
		        uorderDto.setPay_status(pay_status); // "N" 또는 "Y"
		    }
			
			uorderDto.setPageUnit(10);
			uorderDto.setFirstIndex((uorderDto.getPageIndex() - 1) * uorderDto.getPageUnit() + 1);
			uorderDto.setLastIndex(uorderDto.getFirstIndex() + uorderDto.getPageUnit() - 1);

		    int totalCnt = mainService.selectUserDeliveryCount(uorderDto);
		    uorderDto.setTotal(totalCnt);
		    uorderDto.setTotalPage(totalCnt); // 이때 pageUnit 기준으로 계산됨
			
			List<?> orderList = mainService.selectUserDelivery(uorderDto);
			model.addAttribute("uorderDto", uorderDto);
			model.addAttribute("orderList", orderList);		// 상품 데이터
			model.addAttribute("pay_status", pay_status); // 탭 유지용
			
			return "user/userDelivery";
		}

		// 주문내역 화면
		@GetMapping("userDeliveryDetail")
		public String userDeliveryDetail(	@RequestParam("order_id") int order_id
											,HttpSession session
											,ModelMap model
											,UOrderDto uorderDto ) throws Exception {
			
			UOrderDto orderDetail = mainService.selectOrderDetail(order_id);
	
			model.addAttribute("orderDetail", orderDetail);
			
			return "user/userDeliveryDetail";
		}
	   
	   
	
	
}
