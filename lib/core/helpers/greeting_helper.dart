class GreetingHelper {
  GreetingHelper._();

  static String getGreeting() {
    final hour = DateTime.now().hour;

    if (hour >= 5 && hour < 12) {
      return 'Good Morning';
    }

    if (hour >= 12 && hour < 17) {
      return 'Good Afternoon';
    }

    if (hour >= 17 && hour < 20) {
      return 'Good Evening';
    }

    return 'Good Night';
  }
}
