import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/di/service_locator.dart';
import '../../core/utils/navigation/app_routes.dart';
import '../../domain/usecase/login_usecase.dart';

class LoginController extends GetxController {
  final userIdController = TextEditingController();
  final passwordController = TextEditingController();

  final RxBool isPasswordVisible = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoading = false.obs;

  final LoginUseCase _loginUseCase = sl<LoginUseCase>();

  @override
  void onClose() {
    userIdController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void login() async {
    final userId = userIdController.text.trim();
    final password = passwordController.text;

    if (userId.isEmpty) {
      errorMessage.value = 'User ID cannot be empty.';
      return;
    }
    if (password.isEmpty) {
      errorMessage.value = 'Password cannot be empty.';
      return;
    }

    isLoading.value = true;
    errorMessage.value = '';

    try {
      final result = await _loginUseCase.execute(userId, password);
      isLoading.value = false;

      if (result.success) {
        Get.snackbar(
          'Login Success',
          result.message.isNotEmpty ? result.message : 'Logged in successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: const Color(0xFF122326),
          colorText: const Color(0xFFE5C158),
        );
        Get.offAllNamed(AppRoutes.home);
      } else {
        errorMessage.value = result.message.isNotEmpty ? result.message : 'Login failed.';
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Failed to connect: $e';
    }
  }
}
