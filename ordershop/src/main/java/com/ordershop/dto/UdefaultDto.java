package com.ordershop.dto;

import lombok.Data;

@Data
public class UdefaultDto {
	   
	   // 검색
	   // 검색 대상 컬럼 (상품명, 제목)
	   private String searchField;

	   // 검색어
	   private String searchWord;
	   
	   
	   // 정렬
	   // 정렬 타입
	   private String sortType = "recent";      // 기본값 : 최신순
	   
	   
	   // 페이징
	   // 현재 페이지 번호 (기본 1)
	   private int pageIndex = 1;
	   
	   // 한 페이지당 데이터 수
	   private int pageUnit = 12;
	   
	   // 한 번에 보여줄 페이지 수 (페이지네이션)
	   private int pageSize = 10;
	   
	   // 시작 페이지 번호
	   private int firstPage = 1;
	   
	   // 종료 페이지 번호
	   private int lastPage = 1;
	   
	   // 전체 데이터 개수
	   private int total = 0;
	   
	   // 전체 페이지 개수
	   private int totalPage = 0;
	   
	   // 리스트 번호 역순(화면 출력용)
	   private int pageRownum = 0;
	   
	   // sql 적용 : 시작 행 번호
	   private int firstIndex = 1;
	   
	   // sql 적용 : 끝 행 번호
	   private int lastIndex = 10;

	   
	   // 검색
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
	   
	   // 정렬
	   public String getSortType() {
	      return sortType;
	   }

	   public void setSortType(String sortType) {
	      this.sortType = sortType;
	   }

	   // 페이징
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

	   public int getTotal() {
	      return total;
	   }

	   public void setTotal(int total) {
	      this.total = total;
	   }

	   public int getTotalPage() {
	      return totalPage;
	   }

	   public void setTotalPage(int totalPage) {
	      this.totalPage = (int)Math.ceil((double)total/pageUnit);
	   }

	   public int getPageRownum() {
	      return pageRownum;
	   }

	   public void setPageRownum(int pageRownum) {
	      this.pageRownum = total - (pageIndex-1) * pageUnit;
	   }

	   public int getFirstIndex() {
	      return firstIndex;
	   }

	   public void setFirstIndex(int firstIndex) {
	      this.firstIndex = (pageIndex -1) * pageUnit + 1;
	   }

	   public int getLastIndex() {
	      return lastIndex;
	   }

	   public void setLastIndex(int lastIndex) {
	      this.lastIndex = firstIndex + (pageUnit -1);
	   }


	
}
