package com.ordershop.controller;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.ordershop.dto.AdminDto;
import com.ordershop.dto.BlockDto;
import com.ordershop.dto.DefaultDto;
import com.ordershop.dto.DeleteDto;
import com.ordershop.dto.OrderItemDto;
import com.ordershop.dto.ProductDto;
import com.ordershop.service.AdminService;

@Controller
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	/**
	 * 수림 - 상품 S
	 */
	
	// 클래스(전역)변수
	public static String path= "C:/springWorkspace/ordershop/src/main/webapp/images";
	
	// 관리자 메인 화면 리스트
	@GetMapping("adminMain")
	public String adminMain(AdminDto admindto,DefaultDto defaultDto,ModelMap model) throws Exception{
		
		List<?> list = adminService.selectadminProductListMain();
		
		int total = adminService.selectAdminProductTotal(defaultDto);
		defaultDto.setTotal(total);

		
		model.addAttribute("productList",list);
		model.addAttribute("productTotal",total);
		
		// 회원
		// 회원목록리스트 총인원
        int total1 = adminService.selectAdminMemberListTotal(admindto);
       admindto.setFirstIndex(1);  // 첫 번째부터
       admindto.setLastIndex(6);  
       
       List<?> list1 = adminService.selectAdminMemberList(admindto);
       model.addAttribute("memberList", list1);
       model.addAttribute("total", total1);
       
    
		
		return "admin/adminMain";
	}

	// 상품등록 화면
	@GetMapping("adminProductWrite")
	public String adminProductWrite() {
		
		return "admin/adminProductWrite";
	}
	
	// 상품상세 화면
	@GetMapping("adminProductDetail/{PRODUCT_NO}")
	public String adminProductDetail(@PathVariable("PRODUCT_NO") int product_no,ModelMap model) throws Exception{
		
		// 상세보기 서비스
		ProductDto dto = adminService.selectDetailProduct(product_no);
		model.addAttribute("dto",dto);
		
		// 이전,다음 버튼 서비스
		Integer bbutton = adminService.selectBeforeDetailList(product_no);
		
		Integer nbutton = adminService.selectNextDetailList(product_no);
		
		
		model.addAttribute("bbutton",bbutton);
		model.addAttribute("nbutton",nbutton);
		
		return "admin/adminProductDetail";
	}
	
	
	
	//이전 다음 없을시 리스트 화면으로 이동
	@GetMapping("adminProductDetail/")
	public String adminProductDetailRedirect() {
	    return "redirect:/adminProductList";
	}
	
	//이전 다음 없을시 리스트 화면으로 이동
	@GetMapping("adminProductDetail")
	public String adminProductDetailRedirect2() {
	    return "redirect:/adminProductList";
	}
	
	// 상품목록 화면
	@GetMapping("adminProductList")
	public String adminProductList(@RequestParam(value = "value", required = false) String value,
	                               ModelMap model, DefaultDto defaultDto,
	                               ProductDto productDto) throws Exception {

	    if (value == null) {
	        value = "";
	    }

	    boolean isSearch = !value.trim().isEmpty();

	    List<?> list;
	    int total;

	    if (isSearch) {
	        // 🔍 검색 결과 리스트
	        List<?> searchList = adminService.selectSerachProduct(value);
	        total = searchList.size(); // 검색 결과 개수
	        defaultDto.setTotal(total);
	        defaultDto.setTotalPage();
	        defaultDto.setPageRownum();
	        defaultDto.setFirstIndex();
	        defaultDto.setLastIndex();

	        // 🔽 페이징 적용된 검색 결과 가져오려면 이 부분에 구현 필요
	         //list = adminService.selectPagedSearchProduct(value, defaultDto);
	        // 지금은 전체 검색 결과를 그대로 보여줍니다.
	         list = searchList;

	    } else {
	        // 전체 상품 리스트
	        total = adminService.selectAdminProductTotal(defaultDto);
	        defaultDto.setTotal(total);
	        defaultDto.setTotalPage();
	        defaultDto.setPageRownum();
	        defaultDto.setFirstIndex();
	        defaultDto.setLastIndex();

	        list = adminService.selectadminProductList(defaultDto);
	    }

	    model.addAttribute("list", list);
	    model.addAttribute("total", total);
	    model.addAttribute("totalPage", defaultDto.getTotalPage());
	    model.addAttribute("pageRownum", defaultDto.getPageRownum());
	    model.addAttribute("currentPage", defaultDto.getPageIndex());
	    model.addAttribute("value", value); // 검색어 유지용

	    return "admin/adminProductList";
	}

	
	// 상품 수정 화면
	@GetMapping("adminProductModify")
	public String adminProductModify(@RequestParam("product_no") int product_no,ModelMap model) throws Exception{
		
		ProductDto dto = adminService.selectDetailProduct(product_no);
		model.addAttribute("dto",dto);
		
		return "admin/adminProductModify";
	}
	
	// 상품 수정 업데이트
	@PostMapping("adminProductUpdate")
	@ResponseBody
	public String updateProduct(  MultipartHttpServletRequest request
			,ProductDto dto ) 
					throws Exception {
		
		String message = "ok";
		
		// 넘어온 데이터를 가져옴
		Map map = request.getFileMap();

		// Map의 키값(들)을 가져옴
		Iterator it = map.entrySet().iterator();
		
		String filenames = "";
		
		int cnt = 0;
		
		while( it.hasNext() ) { // 파일의 존재 유무
		
		// 키값이 있는 위치로 커서를 내려보냄
		Entry entry = (Entry) it.next();
		
		// 해당 위치에서 파일의 정보들을 가져온다. 
		MultipartFile file = (MultipartFile)entry.getValue();
		
		if( file != null && file.getSize() > 0 ) {
		
		String filename = System.currentTimeMillis()+"";
		// abc.jpg -> f2[0] = "abc"; f2[1] = "jpg";
		
		String f1   = file.getOriginalFilename();
		
		if(f1 != null && !f1.isEmpty()) {
		
			String[] f2 = f1.split("\\.");
			String exe  = f2[f2.length-1];
			
			filename += "."+exe;
			
			String filepath = path+"/"+filename;
			
			// {실 저장} / {파일 카피}
			file.transferTo(new File(filepath));
			filenames += filename;
				}
			}
		}	
		if(filenames.isEmpty()) {
			filenames = dto.getFilepath();
		}else {
			dto.setFilepath("/images/");
			dto.setProduct_img(filenames);
		}
			
		
		// ✅ 최종 가격 계산: (원가 * (100 - 할인율)) / 100
		int price = dto.getProduct_price();
		int sale = dto.getProduct_sale();
		int finalPrice = (int) Math.floor(price * (100 - sale) / 100.0);
		dto.setProduct_final_price(finalPrice); // ⬅️ 여기에 계산값 직접 넣음

		
		// 최종 인서트
		int result = adminService.updatetProduct(dto);		
		
		if( result == 0 ) message = "fail";
		
		return message;
		
		}
	// 상품 등록
	@PostMapping("adminProductInsert")
	@ResponseBody
	public String insertProduct(   MultipartHttpServletRequest request
									,ProductDto dto ) 
											throws Exception {
		
		String message = "ok";

		// 넘어온 데이터를 가져옴
		Map map = request.getFileMap();
		
		// Map의 키값(들)을 가져옴
		Iterator it = map.entrySet().iterator();
		
		String filenames = "";
		
		int cnt = 0;
		
		while( it.hasNext() ) { // 파일의 존재 유무
			
			// 키값이 있는 위치로 커서를 내려보냄
			Entry entry = (Entry) it.next();
		
			// 해당 위치에서 파일의 정보들을 가져온다. 
			MultipartFile file = (MultipartFile)entry.getValue();
			
			if( file.getSize() > 0 ) {

				String filename = System.currentTimeMillis()+"";
				// abc.jpg -> f2[0] = "abc"; f2[1] = "jpg";
				
				String f1   = file.getOriginalFilename();
				
				String[] f2 = f1.split("\\.");
				String exe  = f2[f2.length-1];
				
				filename += "."+exe;
				
				String filepath = path+"/"+filename;

				// {실 저장} / {파일 카피}
				file.transferTo(new File(filepath));
				filenames += filename;
			}
		}
		
		dto.setFilepath("/images/");
		dto.setProduct_img(filenames);
	
		 // ✅ 최종 가격 계산: (원가 * (100 - 할인율)) / 100
	    int price = dto.getProduct_price();
	    int sale = dto.getProduct_sale();
	    int finalPrice = (int) Math.floor(price * (100 - sale) / 100.0);
	    dto.setProduct_final_price(finalPrice); // ⬅️ 여기에 계산값 직접 넣음
		
	    // 최종 인서트
		int result = adminService.insertProduct(dto);
		
		
		if( result == 0 ) message = "fail";
		
		return message;
	}
		
	
	// 상품리스트에서 삭제(체크박스)
		@PostMapping("adminProductDelete")
		@ResponseBody
		public String deleteAdminProduct(@RequestBody List<Long> productIds) throws Exception{

		    try {
		        adminService.deleteProducts(productIds);  // 서비스 호출
		        return "선택된 상품이 삭제되었습니다.";
		    } catch (Exception e) {
		        e.printStackTrace();
		        return "삭제 중 오류가 발생했습니다.";
		    }
		}
	
	// 상품상세화면에서 삭제
	@PostMapping("adminDetailDelete")
	@ResponseBody
	public String adminDetailDelete(ProductDto dto) throws Exception{
		
		String msg = "1";
		
		int result = adminService.adminDetailDelete(dto);
		
		if(result == 0) msg = "2";
		
		
		return msg;
	}
	
	// ----------------------------주문관리--------------------------------------
	
	// 관리자 주문목록
	@GetMapping("adimOrderItemList")
	public String adimOrderItemList(@RequestParam(value = "value", required = false) String value,
	                               ModelMap model, DefaultDto defaultDto,
	                               OrderItemDto orderItemDto) throws Exception {

	    if (value == null) {
	        value = "";
	    }

	    boolean isSearch = !value.trim().isEmpty();

	    List<?> list;
	    int total;

	    if (isSearch) {
	        // 🔍 검색 결과 리스트
	        List<?> searchList = adminService.selectSerachOrder(value);
	        total = searchList.size(); // 검색 결과 개수
	        defaultDto.setTotal(total);
	        defaultDto.setTotalPage();
	        defaultDto.setPageRownum();
	        defaultDto.setFirstIndex();
	        defaultDto.setLastIndex();

	        // 🔽 페이징 적용된 검색 결과 가져오려면 이 부분에 구현 필요
	         //list = adminService.selectPagedSearchProduct(value, defaultDto);
	        // 지금은 전체 검색 결과를 그대로 보여줍니다.
	         list = searchList;

	    } else {
	        // 전체 상품 리스트
	        total = adminService.selectAdminOrderTotal(defaultDto);
	        defaultDto.setTotal(total);
	        defaultDto.setTotalPage();
	        defaultDto.setPageRownum();
	        defaultDto.setFirstIndex();
	        defaultDto.setLastIndex();

	        list = adminService.adimOrderItemList(defaultDto);
	    }

	    model.addAttribute("list", list);
	    model.addAttribute("total", total);
	    model.addAttribute("totalPage", defaultDto.getTotalPage());
	    model.addAttribute("pageRownum", defaultDto.getPageRownum());
	    model.addAttribute("currentPage", defaultDto.getPageIndex());
	    model.addAttribute("value", value); // 검색어 유지용

	    return "admin/adimOrderItemList";
	}
	// 관리자취소목록
	
	@GetMapping("adimCancelOrderList")
	public String adimCancelOrderList(@RequestParam(value = "value", required = false) String value,
	                               ModelMap model, DefaultDto defaultDto,
	                               OrderItemDto orderItemDto) throws Exception {

	    if (value == null) {
	        value = "";
	    }

	    boolean isSearch = !value.trim().isEmpty();

	    List<?> list;
	    int total;

	    if (isSearch) {
	        // 🔍 검색 결과 리스트
	        List<?> searchList = adminService.selectSerachCancelOrder(value);
	        total = searchList.size(); // 검색 결과 개수
	        defaultDto.setTotal(total);
	        defaultDto.setTotalPage();
	        defaultDto.setPageRownum();
	        defaultDto.setFirstIndex();
	        defaultDto.setLastIndex();

	        // 🔽 페이징 적용된 검색 결과 가져오려면 이 부분에 구현 필요
	         //list = adminService.selectPagedSearchProduct(value, defaultDto);
	        // 지금은 전체 검색 결과를 그대로 보여줍니다.
	         list = searchList;

	    } else {
	        // 전체 상품 리스트
	        total = adminService.selectAdminCancelOrderTotal(defaultDto);
	        defaultDto.setTotal(total);
	        defaultDto.setTotalPage();
	        defaultDto.setPageRownum();
	        defaultDto.setFirstIndex();
	        defaultDto.setLastIndex();

	        list = adminService.adimCancelOrderItemList(defaultDto);
	    }

	    model.addAttribute("list", list);
	    model.addAttribute("total", total);
	    model.addAttribute("totalPage", defaultDto.getTotalPage());
	    model.addAttribute("pageRownum", defaultDto.getPageRownum());
	    model.addAttribute("currentPage", defaultDto.getPageIndex());
	    model.addAttribute("value", value); // 검색어 유지용

	    return "admin/adimCancelOrderList";
	}
	
	@PostMapping("updateCancelStatus")
	@ResponseBody
	public String updateCancelStatus(String datas) throws Exception{
		
		String msg = "ok";
		
		
		
		int result = adminService.updateCancelStatus(datas);
		
		if(result == 0) msg = "fail";
		
		return msg;
	}
	
	/**
	 * 수림 - 상품 E
	 */
	
	/**
	 * 다연 - 회원 S
	 */

 //회원목록리스트
    
    @GetMapping("adminMemberList")
    public String selectAdminMemberList(AdminDto admindto,
                                        @RequestParam(value = "key", required = false) String key,
                                        @RequestParam(value = "value", required = false) String value,
                                        ModelMap model) throws Exception {
        if (value == null || value.trim().isEmpty()) {
            value = "";
        }
        
        if (key == null || key.trim().isEmpty()) {
            key = "member_id"; // 기본 검색 키
        }
        
        int total;
        List<?> list;
        
        if (value.isEmpty()) {
            // 전체 데이터 총 개수
            total = adminService.selectAdminMemberListTotal(admindto);
        } else {
            // 검색된 데이터 총 개수
            total = adminService.selectSearchMemberTotal(key, value);
        }
        
        admindto.setTotal(total);
        admindto.setTotalPage();
        admindto.setPageRownum();
        admindto.setFirstIndex();
        admindto.setLastIndex();
        
        if (value.isEmpty()) {
            list = adminService.selectAdminMemberList(admindto);
        } else {
            list = adminService.selectSearchMember(key, value, admindto);
        }
        
        model.addAttribute("currentPage", admindto.getPageIndex());
        model.addAttribute("memberList", list);
        model.addAttribute("total", total);
        model.addAttribute("pageRownum", admindto.getPageRownum());
        model.addAttribute("totalPage", admindto.getTotalPage());
        
        return "admin/adminMemberList";
    }


    //회원목록리스트 자세히보기   
   @GetMapping("adminMemberDetail/{user_no}")
   public String selectadminMemberDetail(@PathVariable int user_no, ModelMap model) throws Exception {
       AdminDto admindto = adminService.selectadminMemberListDetail(user_no);
       model.addAttribute("admindto", admindto);
       

       return "admin/adminMemberDetail";
   }
   
   //회원 삭제 
   @PostMapping("adminDeleteMember")
   @ResponseBody
   public String adminDeleteMember(@RequestParam("user_no") int user_no,
                                   @RequestParam("delete_reason") String delete_reason) throws Exception {
   
       // 1. 삭제할 회원 정보 조회
       AdminDto deletemember = adminService.getMemberByUserNo(user_no);

       if (deletemember == null) {
           return "0";  // 회원 정보 없음
       }
      
       // 2. 삭제 기록용 DTO 만들기 (삭제 정보 + 삭제 사유)
       DeleteDto deletedto = new DeleteDto();  // DeleteDto 클래스명 정확히 맞춰서 사용
       deletedto.setUser_no(deletemember.getUser_no());
       deletedto.setUser_id(deletemember.getUser_id()); 
       deletedto.setUser_name(deletemember.getUser_name());
       deletedto.setUser_join(deletemember.getUser_join());
       deletedto.setDelete_reason(delete_reason);
       String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
       deletedto.setDelete_date(now);
       
       // 3. 삭제 테이블에 저장
       int saveResult = adminService.saveDeletedMember(deletedto);
       if (saveResult <= 0) {
           return "2"; // 삭제 기록 저장 실패
       }


       //원본 테이블에서 실제 삭제 대신 논리 삭제
       int deleteResult = adminService.setMemberAsDeleted(user_no);  
       
       return deleteResult > 0 ? "1" : "3";
      
   }



   //관리자 삭제멤버리스트
   @GetMapping("adminMemberDeleteList")
   public String adminMemberDelete(DeleteDto deletedto,
                                   @RequestParam(value = "key", required = false) String key,
                                   @RequestParam(value = "value", required = false) String value,
                                   ModelMap model) throws Exception {

      if (key == null || key.trim().isEmpty()) {
           key = "member_id";
       }
       if (value == null || value.trim().isEmpty()) {
           value = "";
       }

       int total;
       List<?> list;
       
       if (value.isEmpty()) {
           total = adminService.selectDeleteMemberListTotal(deletedto);
       } else {
           total = adminService.selectSearchDeleteMemberTotal(key, value);
       }

       deletedto.setTotal(total);
       deletedto.setTotalPage();
       deletedto.setPageRownum();
       deletedto.setFirstIndex();  
       deletedto.setLastIndex();  

       if (value.isEmpty()) {
           list = adminService.selectDeleteMemberList(deletedto);
       } else {

           list = adminService.selectSearchDeleteMember(key, value, deletedto);
       }

       model.addAttribute("currentPage", deletedto.getPageIndex());
       model.addAttribute("deletememberList", list);
       model.addAttribute("total", total);
       model.addAttribute("pageRownum", deletedto.getPageRownum());
       model.addAttribute("totalPage", deletedto.getTotalPage());


      

       return "admin/adminMemberDeleteList";
   }

 //회원 차단 
   @PostMapping("adminBlockMember")
   @ResponseBody
   public String adminBlockMember(@RequestParam("user_no") int user_no,
                                   @RequestParam("block_reason") String block_reason) throws Exception {
   
       // 1. 차단할 회원 정보 조회    -> 삭제테이블 삭제할 회원 정보 조회 재사
       AdminDto blockmember = adminService.getMemberByUserNo(user_no);

       if (blockmember == null) {
           return "0";  // 회원 정보 없음
       }
      
       // 2. 차단 기록용 DTO 만들기 (차단 정보 + 차단 사유)
       BlockDto blockdto = new BlockDto();  
       blockdto.setUser_no(blockmember.getUser_no());
       blockdto.setUser_id(blockmember.getUser_id()); 
       blockdto.setUser_name(blockmember.getUser_name());
       blockdto.setUser_join(blockmember.getUser_join());
       blockdto.setBlock_reason(block_reason);
       String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));
       blockdto.setBlock_date(now);
       
       // 3. 차단 테이블에 저장
       int saveResult = adminService.saveBlockedMember(blockdto);
       if (saveResult <= 0) {
           return "2"; // 차단 기록 저장 실패
       }
       
      
       //원본 테이블에서 실제 차단 대신 논리 차단
       int blockResult = adminService.setMemberAsBlocked(user_no);  
       
       return blockResult > 0 ? "1" : "3";
      
   }
   
   
   //관리자 차단멤버리스트
   @GetMapping("adminMemberBlockList")
   public String adminMemberBlock(BlockDto blockdto,
                                   @RequestParam(value = "key", required = false) String key,
                                   @RequestParam(value = "value", required = false) String value,
                                   ModelMap model) throws Exception {

      if (key == null || key.trim().isEmpty()) {
           key = "member_id";
       }
       if (value == null || value.trim().isEmpty()) {
           value = "";
       }

       int total;
       List<?> list;
       
       if (value.isEmpty()) {
           total = adminService.selectBlockMemberListTotal(blockdto);
       } else {
           total = adminService.selectSearchBlockMemberTotal(key, value);
       }

       blockdto.setTotal(total);
       blockdto.setTotalPage();
       blockdto.setPageRownum();
       blockdto.setFirstIndex();  
       blockdto.setLastIndex();  

       if (value.isEmpty()) {
           list = adminService.selectBlockMemberList(blockdto);
       } else {

           list = adminService.selectSearchBlockMember(key, value, blockdto);
       }

       model.addAttribute("currentPage", blockdto.getPageIndex());
       model.addAttribute("blockmemberList", list);
       model.addAttribute("total", total);
       model.addAttribute("pageRownum", blockdto.getPageRownum());
       model.addAttribute("totalPage", blockdto.getTotalPage());


      

       return "admin/adminMemberBlockList";
   }

   
   //회원 일괄삭제기능
   @PostMapping("adminDeleteMemberBulk")
   @ResponseBody
   public String adminDeleteMemberBulk(@RequestParam("user_nos") List<Integer> userNos,
                                       @RequestParam("delete_reason") String reason)throws Exception{
       for (Integer userNo : userNos) {
           adminService.logicDeleteUser(userNo, reason);
       }
       return "ok";
   }
   




	
}
