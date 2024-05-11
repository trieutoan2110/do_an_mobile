class StringConstant {
  //paypal
  static const String clientId = "AUrlDpVCCSbhSfiF716Rdql0Ro2dGdwvQJ7Nln0FWjK87vKUcKTK6zF14GyBSBXtwcIEw2EOmJTZnPC0";
  static const String secretKey = "EOoCUqLTjYXsb2mMArUsIQuhPadYUklgoaXw0XxodJUratMM-2AAQsY3GP68lO6TS9cZv5abAWju3bRE";


  //SharedPreferences
  static const String key_token = 'token';
  static const String is_login = 'isLogin';
  static const String is_logout = 'isLogout';
  static const String username = 'username';
  static const String phone_number = 'phone_number';
  static const String address = 'address';
  static const String ranking = 'ranking';
  static const String avatarUrl = 'avatar';
  static const String email = 'email';

  //infor screen
  static const name = 'name';
  static const phone = 'phone';

  static const cloudName = 'debcojldf';

  //AppBar title
  ////AppBar authen
  static const String log_in_title = 'Log in';
  static const String forgot_password_title = 'Porgot password';
  static const String register_title = 'Register';
  static const String verification_title = 'Verification code';
  ////AppBar main
  static const String home_title = 'Home';
  static const String cart_title = 'Cart';
  static const String wishlist_title = 'Wishlist';
  static const String me_title = 'Me';

  //Button authen
  static const String sign_in_button_title = "Sign In";
  static const String log_out_button_title = 'Log out';
  static const String sign_up_button_title = "Sign Up";
  static const String register_button_title = 'Register';
  static const String forgot_password_button_title = "Forgot password?";
  static const String send_email_button_title = 'Next';
  static const String send_otp_button_title = 'Send';

  //hintText
  static const String email_hintText_title = 'Email';
  static const String password_hintText_title = 'Password';
  static const String fullname_hintText_title = 'Fullname';
  static const String retype_password_hintText_title = 'Re-type password';

  //Toast
  static const String login_incorrect = 'email or password is incorrect';
  static const String register_incorrect = 'Re-type password is incorrect';

  //Home title
  static const String product_category_title = 'Product Category';
  static const String product_best_sellers_title = 'Product best seller';
  static const String product_best_rates_title = 'Product best rate';
  static const String product_featureds_title = 'Product Featured';

  static const String buy_button_title = 'Buy now';
  static const String description = 'Description';
  static const String feedback = 'Feedback';
  static const String rate = 'Rate';
  static const String quantity = 'Quantity';
  static const String delivery_address = 'Delivery Address';
  static const String voucher = 'Voucher';
  static const String payment_method = 'Payment Method';
  static const String paymet_details = 'Payment Details';
  static const String total_payment = 'Total Payment';
  static const String place_order = 'Place Order';
  static const String submit = 'Submit';
  static const String product_quantity = 'Product Quantity';
  static const String terrible = 'Terrible';
  static const String poor = 'Poor';
  static const String fair = 'Fair';
  static const String good = 'Good';
  static const String amazing = 'Amazing';

  static const String to_pay = 'To Pay';
  static const String to_ship = 'To Ship';
  static const String to_receive = 'To Receive';
  static const String to_rate = 'To Rate';
  static const String complete = 'Complete';
  static const String cancelled = 'Cancelled';
  static const String return_refund = 'Return Refund';

  static const String delivery_process = 'Delivery process';
  static const String order_success = 'Order Success';

  static const String paypal = 'Paypal';
  static const String onDelivery = 'on Delivery';
}

enum PaymentMethod {
  paypal,
  onDelivery
}