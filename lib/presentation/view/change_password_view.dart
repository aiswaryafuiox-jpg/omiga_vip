import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../controller/settings_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Change Password',
          style: TextHelper.heading1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            Obx(() => CustomTextField(
                  controller: controller.currentPasswordController,
                  labelText: 'Current Password',
                  hintText: 'Enter current password',
                  obscureText: !controller.showCurrentPassword.value,
                  onToggleObscure: () => controller.showCurrentPassword.toggle(),
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.accentGold),
                )),
            const SizedBox(height: 20),
            Obx(() => CustomTextField(
                  controller: controller.newPasswordController,
                  labelText: 'New Password',
                  hintText: 'Enter new password',
                  obscureText: !controller.showNewPassword.value,
                  onToggleObscure: () => controller.showNewPassword.toggle(),
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.accentGold),
                )),
            const SizedBox(height: 20),
            Obx(() => CustomTextField(
                  controller: controller.confirmPasswordController,
                  labelText: 'Confirm New Password',
                  hintText: 'Re-enter new password',
                  obscureText: !controller.showConfirmPassword.value,
                  onToggleObscure: () => controller.showConfirmPassword.toggle(),
                  prefixIcon: const Icon(Icons.lock_outline_rounded, color: AppColors.accentGold),
                )),
            const SizedBox(height: 40),
            GradientButton(
              text: 'Update Password',
              onPressed: () => controller.updatePassword(),
            ),
          ],
        ),
      ),
    );
  }
}
