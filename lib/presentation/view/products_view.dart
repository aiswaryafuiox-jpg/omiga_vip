import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../../core/utils/navigation/app_routes.dart';
import '../controller/navigation_controller.dart';
import '../controller/products_controller.dart';
import '../widgets/product_grid_item.dart';

class ProductsView extends StatelessWidget {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductsController());
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
          'Products',
          style: TextHelper.heading1,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // VIP Exclusive badge banner
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.accentGold.withValues(alpha: 0.2),
                      AppColors.accentGoldDark.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.accentGold, width: 0.8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: AppColors.accentGold, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      'OMIGA VIP EXCLUSIVE COLLECTION',
                      style: TextHelper.caption.copyWith(
                        color: AppColors.accentGold,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),

              // Product grid list
              Obx(() => GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.products.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.68,
                    ),
                    itemBuilder: (context, index) {
                      final product = controller.products[index];
                      return ProductGridItem(
                        product: product,
                        onOwnPressed: () => Get.toNamed(AppRoutes.productDetail, arguments: product),
                      );
                    },
                  )),
              const SizedBox(height: 24),

              // View all button
              Obx(() {
                if (controller.isAllLoaded.value) {
                  return const SizedBox.shrink();
                }

                return controller.isLoadingAll.value
                    ? const Center(
                        child: Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentGold),
                            ),
                          ),
                        ),
                      )
                    : OutlinedButton(
                        onPressed: () {
                          controller.loadAllProducts();
                        },
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: AppColors.accentGold, width: 1.2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                        ),
                        child: Text(
                          '★ View All Products ›',
                          style: TextHelper.bodyText2.copyWith(
                            color: AppColors.accentGold,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
              }),
              const SizedBox(height: 12),

              // Count helper text
              Obx(() => Text(
                    'Showing ${controller.products.length} of 76 products',
                    style: TextHelper.caption,
                  )),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
