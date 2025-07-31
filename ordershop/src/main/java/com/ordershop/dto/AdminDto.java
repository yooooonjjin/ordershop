package com.ordershop.dto;

public class AdminDto {
	   
	   int user_no;
	   String user_id;
	   String user_pass;
	   String user_name;
	   String user_birth;
	   String user_gender;
	   String user_phone;
	   String user_address;
	   String user_join;
	   
	   String is_deleted;
	   String is_blocked;
	   
	   
	   public int getUser_no() {
	      return user_no;
	   }
	   public void setUser_no(int user_no) {
	      this.user_no = user_no;
	   }
	   public String getUser_id() {
	      return user_id;
	   }
	   public void setUser_id(String user_id) {
	      this.user_id = user_id;
	   }
	   public String getUser_pass() {
	      return user_pass;
	   }
	   public void setUser_pass(String user_pass) {
	      this.user_pass = user_pass;
	   }
	   public String getUser_name() {
	      return user_name;
	   }
	   public void setUser_name(String user_name) {
	      this.user_name = user_name;
	   }
	   public String getUser_birth() {
	      return user_birth;
	   }
	   public void setUser_birth(String user_birth) {
	      this.user_birth = user_birth;
	   }
	   public String getUser_gender() {
	      return user_gender;
	   }
	   public void setUser_gender(String user_gender) {
	      this.user_gender = user_gender;
	   }
	   public String getUser_phone() {
	      return user_phone;
	   }
	   public void setUser_phone(String user_phone) {
	      this.user_phone = user_phone;
	   }
	   public String getUser_address() {
	      return user_address;
	   }
	   public void setUser_address(String user_address) {
	      this.user_address = user_address;
	   }
	   public String getUser_join() {
	      return user_join;
	   }
	   public void setUser_join(String user_join) {
	      this.user_join = user_join;
	   }
	   
	   public String getIs_deleted() {
	      return is_deleted;
	   }
	   public void setIs_deleted(String is_deleted) {
	      this.is_deleted = is_deleted;
	   }
	   public String getIs_blocked() {
	      return is_blocked;
	   }
	   public void setIs_blocked(String is_blocked) {
	      this.is_blocked = is_blocked;
	   }
	   
	   
	   // 검색 조건
	   String searchField;
	   
	   // 검색 단어
	   String searchWord;

	   // 현재 페이지 번호
	   int pageIndex = 1;
	   
	   // 한 화면에서의 출력 단위
	   int pageUnit = 10;
	   
	   //  1 ~ 10 [next]  // 11 ~ 20
	   int pageSize = 10;
	   
	   // 시작 페이지 번호
	   int firstPage = 1;
	   
	   // 종료 페이지 번호
	   int lastPage = 1;

	   // 총 데이터 개수
	   int total = 0;
	   
	   // 총 페이지 개수
	   int totalPage = 0;
	   
	   // 출력 페이지의 시작(행)번호
	   int pageRownum = 0;

	   // SQL에 적용할 시작번호
	   int firstIndex = 0;
	   
	   // SQL에 적용할 종료번호
	   int lastIndex  = 0;
	   
	   
	   public int getPageRownum() {
	      return pageRownum;
	   }

	   public void setPageRownum() {
	      this.pageRownum = total - (pageIndex-1)*pageUnit;
	   }

	   public void setTotalPage(int totalPage) {
	      this.totalPage = totalPage;
	   }

	   public int getTotal() {
	      return total;
	   }

	   public void setTotal(int total) {
	      this.total = total;
	   }

	   public int getTotalPage() {
	      return totalPage;
	   }

	   public void setTotalPage() {
	      
	      this.totalPage = (int)Math.ceil((double)total/pageUnit);
	      
	   }

	   public int getFirstIndex() {
	      return firstIndex;
	   }

	   public void setFirstIndex() {
	      this.firstIndex = (pageIndex-1)*pageUnit + 1;
	   }

	   public int getLastIndex() {
	      return lastIndex;
	   }

	   public void setLastIndex() {
	      this.lastIndex = firstIndex + (pageUnit-1);
	   }

	   // 메인에서 사용할 인덱스 추가 

	   public void setFirstIndex(int firstIndex) {
	       this.firstIndex = firstIndex;
	   }

	   public void setLastIndex(int lastIndex) {
	       this.lastIndex = lastIndex;
	   }

	   
	   
	   
	   public String getSearchField() {
	      return searchField;
	   }

	   public void setSearchField(String searchField) {
	      this.searchField = searchField;
	   }

	   public String getSearchWord() {
	      return searchWord;
	   }

	   public void setSearchWord(String searchWord) {
	      this.searchWord = searchWord;
	   }

	   public int getPageIndex() {
	      return pageIndex;
	   }

	   public void setPageIndex(int pageIndex) {
	      this.pageIndex = pageIndex;
	   }

	   public int getPageUnit() {
	      return pageUnit;
	   }

	   public void setPageUnit(int pageUnit) {
	      this.pageUnit = pageUnit;
	   }

	   public int getPageSize() {
	      return pageSize;
	   }

	   public void setPageSize(int pageSize) {
	      this.pageSize = pageSize;
	   }

	   public int getFirstPage() {
	      return firstPage;
	   }

	   public void setFirstPage(int firstPage) {
	      this.firstPage = firstPage;
	   }

	   public int getLastPage() {
	      return lastPage;
	   }

	   public void setLastPage(int lastPage) {
	      this.lastPage = lastPage;
	   }
	   
	   
	   //검색을 위해 추가 
	       private String key;
	       private String value;

	     

	       public String getKey() {
	           return key;
	       }
	       public void setKey(String key) {
	           this.key = key;
	       }

	       public String getValue() {
	           return value;
	       }
	       public void setValue(String value) {
	           this.value = value;
	       }

	     // 로그인시 필요한 정보
	       
	       int log_num;
	       String admin_id;
	       String admin_pass;
	       String action;
	       String action_time;
	       String  product_no;
	       String order_id;
	       String  cancel_num;







	      public int getLog_num() {
	         return log_num;
	      }
	      public void setLog_num(int log_num) {
	         this.log_num = log_num;
	      }
	      public String getAdmin_id() {
	         return admin_id;
	      }
	      public void setAdmin_id(String admin_id) {
	         this.admin_id = admin_id;
	      }
	      public String getAdmin_pass() {
	         return admin_pass;
	      }
	      public void setAdmin_pass(String admin_pass) {
	         this.admin_pass = admin_pass;
	      }
	      public String getAction() {
	         return action;
	      }
	      public void setAction(String action) {
	         this.action = action;
	      }
	      public String getAction_time() {
	         return action_time;
	      }
	      public void setAction_time(String action_time) {
	         this.action_time = action_time;
	      }
	      public String getProduct_no() {
	         return product_no;
	      }
	      public void setProduct_no(String product_no) {
	         this.product_no = product_no;
	      }
	      public String getOrder_id() {
	         return order_id;
	      }
	      public void setOrder_id(String order_id) {
	         this.order_id = order_id;
	      }
	      public String getCancel_num() {
	         return cancel_num;
	      }
	      public void setCancel_num(String cancel_num) {
	         this.cancel_num = cancel_num;
	      }
	      public void setPageRownum(int pageRownum) {
	         this.pageRownum = pageRownum;
	      }
	   

	
}
