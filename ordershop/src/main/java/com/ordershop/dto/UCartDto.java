package com.ordershop.dto;

import lombok.Data;

@Data
public class UCartDto extends UdefaultDto {

   private int user_no;         // 회원 번호
   private String product_no;      // 상품 번호
   private int order_cnt;         // 주문 수량
   private int  cart_id;         // 장바구니 번호
   private int price_snapshot;      // 상품 최종 가격
   private int sale_snapshot;      // 할인율
   private String total_Price;      // 최종 가격 (수량 x 가격)
   
   private String product_name;
   private String product_description;
   private String delivery_mth;
   private String delivery_fee;
   private String filepath;
   private String product_img;
   
   
   public String getFilepath() {
	return filepath;
}
public void setFilepath(String filepath) {
	this.filepath = filepath;
}
public String getProduct_img() {
	return product_img;
}
public void setProduct_img(String product_img) {
	this.product_img = product_img;
}
public String getTotal_Price() {
      return total_Price;
   }
   public void setTotal_Price(String total_Price) {
      this.total_Price = total_Price;
   }
   
   public String getProduct_name() {
      return product_name;
   }
   public void setProduct_name(String product_name) {
      this.product_name = product_name;
   }
   public String getProduct_description() {
      return product_description;
   }
   public void setProduct_description(String product_description) {
      this.product_description = product_description;
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
   
   public int getUser_no() {
      return user_no;
   }
   public void setUser_no(int user_no) {
      this.user_no = user_no;
   }
   public String getProduct_no() {
      return product_no;
   }
   public void setProduct_no(String product_no) {
      this.product_no = product_no;
   }
   public int getOrder_cnt() {
      return order_cnt;
   }
   public void setOrder_cnt(int order_cnt) {
      this.order_cnt = order_cnt;
   }
   public int getCart_id() {
      return cart_id;
   }
   public void setCart_id(int cart_id) {
      this.cart_id = cart_id;
   }
   public int getPrice_snapshot() {
      return price_snapshot;
   }
   public void setPrice_snapshot(int price_snapshot) {
      this.price_snapshot = price_snapshot;
   }
   public int getSale_snapshot() {
      return sale_snapshot;
   }
   public void setSale_snapshot(int sale_snapshot) {
      this.sale_snapshot = sale_snapshot;
   }
   
   
   
}
