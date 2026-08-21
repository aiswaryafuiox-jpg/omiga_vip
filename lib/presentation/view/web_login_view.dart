import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';

class WebLoginView extends StatefulWidget {
  const WebLoginView({super.key});

  @override
  State<WebLoginView> createState() => _WebLoginViewState();
}

class _WebLoginViewState extends State<WebLoginView> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scanAnimation;
  bool _isAuthorizing = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _scanAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _simulateScan() async {
    if (_isAuthorizing) return;

    setState(() {
      _isAuthorizing = true;
    });

    // Simulate authorization connection delay
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isAuthorizing = false;
      });

      Get.back(); // Dismiss WebLogin screen

      Get.snackbar(
        'Web Auth Success',
        'Logged in successfully on Web Portal!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF0C2326),
        colorText: AppColors.accentGold,
        borderColor: const Color(0xFF133F44),
        borderWidth: 1.0,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryDark,
      appBar: AppBar(
        backgroundColor: AppColors.primaryDark,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 22),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Web Login',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const Icon(
              Icons.devices_rounded,
              color: AppColors.accentGold,
              size: 40,
            ),
            const SizedBox(height: 16),
            const Text(
              'Authorize Desktop Web Session',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Navigate to omigavip.com/login on your computer and scan the QR code to sign in instantly.',
              style: TextHelper.caption.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
            const Spacer(),

            // Scanner simulation container
            _buildScannerViewport(),

            const Spacer(),

            // Simulate Scan Action Button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _simulateScan,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentGold,
                  foregroundColor: AppColors.primaryDark,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: _isAuthorizing
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryDark),
                        ),
                      )
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.qr_code_scanner_rounded, size: 18),
                          SizedBox(width: 8),
                          Text(
                            'SIMULATE SCAN & LOG IN',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildScannerViewport() {
    return Container(
      width: 250,
      height: 250,
      decoration: BoxDecoration(
        color: const Color(0xFF0C2C30).withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFF133F44),
          width: 1.5,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Center scanning grid alignment helper
            Opacity(
              opacity: 0.15,
              child: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d0/QR_code_for_mobile_English_Wikipedia.svg/1200px-QR_code_for_mobile_English_Wikipedia.svg.png',
                width: 140,
                height: 140,
                fit: BoxFit.contain,
                errorBuilder: (c, e, s) => const Icon(
                  Icons.qr_code_2_rounded,
                  color: AppColors.accentGold,
                  size: 100,
                ),
              ),
            ),

            // Corner decorative overlays
            Positioned(
              top: 20,
              left: 20,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.accentGold, width: 3.5),
                    left: BorderSide(color: AppColors.accentGold, width: 3.5),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(color: AppColors.accentGold, width: 3.5),
                    right: BorderSide(color: AppColors.accentGold, width: 3.5),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              left: 20,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.accentGold, width: 3.5),
                    left: BorderSide(color: AppColors.accentGold, width: 3.5),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: AppColors.accentGold, width: 3.5),
                    right: BorderSide(color: AppColors.accentGold, width: 3.5),
                  ),
                ),
              ),
            ),

            // Scanning laser line
            AnimatedBuilder(
              animation: _scanAnimation,
              builder: (context, child) {
                return Positioned(
                  top: 20 + _scanAnimation.value * 210,
                  left: 20,
                  right: 20,
                  child: Container(
                    height: 2.0,
                    decoration: BoxDecoration(
                      color: AppColors.accentGold,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGold.withValues(alpha: 0.8),
                          blurRadius: 8,
                          spreadRadius: 1.5,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
