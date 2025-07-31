package com.ordershop.dto;

import lombok.Data;

@Data
public class UPaymentDto {
   
   private String pay_id;
   private String order_id;
   private String product_no;
   private int user_no;
   private String pay_date;
   private String pay_method;
   private String pay_status;
   private int total_price;
   private String delivery_request;
   private int product_final_price;
   
   private int order_cnt;
   
   public int getProduct_final_price() {
      return product_final_price;
   }
   public void setProduct_final_price(int product_final_price) {
      this.product_final_price = product_final_price;
   }
   public int getOrder_cnt() {
      return order_cnt;
   }
   public void setOrder_cnt(int order_cnt) {
      this.order_cnt = order_cnt;
   }
   public String getPay_id() {
      return pay_id;
   }
   public void setPay_id(String pay_id) {
      this.pay_id = pay_id;
   }
   public String getOrder_id() {
      return order_id;
   }
   public void setOrder_id(String order_id) {
      this.order_id = order_id;
   }
   public String getProduct_no() {
      return product_no;
   }
   public void setProduct_no(String product_no) {
      this.product_no = product_no;
   }
   public int getUser_no() {
      return user_no;
   }
   public void setUser_no(int user_no) {
      this.user_no = user_no;
   }
   public String getPay_date() {
      return pay_date;
   }
   public void setPay_date(String pay_date) {
      this.pay_date = pay_date;
   }
   public String getPay_method() {
      return pay_method;
   }
   public void setPay_method(String pay_method) {
      this.pay_method = pay_method;
   }
   public String getPay_status() {
      return pay_status;
   }
   public void setPay_status(String pay_status) {
      this.pay_status = pay_status;
   }
   public int getTotal_price() {
      return total_price;
   }
   public void setTotal_price(int total_price) {
      this.total_price = total_price;
   }
   public String getCancel_num() {
      return cancel_num;
   }
   public void setCancel_num(String cancel_num) {
      this.cancel_num = cancel_num;
   }
   private String cancel_num;
   
   public String getDelivery_request() {
      return delivery_request;
   }
   public void setDelivery_request(String delivery_request) {
      this.delivery_request = delivery_request;
   }
}
