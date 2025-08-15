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
import 'package:tabibak/features/doctor_discovery/view/doctor_discovery_view.dart';
import 'package:tabibak/features/doctor_discovery/view/doctor_dashboard_view.dart';
import 'package:tabibak/features/symptom_checker/view/symptom_checker_view.dart';
import 'package:tabibak/features/profile/view/profile_view.dart';
import 'package:tabibak/features/appointment_booking/view/appointment_booking_view.dart';
import 'package:tabibak/features/medical_file/view/medical_file_view.dart';
import 'package:tabibak/features/chat/view/chat_view.dart';
import 'package:tabibak/features/nearby_doctors/view/nearby_doctors_view.dart';

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
      case Routes.doctorDashboard:
        return MaterialPageRoute(builder: (_) => DoctorDashboardView());
      case Routes.doctorDiscovery:
        return MaterialPageRoute(builder: (_) => DoctorDiscoveryView());
      case Routes.symptomChecker:
        return MaterialPageRoute(builder: (_) => SymptomCheckerView());
      case Routes.profile:
        return MaterialPageRoute(builder: (_) => ProfileView());
      case Routes.appointmentBooking:
        return MaterialPageRoute(builder: (_) => AppointmentBookingView());
      case Routes.medicalFile:
        return MaterialPageRoute(builder: (_) => MedicalFileView());
      case Routes.chat:
        return MaterialPageRoute(builder: (_) => ChatView());
      case Routes.nearbyDoctors:
        return MaterialPageRoute(builder: (_) => NearbyDoctorsView());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              Scaffold(body: Center(child: Text('No route ${settings.name}'))),
        );
    }
  }
}
