import 'package:flutter/material.dart';
import 'login_view.dart';
import 'package:get/get.dart';
import '../../core/di/service_locator.dart';
import '../../domain/usecase/logout_usecase.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../../core/utils/navigation/app_routes.dart';
import '../controller/navigation_controller.dart';

class MoreView extends StatelessWidget {
  const MoreView({super.key});

  @override
  Widget build(BuildContext context) {
    final navController = Get.find<NavigationController>();

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () {
            navController.changeIndex(0); // Go back to Dashboard
          },
        ),
        title: Text(
          'More',
          style: TextHelper.heading1,
        ),
        centerTitle: true,
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        children: [
          _buildMenuItem(
            icon: Icons.help_outline_rounded,
            title: 'FAQ',
            onTap: () => Get.toNamed('/faq'),
          ),
          _buildMenuItem(
            icon: Icons.description_outlined,
            title: 'Terms & Conditions',
            onTap: () => Get.toNamed('/terms'),
          ),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () => Get.toNamed('/settings'),
          ),
          // _buildMenuItem(
          //   icon: Icons.qr_code_scanner_rounded,
          //   title: 'Web Login',
          //   onTap: () => Get.toNamed('/webLogin'),
          // ),
          _buildMenuItem(
            icon: Icons.logout_rounded,
            title: 'Logout',
            textColor: Colors.redAccent,
            iconColor: Colors.redAccent,
            onTap: () => _showLogoutDialog(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderDark, width: 1.5),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: iconColor ?? AppColors.accentGold, size: 20),
        title: Text(
          title,
          style: TextHelper.bodyText1.copyWith(
            color: textColor ?? AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios_rounded,
          color: textColor?.withValues(alpha: 0.7) ?? AppColors.textSecondary,
          size: 12,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                style: TextHelper.bodyText2.copyWith(color: AppColors.textSecondary),
              ),
            ),
            ElevatedButton(
                onPressed: () async {
                  // Close the logout confirmation dialog
                  Navigator.of(context).pop();
                  // Perform logout API call
                  await sl<LogoutUseCase>().execute();
                  // Navigate to login screen using named route so the binding runs
                  Get.offAllNamed(AppRoutes.login);
                  // Show snackbar after navigation (will appear on login screen)
                  Get.snackbar(
                    'Logged Out',
                    'You have been logged out successfully.',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: const Color(0xFF122326),
                    colorText: const Color(0xFFE5C158),
                    borderColor: const Color(0xFF1D378),
                    borderWidth: 1.0,
                    margin: const EdgeInsets.all(16.0),
                  );
                },
              
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Text(
                'Logout',
                style: TextHelper.bodyText2.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        );
      },
    );
  }
}
