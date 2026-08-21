import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../controller/settings_controller.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';

class ProfileInfoView extends StatelessWidget {
  const ProfileInfoView({super.key});

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
          'Profile Information',
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
            CustomTextField(
              controller: controller.nameController,
              labelText: 'Full Name',
              hintText: 'Enter your full name',
              prefixIcon: const Icon(Icons.person_outline, color: AppColors.accentGold),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: controller.emailController,
              labelText: 'Email',
              hintText: 'Enter your email address',
              keyboardType: TextInputType.emailAddress,
              prefixIcon: const Icon(Icons.email_outlined, color: AppColors.accentGold),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: controller.phoneController,
              labelText: 'Phone Number',
              hintText: 'Enter your phone number',
              keyboardType: TextInputType.phone,
              prefixIcon: const Icon(Icons.phone_outlined, color: AppColors.accentGold),
            ),
            const SizedBox(height: 40),
            GradientButton(
              text: 'Save Changes',
              onPressed: () => controller.saveProfile(),
            ),
          ],
        ),
      ),
    );
  }
}
