package com.ordershop.dto;

public class BlockDto {

   
   int user_no;
   String user_id;
   String user_name;
   String block_date;
   String block_reason;
   String user_join;
   
   
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
   public String getUser_name() {
      return user_name;
   }
   public void setUser_name(String user_name) {
      this.user_name = user_name;
   }
   public String getBlock_date() {
      return block_date;
   }
   public void setBlock_date(String block_date) {
      this.block_date = block_date;
   }
   public String getBlock_reason() {
      return block_reason;
   }
   public void setBlock_reason(String block_reason) {
      this.block_reason = block_reason;
   }
   public String getUser_join() {
      return user_join;
   }
   public void setUser_join(String user_join) {
      this.user_join = user_join;
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

}
