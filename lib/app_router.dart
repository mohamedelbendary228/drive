import 'package:flutter/material.dart';

import 'Screen/History/history.dart';
import 'Screen/Login/login.dart';
import 'Screen/Message/MessageScreen.dart';
import 'Screen/Notification/notification.dart';
import 'Screen/Settings/settings.dart';
import 'Screen/SignUp/forgot_password.dart';
import 'Screen/SignUp/phone_signup.dart';
import 'Screen/SignUp/signup.dart';
import 'Screen/SplashScreen/SplashScreen.dart';
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
//      case introScreen:
//        return PageViewTransition(builder: (_) => IntroScreen());
//      case identityCheckScreen:
//        return PageViewTransition(builder: (_) => IdentityCheckScreen());
//      case homeScreen:
//        return PageViewTransition(builder: (_) => HomeScreens());
//      case homeScreen2:
//        return PageViewTransition(builder: (_) => HomeScreen2());
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
//      case profileScreen:
//        return PageViewTransition(builder: (_) => ProfileScreen());
//      case paymentMethodScreen:
//        return PageViewTransition(builder: (_) => PaymentMethodScreen());
      case historyScreen:
        return PageViewTransition(builder: (_) => HistoryScreen());
      case settingsScreen:
        return PageViewTransition(builder: (_) => SettingsScreen());
//      case reviewTripScreen:
//        return PageViewTransition(builder: (_) => ReviewTripScreen());
//      case cancellationReasonsScreen:
//        return PageViewTransition(builder: (_) => CancellationReasonsScreen());
//      case termsConditionsScreen:
//        return PageViewTransition(builder: (_) => TermsConditionsScreen());
//      case membershipsScreen:
//        return PageViewTransition(builder: (_) => MembershipsScreen());
//      case driverDetailScreen:
//        return PageViewTransition(builder: (_) => DriverDetailScreen());
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
