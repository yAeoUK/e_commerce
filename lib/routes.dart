import 'package:flutter/widgets.dart';

import 'presentation/page/cart/cart_screen.dart';
import 'presentation/page/complete_profile/complete_profile_screen.dart';
import 'presentation/page/details/details_screen.dart';
import 'presentation/page/forgot_password/forgot_password_screen.dart';
import 'presentation/page/home/home_screen.dart';
import 'presentation/page/login_success/login_success_screen.dart';
import 'presentation/page/otp/otp_screen.dart';
import 'presentation/page/profile/profile_screen.dart';
import 'presentation/page/sign_in/sign_in_screen.dart';
import 'presentation/page/sign_up/sign_up_screen.dart';
import 'presentation/page/splash/splash_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => SplashScreen(),
  SignInScreen.routeName: (context) => SignInScreen(),
  ForgotPasswordScreen.routeName: (context) => ForgotPasswordScreen(),
  LoginSuccessScreen.routeName: (context) => LoginSuccessScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  OtpScreen.routeName: (context) => OtpScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  DetailsScreen.routeName: (context) => DetailsScreen(),
  CartScreen.routeName: (context) => CartScreen(),
  ProfileScreen.routeName: (context) => ProfileScreen(),
};