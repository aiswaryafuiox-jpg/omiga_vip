import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../controller/navigation_controller.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'dashboard_view.dart';
import 'products_view.dart';
import 'settings_view.dart';

class NavigationShellView extends StatelessWidget {
  const NavigationShellView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    final List<Widget> screens = [
      const DashboardView(),
      const ProductsView(),
      const SettingsView(),
    ];

    return Obx(() => Scaffold(
          backgroundColor: AppColors.primaryDark,
          body: IndexedStack(
            index: controller.selectedIndex,
            children: screens,
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: controller.selectedIndex,
            onTap: (index) {
              controller.changeIndex(index);
            },
          ),
        ));
  }
}
