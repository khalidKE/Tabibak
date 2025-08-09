import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabibak/core/constant/string.dart';
import 'package:tabibak/features/auth/view/login_view.dart';
import 'package:tabibak/features/onboarding/view/onboarding_view.dart';
import 'package:tabibak/features/splash/view/splash_view.dart';

class AppRouter {
  Route generatRoute(RouteSettings settings) {
    final argument = settings.arguments;
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => SplashView());

      case Routes.onBoarding:
        return MaterialPageRoute(builder: (_) => OnboardingView());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginView());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('No route ${settings.name}'))),
        );
    }
  }
}
