import 'package:flutter/material.dart';
import 'package:flutter_taxi_app_driver/Screen/SplashScreen/SplashScreen.dart';
import 'theme/style.dart';
import 'router.dart';
import 'package:provider/provider.dart';
import 'package:flutter_taxi_app_driver/providers/login_service.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) => LoginService(),
          ),
          ChangeNotifierProvider(
            create: (_) => SignupScreen(),
          ),
          ChangeNotifierProvider(
            create: (_) => LoginScreen(),
          ),

        ],
      child: MaterialApp(
        title: 'Taxi App Driver',
        theme: appTheme,
        onGenerateRoute: (RouteSettings settings) => getRoute(settings),
        home: SplashScreen(),
      ),
    );
  }
}
