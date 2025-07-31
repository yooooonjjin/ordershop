package com.ordershop.dto;

import lombok.Data;

@Data
public class UInfoDto {

   private int user_no;
   private String user_id;
   private String user_pass;
   private String user_name;
   private String user_birth;
   private String user_gender;
   private String user_phone;
   private String user_address;
   private String user_join;
   String product_img;
   String filepath;
   
   
   public String getProduct_img() {
	return product_img;
}
public void setProduct_img(String product_img) {
	this.product_img = product_img;
}
public String getFilepath() {
	return filepath;
}
public void setFilepath(String filepath) {
	this.filepath = filepath;
}
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
   
   
}
