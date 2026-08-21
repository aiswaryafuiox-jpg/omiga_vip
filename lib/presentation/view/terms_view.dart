import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';

class TermsView extends StatelessWidget {
  const TermsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Terms & Conditions',
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
              // Golden Crown Icon Logo Header
              const Icon(
                Icons.workspace_premium_rounded,
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
                'OFFICIAL PROTOCOL',
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
                    const Icon(Icons.star, color: AppColors.accentGold, size: 10),
                    const SizedBox(width: 8),
                    Container(width: 40, height: 1.2, color: AppColors.accentGold.withValues(alpha: 0.4)),
                  ],
                ),
              ),

              // Last update
              Text(
                'Last Updated: 20 Aug, 2026',
                style: TextHelper.caption.copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),

              // Luxury Card Sections
              _buildLuxurySection(
                sectionNum: 'I',
                title: 'Introduction & Scope',
                content: 'Welcome to the OMIGA VIP platform. By accessing or executing transactions on our secure network, you agree to be bound by these official terms and conditions.',
              ),
              _buildLuxurySection(
                sectionNum: 'II',
                title: 'Use of services',
                content: 'You agree to use our platform exclusively for lawful physical assets purchase transactions. Exploitation, disruption, or automated scraping of rate indexes is prohibited.',
              ),
              _buildLuxurySection(
                sectionNum: 'III',
                title: 'Pricing & Live gold rate',
                content: 'All listed bullion holding prices are derived from active live market rates. Rates are updated in real-time, and purchase quotes are valid only for immediate checkout cycles.',
              ),
              _buildLuxurySection(
                sectionNum: 'IV',
                title: 'Secure holdings',
                content: 'Users are fully responsible for maintaining secure access credentials. The platform is not liable for unauthorized access stemming from negligent account security.',
              ),
              _buildLuxurySection(
                sectionNum: 'V',
                title: 'Limitation of liability',
                content: 'OMIGA VIP and partners do not guarantee financial returns on holdings. You accept all inherent risks associated with index fluctuations and market gold rate changes.',
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLuxurySection({
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
