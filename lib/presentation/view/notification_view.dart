import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../controller/notification_controller.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NotificationController>();
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        title: Text('Notifications', style: TextHelper.heading1.copyWith(color: AppColors.textPrimary)),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.notifications.isEmpty) {
          return Center(
            child: Text('No notifications', style: TextHelper.bodyText2.copyWith(color: AppColors.textSecondary)),
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.notifications.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final notif = controller.notifications[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderDark, width: 1.0),
              ),
              child: Text(notif, style: TextHelper.bodyText1.copyWith(color: AppColors.textPrimary)),
            );
          },
        );
      }),
    );
  }
}
