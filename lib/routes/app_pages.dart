import 'package:get/get.dart';
import 'package:lohaghara_carrier/features/auth/presentation/login/login_screen.dart';
import 'package:lohaghara_carrier/features/auth/presentation/password/create/create_new_password_screen.dart';
import 'package:lohaghara_carrier/features/auth/presentation/password/forgot/forgot_password_screen.dart';
import 'package:lohaghara_carrier/features/auth/presentation/password/success/password_reset_successful_screen.dart';
import 'package:lohaghara_carrier/features/auth/presentation/password/reset/reset_password_screen.dart';
import 'package:lohaghara_carrier/features/auth/presentation/signup/signup_screen.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/dashboard_screen.dart';
import 'package:lohaghara_carrier/features/onboarding/onboarding_screen.dart';
import 'package:lohaghara_carrier/features/record/presentation/add_record/add_record_screen.dart';
import 'package:lohaghara_carrier/features/record/presentation/all_records/all_record_screen.dart';
import 'package:lohaghara_carrier/features/record/presentation/record_details/record_details_screen.dart';
import 'package:lohaghara_carrier/navigation_menu.dart';
import '../features/splash/splash_screen.dart';
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
    GetPage(name: AppRoutes.dashboard, page: () => Dashboard()),
    GetPage(name: AppRoutes.allRecords, page: () => AllRecord()),
    GetPage(name: AppRoutes.addRecord, page: () => AddRecordScreen()),
    GetPage(name: AppRoutes.recordDetail, page: () => RecordDetailsScreen()),
  ];
}
