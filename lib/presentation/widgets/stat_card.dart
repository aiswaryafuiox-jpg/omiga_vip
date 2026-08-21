import 'package:flutter/material.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';

class StatCard extends StatelessWidget {
  final String title;
  final String amount;
  final VoidCallback onViewPressed;
  final String? imageUrl;

  const StatCard({
    super.key,
    required this.title,
    required this.amount,
    required this.onViewPressed,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.borderDark,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextHelper.bodyText2.copyWith(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Text(
                  amount,
                  style: TextHelper.heading1.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 12),
                GestureDetector(
                  onTap: onViewPressed,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'View',
                        style: TextHelper.caption.copyWith(
                          color: AppColors.accentGold,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 8,
                        color: AppColors.accentGold,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (imageUrl != null) ...[
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl!,
                width: 70,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Premium vector fallback for gold bar
                  return Container(
                    width: 70,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.accentGold,
                          AppColors.accentGoldDark,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(
                      Icons.star,
                      color: Colors.white,
                      size: 20,
                    ),
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
  }
}
