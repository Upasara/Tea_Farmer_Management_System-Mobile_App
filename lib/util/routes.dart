import 'package:flutter/material.dart';
import 'package:tefmasys_mobile/ui/auth_page/login_view/login_provider.dart';
import 'package:tefmasys_mobile/ui/auth_page/signup_view/signup_provider.dart';
import 'package:tefmasys_mobile/ui/auth_page/welcome_screen.dart';
import 'package:tefmasys_mobile/ui/bottom_bar/bottom_bar.dart';


abstract class Routes {
  Routes._();

  static String timeAgoSinceDate(DateTime time, {bool numericDates = true}) {
    DateTime notificationDate = time;
    final date2 = DateTime.now();

    final difference = date2.difference(notificationDate);

    if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} min ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 min ago' : 'A min ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} sec ago';
    } else {
      return 'Just now';
    }
  }

  ///main navigation using the app.
  static const LOGIN_ROUTE = "login";
  static const SIGNUP_ROUTE = "signup";
  static const HOME_ROUTE = "home";
  static const WELCOME_ROUTE = "welcome";

  static final welcome = WelcomeScreen();
  static final login = LoginProvider();
  static final home = BottomBarView();
  static final signup = SignUpProvider();

  static Route generator(RouteSettings settings) {
    switch (settings.name) {

      case LOGIN_ROUTE:
        return MaterialPageRoute(builder: (context) => login);

      case HOME_ROUTE:
        return MaterialPageRoute(builder: (context) => home);

      case WELCOME_ROUTE:
        return MaterialPageRoute(builder: (context) => welcome);

      default:
        return MaterialPageRoute(builder: (context) => login);
    }
  }
}
