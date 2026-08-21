import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../controller/support_controller.dart';

class SupportView extends StatelessWidget {
  const SupportView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SupportController());

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          'Support',
          style: TextHelper.heading1,
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () => _showAddTicketDialog(context, controller),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.accentGold, width: 1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                '+ Add New',
                style: TextHelper.caption.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Obx(() {
        if (controller.tickets.isEmpty) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Headphone icon in gold circle
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.accentGold.withValues(alpha: 0.08),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.accentGold, width: 2),
                    ),
                    child: const Icon(
                      Icons.headset_mic_rounded,
                      color: AppColors.accentGold,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'No Support Tickets',
                    style: TextHelper.heading2,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "You haven't created any support tickets yet.",
                    textAlign: TextAlign.center,
                    style: TextHelper.bodyText2,
                  ),
                ],
              ),
            ),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16),
          itemCount: controller.tickets.length,
          itemBuilder: (context, index) {
            final ticket = controller.tickets[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondaryDark,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderDark, width: 1.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ticket.id,
                        style: TextHelper.bodyText1.copyWith(
                          color: AppColors.accentGold,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          ticket.status,
                          style: TextHelper.caption.copyWith(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    ticket.category,
                    style: TextHelper.bodyText1.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    ticket.description,
                    style: TextHelper.bodyText2,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(Icons.calendar_today, size: 10, color: AppColors.textSecondary),
                      const SizedBox(width: 4),
                      Text(
                        ticket.date,
                        style: TextHelper.caption,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  void _showAddTicketDialog(BuildContext context, SupportController controller) {
    final descCtrl = TextEditingController();
    final List<String> categories = ['General Inquiry', 'Payment Issue', 'Product Query', 'Delivery Delay'];
    String selectedCategory = categories[0];

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.primaryDark,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                left: 16,
                right: 16,
                top: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Create Support Ticket',
                        style: TextHelper.heading2.copyWith(color: AppColors.accentGold),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: AppColors.textPrimary),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Category',
                    style: TextHelper.bodyText2.copyWith(color: AppColors.accentGold, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderDark),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedCategory,
                        dropdownColor: AppColors.secondaryDark,
                        icon: const Icon(Icons.arrow_drop_down, color: AppColors.accentGold),
                        style: TextHelper.bodyText1,
                        items: categories.map((cat) {
                          return DropdownMenuItem<String>(
                            value: cat,
                            child: Text(cat),
                          );
                        }).toList(),
                        onChanged: (val) {
                          if (val != null) {
                            setModalState(() {
                              selectedCategory = val;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Description',
                    style: TextHelper.bodyText2.copyWith(color: AppColors.accentGold, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.secondaryDark,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.borderDark),
                    ),
                    child: TextField(
                      controller: descCtrl,
                      maxLines: 4,
                      style: TextHelper.bodyText1,
                      decoration: InputDecoration(
                        hintText: 'Enter details about your issue...',
                        hintStyle: TextHelper.bodyText2.copyWith(color: AppColors.textSecondary.withValues(alpha: 0.5)),
                        contentPadding: const EdgeInsets.all(12),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (descCtrl.text.trim().isEmpty) {
                        Get.snackbar(
                          'Error', 
                          'Please enter a description',
                          backgroundColor: Colors.redAccent, 
                          colorText: Colors.white,
                          snackPosition: SnackPosition.TOP,
                          margin: const EdgeInsets.all(16.0),
                        );
                        return;
                      }
                      controller.addTicket(selectedCategory, descCtrl.text.trim());
                      Navigator.pop(context);
                      Get.snackbar(
                        'Ticket Created',
                        'Your support ticket has been submitted.',
                        snackPosition: SnackPosition.TOP,
                        backgroundColor: const Color(0xFF122326),
                        colorText: const Color(0xFFE5C158),
                        borderColor: const Color(0xFF1D3538),
                        borderWidth: 1.0,
                        margin: const EdgeInsets.all(16.0),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.accentGold,
                      foregroundColor: AppColors.primaryDark,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Submit Ticket',
                      style: TextHelper.bodyText1.copyWith(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
