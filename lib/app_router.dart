import 'package:flutter/material.dart';
import 'package:flutter_map_booking/Screen/Directions/screens/cancellation_reasons_screen/cancellation_reasons_screen.dart';
import 'package:flutter_map_booking/Screen/Directions/screens/chat_screen/chat_screen.dart';
import 'package:flutter_map_booking/Screen/History/driver_detail.dart';
import 'package:flutter_map_booking/Screen/History/history_screen.dart';
import 'package:flutter_map_booking/Screen/Home/home2.dart';
import 'package:flutter_map_booking/Screen/Home/home_screen.dart';
import 'package:flutter_map_booking/Screen/Notification/notification.dart';
import 'package:flutter_map_booking/Screen/PaymentMethod/payment_method.dart';
import 'package:flutter_map_booking/Screen/Settings/settings.dart';
import 'package:flutter_map_booking/Screen/Settings/terms_conditions_screen.dart';
import 'package:flutter_map_booking/Screen/SignUp/signup.dart';
import 'package:flutter_map_booking/Screen/Login/login.dart';
import 'Screen/General/identidy_check.dart';
import 'Screen/Membership/memberships.dart';
import 'Screen/MyProfile/profile.dart';
import 'Screen/ReviewTrip/review_trip_screen.dart';
import 'Screen/SignUp/forgot_password.dart';
import 'Screen/SignUp/phone_signup.dart';
import 'Screen/SplashScreen/splash_screen.dart';
import 'Screen/intro_screen/intro_screen.dart';

class PageViewTransition<T> extends MaterialPageRoute<T> {
  PageViewTransition({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
//    if (settings.isInitialRoute) return child;
    if (animation.status == AnimationStatus.reverse)
      return super
          .buildTransitions(context, animation, secondaryAnimation, child);
    return FadeTransition(opacity: animation, child: child);
  }
}

class AppRoute {
  static const String splashScreen = '/splashScreen';
  static const String loginScreen = '/login';
  static const String signUpScreen = '/signup';
  static const String forgotPassword = '/forgotPassword';
  static const String introScreen = '/intro';
  static const String identityCheckScreen = '/identityCheck';
  static const String phoneVerificationScreen = '/PhoneVerification';
  static const String newsLetter = '/newsLetter';
  static const String homeScreen = '/home';
  static const String homeScreen2 = '/home2';
  static const String searchScreen = '/search';
  static const String notificationScreen = '/notification';
  static const String profileScreen = '/profile';
  static const String paymentMethodScreen = '/paymentMethod';
  static const String historyScreen = '/history';
  static const String driverDetailScreen = '/driverDetail';
  static const String settingsScreen = '/settings';
  static const String reviewTripScreen = '/reviewTrip';
  static const String cancellationReasonsScreen = '/cancellationReasons';
  static const String termsConditionsScreen = '/termsConditions';
  static const String membershipsScreen = '/memberships';
  static const String chatScreen = '/chat';
  static const String phoneSignupScreen = '/phoneSignupScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashScreen:
        return PageViewTransition(builder: (_) => SplashScreen());
      case loginScreen:
        return PageViewTransition(builder: (_) => LoginScreen());
      case phoneSignupScreen:
        return PageViewTransition(builder: (_) => PhoneSignUpScreen());
      case introScreen:
        return PageViewTransition(builder: (_) => IntroScreen());
      case identityCheckScreen:
        return PageViewTransition(builder: (_) => IdentityCheckScreen());
      case homeScreen:
        return PageViewTransition(builder: (_) => HomeScreens());
      case homeScreen2:
        return PageViewTransition(builder: (_) => HomeScreen2());
      case forgotPassword:
        return PageViewTransition(builder: (_) => ForgotPasswordScreen());
      case signUpScreen:
        return PageViewTransition(builder: (_) {
//          final Object args = settings.arguments;
//          final bool isPhone = args ?? bool;
          return SignupScreen();
        });
      case notificationScreen:
        return PageViewTransition(builder: (_) => NotificationScreens());
      case profileScreen:
        return PageViewTransition(builder: (_) => ProfileScreen());
      case paymentMethodScreen:
        return PageViewTransition(builder: (_) => PaymentMethodScreen());
      case historyScreen:
        return PageViewTransition(builder: (_) => HistoryScreen());
      case settingsScreen:
        return PageViewTransition(builder: (_) => SettingsScreen());
      case reviewTripScreen:
        return PageViewTransition(builder: (_) => ReviewTripScreen());
      case cancellationReasonsScreen:
        return PageViewTransition(builder: (_) => CancellationReasonsScreen());
      case termsConditionsScreen:
        return PageViewTransition(builder: (_) => TermsConditionsScreen());
      case membershipsScreen:
        return PageViewTransition(builder: (_) => MembershipsScreen());
      case driverDetailScreen:
        return PageViewTransition(builder: (_) => DriverDetailScreen());
      case chatScreen:
        return PageViewTransition(builder: (_) => ChatScreen());
      default:
        return PageViewTransition(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
