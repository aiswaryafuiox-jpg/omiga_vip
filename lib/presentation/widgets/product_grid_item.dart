import 'package:flutter/material.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../controller/products_controller.dart';

class ProductGridItem extends StatelessWidget {
  final ProductItem product;
  final VoidCallback onOwnPressed;

  const ProductGridItem({
    super.key,
    required this.product,
    required this.onOwnPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOwnPressed,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.secondaryDark,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.borderDark,
            width: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image card
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                child: Image.network(
                  product.imageUrl,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: AppColors.primaryDark,
                      child: const Icon(
                        Icons.image_not_supported_outlined,
                        color: AppColors.accentGold,
                        size: 30,
                      ),
                    );
                  },
                ),
              ),
            ),
            // Product Info
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.title,
                    style: TextHelper.bodyText1.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Barcode: ${product.barcode}',
                    style: TextHelper.caption.copyWith(
                      fontSize: 9,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '₹${_formatPrice(product.price)}',
                    style: TextHelper.bodyText1.copyWith(
                      color: AppColors.accentGold,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Action Button (Own It Now taking full width)
                  SizedBox(
                    width: double.infinity,
                    height: 32,
                    child: OutlinedButton(
                      onPressed: onOwnPressed,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.accentGold, width: 1.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        'Own It Now',
                        style: TextHelper.caption.copyWith(
                          color: AppColors.accentGold,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
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
}
