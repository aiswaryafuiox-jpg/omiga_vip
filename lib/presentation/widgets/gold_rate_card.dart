import 'package:flutter/material.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';

class GoldRateCard extends StatelessWidget {
  final String purity;
  final double price;
  final double change;
  final bool isUp;

  const GoldRateCard({
    super.key,
    required this.purity,
    required this.price,
    required this.change,
    required this.isUp,
  });

  @override
  Widget build(BuildContext context) {
    final Color indicatorColor = isUp ? AppColors.rateGreen : AppColors.rateRed;
    final IconData trendIcon = isUp ? Icons.trending_up_rounded : Icons.trending_down_rounded;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.borderDark.withValues(alpha: 0.7),
          width: 1.2,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
          BoxShadow(
            color: indicatorColor.withValues(alpha: 0.05),
            blurRadius: 15,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Purity Badge with Gold Gradient Ring
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  Color(0xFFE5C158),
                  Color(0xFFB8860B),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accentGold.withValues(alpha: 0.2),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                purity,
                style: TextHelper.bodyText2.copyWith(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w900,
                  fontSize: 12.5,
                  letterSpacing: 0.2,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          // Price text
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '₹${_formatPrice(price)}',
              textAlign: TextAlign.center,
              style: TextHelper.bodyText1.copyWith(
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
                color: AppColors.accentGold,
                letterSpacing: 0.2,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Percentage change indicator
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
            decoration: BoxDecoration(
              color: indicatorColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  trendIcon,
                  color: indicatorColor,
                  size: 11,
                ),
                const SizedBox(width: 2),
                Text(
                  '${isUp ? "+" : "-"}${change.toStringAsFixed(2)}%',
                  style: TextHelper.caption.copyWith(
                    color: indicatorColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 9.5,
                  ),
                ),
              ],
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
}
