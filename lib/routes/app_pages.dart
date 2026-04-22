import 'package:get/get.dart';
import 'package:lohaghara_carrier/presentation/auth/login/login.dart';
import 'package:lohaghara_carrier/presentation/auth/signup/signup.dart';
import 'package:lohaghara_carrier/presentation/onboarding/onboarding.dart';
import '../presentation/splash/splash.dart';
import 'app_routes.dart';

class AppPages {
  AppPages._();

  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => SplashScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => OnboardingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => LoginScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupScreen(),
      transition: Transition.rightToLeft,
    ),
  ];
}
