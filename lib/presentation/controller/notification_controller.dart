import 'package:get/get.dart';

class NotificationController extends GetxController {
  // Indicates if notifications are being loaded
  final isLoading = false.obs;

  // List of notification messages (could be a model in real app)
  final notifications = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  // Simulate loading notifications – replace with real API call later
  void loadNotifications() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1)); // mock network delay
    // Example static notifications
    notifications.assignAll([
      'Welcome back! Your profile was updated.',
      'New gold rates are available.',
      'Your session will expire in 5 minutes.',
    ]);
    isLoading.value = false;
  }

  // Add a new notification (could be called from elsewhere)
  void addNotification(String message) {
    notifications.insert(0, message);
  }
}
