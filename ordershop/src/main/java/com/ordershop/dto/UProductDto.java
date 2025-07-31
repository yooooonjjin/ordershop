package com.ordershop.dto;

import lombok.Data;

@Data
public class UProductDto extends UdefaultDto {
   
   private String product_no;            // 상품 번호
   private String product_name;         // 상품명
   private int product_price;            // 상품 가격
   private String product_description;      // 상품 설명
   private int product_sale;            // 상품 할인율
   private String product_img;            // 상품 이미지(경로)
   private String delivery_mth;         // 배송 방법
   private String delivery_fee;         // 배송비
   private String registration_date;      // 상품 등록 날짜
   private int sales_cnt;               // 판매 수량
   private int view_cnt;               // 조회수
   private String product_status;         // 상품 상태
   private int product_final_price;      // 상품 최종 가격 (할인율 반영)
   private String sortType;
   private int Price_snapshot;
    private int final_price;
    private int total_price;
    private String filepath;
    

public String getFilepath() {
		return filepath;
	}
	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}
public int getFinal_price() {
      return final_price;
   }
   public void setFinal_price(int final_price) {
      this.final_price = final_price;
   }
   public int getTotal_price() {
      return total_price;
   }
   public void setTotal_price(int total_price) {
      this.total_price = total_price;
   }
   public int getPrice_snapshot() {
      return Price_snapshot;
   }
   public void setPrice_snapshot(int price_snapshot) {
      Price_snapshot = price_snapshot;
   }
   public int getOrder_cnt() {
      return order_cnt;
   }
   public void setOrder_cnt(int order_cnt) {
      this.order_cnt = order_cnt;
   }
   private int order_cnt;

   public String getProduct_no() {
      return product_no;
   }
   public void setProduct_no(String product_no) {
      this.product_no = product_no;
   }
   public String getProduct_name() {
      return product_name;
   }
   public void setProduct_name(String product_name) {
      this.product_name = product_name;
   }
   public int getProduct_price() {
      return product_price;
   }
   public void setProduct_price(int product_price) {
      this.product_price = product_price;
   }
   public String getProduct_description() {
      return product_description;
   }
   public void setProduct_description(String product_description) {
      this.product_description = product_description;
   }
   public int getProduct_sale() {
      return product_sale;
   }
   public void setProduct_sale(int product_sale) {
      this.product_sale = product_sale;
   }
   public String getProduct_img() {
      return product_img;
   }
   public void setProduct_img(String product_img) {
      this.product_img = product_img;
   }
   public String getDelivery_mth() {
      return delivery_mth;
   }
   public void setDelivery_mth(String delivery_mth) {
      this.delivery_mth = delivery_mth;
   }
   public String getDelivery_fee() {
      return delivery_fee;
   }
   public void setDelivery_fee(String delivery_fee) {
      this.delivery_fee = delivery_fee;
   }
   public String getRegistration_date() {
      return registration_date;
   }
   public void setRegistration_date(String registration_date) {
      this.registration_date = registration_date;
   }
   public int getSales_cnt() {
      return sales_cnt;
   }
   public void setSales_cnt(int sales_cnt) {
      this.sales_cnt = sales_cnt;
   }
   public int getView_cnt() {
      return view_cnt;
   }
   public void setView_cnt(int view_cnt) {
      this.view_cnt = view_cnt;
   }
   public String getProduct_status() {
      return product_status;
   }
   public void setProduct_status(String product_status) {
      this.product_status = product_status;
   }
   public int getProduct_final_price() {
      return product_final_price;
   }
   public void setProduct_final_price(int product_final_price) {
      this.product_final_price = product_final_price;
   }
   public String getSortType() {
      return sortType;
   }
   public void setSortType(String sortType) {
      this.sortType = sortType;
   }

}
