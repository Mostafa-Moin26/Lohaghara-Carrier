import 'package:get/get.dart';
import 'package:lohaghara_carrier/core/helpers/network_manager.dart';
import 'package:lohaghara_carrier/features/auth/data/repositories/authentication_repository.dart';
import 'package:lohaghara_carrier/features/dashboard/presentation/controllers/dashboard_controller.dart';

/// App-wide dependency injection.
/// Services registered here are available EVERYWHERE immediately.
/// Feature-specific controllers are registered in their own bindings (later).
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // We'll register global services here in later steps:
    // Get.lazyPut<AuthService>(() => AuthService());
    // Get.lazyPut<LocalStorageService>(() => LocalStorageService());
    //
    // lazyPut = only created when first accessed (memory efficient)
    // permanent = never destroyed (for app-wide services)

    Get.put(NetworkManager());
    Get.put(AuthenticationRepository());
    Get.put(DashboardController());
  }
}
