import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../controller/products_controller.dart';

class AdminRequestView extends StatelessWidget {
  const AdminRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ProductsController>();

    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Admin Requests',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.adminRequests.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.receipt_long_outlined,
                  color: AppColors.accentGold,
                  size: 64,
                ),
                const SizedBox(height: 16),
                Text(
                  'No Requests Found',
                  style: TextHelper.heading2.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'Your submitted purchase requests will appear here.',
                  style: TextHelper.caption.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          itemCount: controller.adminRequests.length,
          itemBuilder: (context, index) {
            final request = controller.adminRequests[index];
            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.secondaryDark,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF133F44),
                  width: 1.2,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row: Title & Status Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        request.productTitle,
                        style: const TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE57C34).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFE57C34).withValues(alpha: 0.4),
                            width: 0.8,
                          ),
                        ),
                        child: Text(
                          request.status,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFFE57C34),
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Barcode: ${request.barcode}',
                    style: TextHelper.caption.copyWith(fontSize: 11),
                  ),
                  const Divider(color: Color(0xFF1C454B), height: 20),

                  // Info list
                  _buildRequestDetailRow('Quantity', '${request.quantity}'),
                  _buildRequestDetailRow('Unit Price', '₹${_formatPrice(request.unitPrice)}'),
                  _buildRequestDetailRow('Total Amount', '₹${_formatPrice(request.totalPrice)}', isHighlight: true),
                  _buildRequestDetailRow('Transaction ID', request.transactionId),
                  _buildRequestDetailRow('Receipt File', request.fileName),
                  _buildRequestDetailRow('Remark', request.remark),
                  _buildRequestDetailRow('Date', _formatDate(request.date)),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  Widget _buildRequestDetailRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white54,
              fontSize: 11.5,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontFamily: 'Poppins',
                color: isHighlight ? AppColors.accentGold : Colors.white70,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w500,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  String _formatPrice(double val) {
    final RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    String mathFunc(Match match) => '${match[1]},';

    final List<String> parts = val.toStringAsFixed(2).split('.');
    parts[0] = parts[0].replaceAllMapped(reg, mathFunc);
    return parts.join('.');
  }

  String _formatDate(DateTime dt) {
    return '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year} ${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
  }
}
