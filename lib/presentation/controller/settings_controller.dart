import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dashboard_controller.dart';

class SettingsController extends GetxController {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController phoneController;

  late final TextEditingController currentPasswordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  final RxBool showCurrentPassword = false.obs;
  final RxBool showNewPassword = false.obs;
  final RxBool showConfirmPassword = false.obs;

  @override
  void onInit() {
    super.onInit();
    
    String initialName = 'novak.technology';
    String initialEmail = 'novak@gmail.com';
    String initialPhone = '+91 94285 02372';
    
    try {
      final dbController = Get.find<DashboardController>();
      initialName = dbController.username.value;
      initialEmail = dbController.email.value;
    } catch (_) {}

    nameController = TextEditingController(text: initialName);
    emailController = TextEditingController(text: initialEmail);
    phoneController = TextEditingController(text: initialPhone);

    currentPasswordController = TextEditingController();
    newPasswordController = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  void saveProfile() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar(
        'Error', 
        'Full name cannot be empty',
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16.0),
      );
      return;
    }
    if (emailController.text.trim().isEmpty || !GetUtils.isEmail(emailController.text.trim())) {
      Get.snackbar(
        'Error', 
        'Please enter a valid email address',
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16.0),
      );
      return;
    }

    try {
      final dbController = Get.find<DashboardController>();
      dbController.username.value = nameController.text.trim();
      dbController.email.value = emailController.text.trim();
    } catch (_) {}

    Get.snackbar(
      'Success',
      'Profile information updated successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF122326),
      colorText: const Color(0xFFE5C158),
      borderColor: const Color(0xFF1D3538),
      borderWidth: 1.0,
      margin: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 3),
    );
  }

  void updatePassword() {
    String currentPassword = currentPasswordController.text;
    String newPassword = newPasswordController.text;
    String confirmPassword = confirmPasswordController.text;

    if (currentPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar(
        'Error', 
        'Please fill in all password fields',
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16.0),
      );
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar(
        'Error', 
        'New passwords do not match',
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16.0),
      );
      return;
    }

    if (newPassword.length < 6) {
      Get.snackbar(
        'Error', 
        'Password must be at least 6 characters long',
        backgroundColor: Colors.redAccent, 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(16.0),
      );
      return;
    }

    // Success state
    currentPasswordController.clear();
    newPasswordController.clear();
    confirmPasswordController.clear();

    Get.snackbar(
      'Success',
      'Password updated successfully',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF122326),
      colorText: const Color(0xFFE5C158),
      borderColor: const Color(0xFF1D3538),
      borderWidth: 1.0,
      margin: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 3),
    );
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
