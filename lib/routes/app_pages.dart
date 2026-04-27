import 'package:get/get.dart';
import 'package:lohaghara_carrier/features/auth/login/login.dart';
import 'package:lohaghara_carrier/features/auth/password_configuration/create_new_password.dart';
import 'package:lohaghara_carrier/features/auth/password_configuration/forgot_password.dart';
import 'package:lohaghara_carrier/features/auth/password_configuration/password_reset_successful.dart';
import 'package:lohaghara_carrier/features/auth/password_configuration/reset_password.dart';
import 'package:lohaghara_carrier/features/auth/signup/signup.dart';
import 'package:lohaghara_carrier/features/onboarding/onboarding.dart';
import 'package:lohaghara_carrier/navigation_menu.dart';
import '../features/splash/splash.dart';
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
    GetPage(name: AppRoutes.login, page: () => LoginScreen()),
    GetPage(
      name: AppRoutes.signup,
      page: () => SignupScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => ForgetPassword(),
      transition: Transition.rightToLeft,
    ),
    GetPage(name: AppRoutes.resetPassword, page: () => ResetPassword()),

    GetPage(name: AppRoutes.createNewPassword, page: () => CreateNewPassword()),

    GetPage(
      name: AppRoutes.passwordResetSuccessful,
      page: () => PasswordResetSuccessful(),
    ),

    GetPage(name: AppRoutes.navigationMenu, page: () => NavigationMenu()),
  ];
}
