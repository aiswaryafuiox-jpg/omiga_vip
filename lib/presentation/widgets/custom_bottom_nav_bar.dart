import 'package:flutter/material.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryDark,
        border: const Border(
          top: BorderSide(
            color: AppColors.borderDark,
            width: 1.5,
          ),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: AppColors.accentGold,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: TextHelper.caption.copyWith(
          color: AppColors.accentGold,
          fontWeight: FontWeight.bold,
          fontSize: 9,
        ),
        unselectedLabelStyle: TextHelper.caption.copyWith(
          color: AppColors.textSecondary,
          fontSize: 9,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home, color: AppColors.accentGold),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_outlined),
            activeIcon: Icon(Icons.grid_view, color: AppColors.accentGold),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person, color: AppColors.accentGold),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
