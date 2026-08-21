import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../controller/faq_controller.dart';

class FAQView extends StatelessWidget {
  const FAQView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FAQController());

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
          'FAQ',
          style: TextHelper.heading1,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        itemCount: controller.faqs.length,
        itemBuilder: (context, index) {
          final faq = controller.faqs[index];
          return Obx(() {
            final isExpanded = controller.expandedIndex.value == index;
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: AppColors.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isExpanded ? AppColors.accentGold : AppColors.borderDark,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ListTile(
                    onTap: () => controller.toggleExpand(index),
                    title: Text(
                      faq.question,
                      style: TextHelper.bodyText1.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                        color: isExpanded ? AppColors.accentGold : AppColors.textPrimary,
                      ),
                    ),
                    trailing: Icon(
                      isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: isExpanded ? AppColors.accentGold : AppColors.textSecondary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  ),
                  if (isExpanded)
                    Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      child: Text(
                        faq.answer,
                        style: TextHelper.bodyText2.copyWith(
                          height: 1.5,
                        ),
                      ),
                    ),
                ],
              ),
            );
          });
        },
      ),
    );
  }
}
