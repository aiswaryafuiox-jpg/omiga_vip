import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/const/app_images.dart';
import '../../core/di/service_locator.dart';
import '../../core/utils/helper/text_helper.dart';
import '../../core/utils/navigation/app_routes.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../controller/dashboard_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final dbController = Get.find<DashboardController>();

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: Navigator.canPop(context)
            ? IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textPrimary,
                  size: 20,
                ),
                onPressed: () => Get.back(),
              )
            : null,
        title: Text('Profile', style: TextHelper.heading1),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Card Header summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondaryDark,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.borderDark, width: 1.5),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: AppColors.accentGold,
                    child: CircleAvatar(
                      radius: 28,
                      backgroundImage: const NetworkImage(
                        AppImages.profileAvatar,
                      ),
                      backgroundColor: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Obx(
                          () => Text(
                            dbController.username.value,
                            style: TextHelper.bodyText1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Obx(
                          () => Text(
                            dbController.userId.value,
                            style: TextHelper.caption.copyWith(
                              color: AppColors.accentGold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Obx(
                          () => Text(
                            dbController.email.value,
                            style: TextHelper.caption,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Account Group options
            Text(
              'Account',
              style: TextHelper.bodyText1.copyWith(
                color: AppColors.accentGold,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingsItem(
              icon: Icons.person_outline_rounded,
              title: 'Profile Information',
              onTap: () => Get.toNamed('/profile'),
            ),
            _buildSettingsItem(
              icon: Icons.lock_outline_rounded,
              title: 'Change Password',
              onTap: () => Get.toNamed('/changePassword'),
            ),
            const SizedBox(height: 20),

            // Others Group options
            Text(
              'Others',
              style: TextHelper.bodyText1.copyWith(
                color: AppColors.accentGold,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            _buildSettingsItem(
              icon: Icons.security,
              title: 'Privacy Policy',
              onTap: () => Get.toNamed('/privacy'),
            ),
            _buildSettingsItem(
              icon: Icons.description_outlined,
              title: 'Terms & Conditions',
              onTap: () => Get.toNamed('/terms'),
            ),
            _buildSettingsItem(
              icon: Icons.headset_mic_outlined,
              title: 'Help & Support',
              onTap: () => Get.toNamed('/support'),
            ),
            _buildSettingsItem(
              icon: Icons.info_outline_rounded,
              title: 'About App',
              onTap: () => _showAboutDialog(context),
            ),
            const SizedBox(height: 20),

            // Logout option
            _buildSettingsItem(
              icon: Icons.logout_rounded,
              title: 'Logout',
              textColor: Colors.redAccent,
              iconColor: Colors.redAccent,
              onTap: () => _showSettingsLogoutDialog(context),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDark, width: 1.2),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor ?? AppColors.accentGold, size: 20),
        title: Text(
          title,
          style: TextHelper.bodyText2.copyWith(
            color: textColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.textSecondary,
          size: 11,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        dense: true,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'About App',
            style: TextHelper.heading2.copyWith(color: AppColors.accentGold),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('OMIGA VIP Client App', style: TextHelper.bodyText1),
              const SizedBox(height: 4),
              Text('Version: 1.0.0 (Build 1)', style: TextHelper.bodyText2),
              const SizedBox(height: 12),
              Text(
                'A premium application platform for secure gold acquisition and live rate tracking.',
                style: TextHelper.bodyText2,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Close',
                style: TextHelper.bodyText2.copyWith(
                  color: AppColors.accentGold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showSettingsLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryDark,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: Text(
            'Logout',
            style: TextHelper.heading2.copyWith(color: AppColors.accentGold),
          ),
          content: Text(
            'Are you sure you want to log out of OMIGA VIP?',
            style: TextHelper.bodyText2,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextHelper.bodyText2.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await sl<LogoutUseCase>().execute();
                Get.offAllNamed(AppRoutes.login);
                Get.snackbar(
                  'Logged Out',
                  'You have been logged out successfully.',
                  snackPosition: SnackPosition.TOP,
                  backgroundColor: const Color(0xFF122326),
                  colorText: const Color(0xFFE5C158),
                  borderColor: const Color(0xFF1D3538),
                  borderWidth: 1.0,
                  margin: const EdgeInsets.all(16.0),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Logout',
                style: TextHelper.bodyText2.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
