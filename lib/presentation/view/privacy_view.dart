import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';

class PrivacyView extends StatelessWidget {
  const PrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
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
          'Privacy Policy',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF0C2C30).withValues(alpha: 0.25),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: AppColors.accentGold.withValues(alpha: 0.35),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Shield Security Logo Header
              const Icon(
                Icons.security_rounded,
                color: AppColors.accentGold,
                size: 40,
              ),
              const SizedBox(height: 10),

              // Title
              const Text(
                'OMIGA VIP',
                style: TextStyle(
                  fontFamily: 'Serif',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.accentGold,
                  letterSpacing: 2.0,
                ),
              ),
              const Text(
                'PRIVACY & SECURITY',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: Colors.white60,
                  letterSpacing: 3.0,
                ),
              ),

              // Divider decoration
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 40, height: 1.2, color: AppColors.accentGold.withValues(alpha: 0.4)),
                    const SizedBox(width: 8),
                    const Icon(Icons.verified_user_outlined, color: AppColors.accentGold, size: 10),
                    const SizedBox(width: 8),
                    Container(width: 40, height: 1.2, color: AppColors.accentGold.withValues(alpha: 0.4)),
                  ],
                ),
              ),

              // Last update
              Text(
                'Last Updated: 21 Aug, 2026',
                style: TextHelper.caption.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),

              // Luxury Card Sections
              _buildPrivacySection(
                sectionNum: 'I',
                title: 'Data Collection & Identity',
                content: 'We collect relevant user profiles (such as User IDs, names, contact numbers, and emails) when you authenticate on our portal. This data is exclusively utilized to maintain your secure VIP account status.',
              ),
              _buildPrivacySection(
                sectionNum: 'II',
                title: 'Secure File Uploads',
                content: 'When submitting payment receipts or documents for admin request validations, all uploads are encrypted. Receipts are stored securely and accessed only by authorized review personnel.',
              ),
              _buildPrivacySection(
                sectionNum: 'III',
                title: 'Encrypted Live Operations',
                content: 'All communication with the live gold rates backend and session handling APIs are secured using industry-standard SSL/TLS algorithms. Your credentials are never saved in plain text.',
              ),
              _buildPrivacySection(
                sectionNum: 'IV',
                title: 'Cookies & Analytics',
                content: 'We use local cache and state variables to optimize loading speeds. We do not sell, rent, or distribute personal user metrics to advertising third-party agencies.',
              ),
              _buildPrivacySection(
                sectionNum: 'V',
                title: 'Your Compliance Rights',
                content: 'You can request immediate profile deletions or details correction from support. Account access logging is maintained to prevent session hijacking and profile compromise.',
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivacySection({
    required String sectionNum,
    required String title,
    required String content,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF133F44),
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.accentGold.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.4), width: 0.8),
                ),
                child: Text(
                  sectionNum,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.accentGold,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white70,
              fontSize: 11.5,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
