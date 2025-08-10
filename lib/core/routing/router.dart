import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tabibak/core/constant/string.dart';
import 'package:tabibak/features/auth/view/login_view.dart';
import 'package:tabibak/features/auth/view/signup_view.dart';
import 'package:tabibak/features/auth/view/doctor_registration_view.dart';
import 'package:tabibak/features/auth/view/patient_registration_view.dart';
import 'package:tabibak/features/onboarding/view/onboarding_view.dart';
import 'package:tabibak/features/splash/view/splash_view.dart';
import 'package:tabibak/features/home/view/home_view.dart';

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

      case Routes.signup:
        return MaterialPageRoute(builder: (_) => SignupView());

      case Routes.doctorRegistration:
        return MaterialPageRoute(builder: (_) => DoctorRegistrationView());

      case Routes.patientRegistration:
        return MaterialPageRoute(builder: (_) => PatientRegistrationView());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => HomeView());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('No route ${settings.name}'))),
        );
    }
  }
}
