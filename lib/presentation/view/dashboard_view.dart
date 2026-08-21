import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/const/app_images.dart';
import '../controller/dashboard_controller.dart';

// --- Lightweight Stateful Marquee Ticker widget ---
class MarqueeWidget extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration scrollDuration;

  const MarqueeWidget({
    super.key,
    required this.text,
    required this.style,
    this.scrollDuration = const Duration(seconds: 18),
  });

  @override
  State<MarqueeWidget> createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _startScrolling());
  }

  void _startScrolling() async {
    if (!_scrollController.hasClients) return;
    
    final maxScroll = _scrollController.position.maxScrollExtent;
    if (maxScroll == 0) return;

    await _scrollController.animateTo(
      maxScroll,
      duration: widget.scrollDuration,
      curve: Curves.linear,
    );

    if (mounted) {
      _scrollController.jumpTo(0.0);
      _startScrolling();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: _scrollController,
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: [
          Text(widget.text, style: widget.style),
          SizedBox(width: MediaQuery.of(context).size.width),
          Text(widget.text, style: widget.style),
        ],
      ),
    );
  }
}

// --- Auto-sliding Banner Carousel Widget ---
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key});

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  late PageController _pageController;
  int _currentPage = 0;

  final List<Map<String, String>> _banners = [
    {
      'image': AppImages.gold,
      // 'title': 'OMIGA Loyalty Scheme',
      // 'subtitle': 'Accumulate gold value securely with guaranteed yields',
    },
    {
      'image': AppImages.login,
      // 'title': 'Advance Gold Purchase',
      // 'subtitle': 'Make small deposits and convert to jewelry when ready',
    },
    {
      'image': AppImages.pure,
      // 'title': 'Crafted to Perfection',
      // 'subtitle': 'Redeem pure 22K certified gold coins and jewelry',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    _startAutoPlay();
  }

  void _startAutoPlay() {
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 4));
      if (!mounted) return false;
      _currentPage = (_currentPage + 1) % _banners.length;
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
      return true;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 140,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: _banners.length,
            itemBuilder: (context, index) {
              final banner = _banners[index];
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: banner['image']!.startsWith('http')
                        ? NetworkImage(banner['image']!)
                        : AssetImage(banner['image']!) as ImageProvider,
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black.withValues(alpha: 0.55),
                      BlendMode.darken,
                    ),
                  ),
                  border: Border.all(
                    color: const Color(0xFF133F44),
                    width: 1.0,
                  ),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (banner['title'] != null && banner['title']!.isNotEmpty) ...[
                      Text(
                        banner['title']!,
                        style: const TextStyle(
                          fontFamily: 'Serif',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.accentGold,
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                    if (banner['subtitle'] != null && banner['subtitle']!.isNotEmpty)
                      Text(
                        banner['subtitle']!,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 11.5,
                          color: Colors.white70,
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        // Dots Indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(_banners.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 4),
              width: _currentPage == index ? 18 : 6,
              height: 6,
              decoration: BoxDecoration(
                color: _currentPage == index ? AppColors.accentGold : Colors.white30,
                borderRadius: BorderRadius.circular(3),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      backgroundColor: const Color(0xFF061214), // Dark premium slate background
      drawer: _buildDrawer(context),
      appBar: AppBar(
        backgroundColor: const Color(0xFF061214),
        elevation: 0,
        leading: Builder(
          builder: (context) {
            return IconButton(
              icon: const Icon(Icons.menu, color: Colors.white, size: 24),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppImages.appLogo,
              height: 28,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.workspace_premium,
                color: AppColors.accentGold,
                size: 20,
              ),
            ),
            const SizedBox(height: 2),
            const Text(
              'OMIGA VIP',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.accentGold,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 24),
                onPressed: () {},
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Color(0xFFE57C34), // Orange Notification Badge
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: const Center(
                    child: Text(
                      '1',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 8,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Welcome Greeting Header Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Hello,',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Obx(() => Text(
                            controller.username.value,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: AppColors.accentGold,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                      const SizedBox(height: 2),
                      const Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white54,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.accentGold, width: 2.0),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accentGold.withValues(alpha: 0.15),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.transparent,
                      backgroundImage: NetworkImage(AppImages.profileAvatar),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // 2. Flowing News Marquee Ticker (News moving placed below profile)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFF0C2C30), // Dark Teal
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: const Color(0xFF133F44), width: 1.0),
                ),
                child: const MarqueeWidget(
                  text: 'Steady income source. Start small, grow big!',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // 3. Banner Carousel (More than 2 banners in auto-sliding view)
              const BannerCarousel(),
              const SizedBox(height: 24),

              // 4. Dashboard Cards Area (Side-by-side Row on Wide, Stacked Column on Mobile)
              LayoutBuilder(
                builder: (context, constraints) {
                  final bool isWide = constraints.maxWidth > 600;

                  if (isWide) {
                    return IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          // Left Cards Column
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                _buildAdvanceCard(controller, context),
                                const SizedBox(height: 12),
                                _buildPurchaseCard(controller, context),
                                const SizedBox(height: 12),
                                _buildProfileCard(controller),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Right Slanted Gold Bar Card
                          Expanded(
                            flex: 5,
                            child: _buildImageCard(),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Column(
                      children: [
                        _buildAdvanceCard(controller, context),
                        const SizedBox(height: 12),
                        _buildPurchaseCard(controller, context),
                        const SizedBox(height: 12),
                        _buildProfileCard(controller),
                        // const SizedBox(height: 16),
                        // _buildImageCard(height: 180),
                      ],
                    );
                  }
                },
              ),
              const SizedBox(height: 28),

              // 4. Today's Gold Rate Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Today's Gold Rate",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '22 Aug, 2024',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white.withValues(alpha: 0.38),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00E676).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFF00E676).withValues(alpha: 0.3),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00E676),
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'LIVE',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF00E676),
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Rates horizontal row
              Obx(() {
                return Row(
                  children: controller.goldRates.map((rate) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: _buildInnerGoldRateCard(rate),
                      ),
                    );
                  }).toList(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  // --- Profile Card Helper ---
  Widget _buildProfileCard(DashboardController controller) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2C30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF133F44), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.person_outline_rounded,
                color: AppColors.accentGold,
                size: 16,
              ),
              const SizedBox(width: 6),
              Obx(() => Text(
                    controller.userId.value,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  )),
            ],
          ),
          const SizedBox(height: 6),
          Obx(() => Text(
                'Email: ${controller.email.value}',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                  fontSize: 11,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )),
          const SizedBox(height: 10),
          Row(
            children: [
              const Text(
                'Role: ',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white70,
                  fontSize: 11.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accentGold,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Obx(() => Text(
                      controller.memberRank.value,
                      style: const TextStyle(
                        fontFamily: 'Poppins',
                        color: Color(0xFF08181A),
                        fontWeight: FontWeight.bold,
                        fontSize: 10,
                      ),
                    )),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- My Advance Card Helper ---
  Widget _buildAdvanceCard(DashboardController controller, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2C30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF133F44), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Advance',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    '₹ ${controller.myAdvance.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )),
              GestureDetector(
                onTap: () => _showSnackBar(context, 'Advance Balance', controller.myAdvance.value),
                child: const Text(
                  'View',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.accentGold,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.accentGold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- My Purchase Card Helper ---
  Widget _buildPurchaseCard(DashboardController controller, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2C30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF133F44), width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'My Purchase',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => Text(
                    '₹ ${controller.myPurchase.value.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  )),
              GestureDetector(
                onTap: () => _showSnackBar(context, 'Purchase Balance', controller.myPurchase.value),
                child: const Text(
                  'View',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: AppColors.accentGold,
                    fontSize: 12,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.accentGold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- Image Card Helper ---
  Widget _buildImageCard({double? height}) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF0C2C30),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFF133F44), width: 1.0),
        image: const DecorationImage(
          image: AssetImage(AppImages.gold),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // --- Inner Gold Rate Card Item ---
  Widget _buildInnerGoldRateCard(GoldRate rate) {
    final indicatorColor = rate.isUp.value ? const Color(0xFF00E676) : const Color(0xFFFF1744);
    final trendSymbol = rate.isUp.value ? '▲' : '▼';
    final priceChangeVal = rate.isUp.value ? rate.change.value : -rate.change.value;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1D20), // Dark Teal
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF133F44),
          width: 1.0,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Karat Gold Circle Badge
          Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFFFBEAA0), Color(0xFFE5C158)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Text(
                rate.purity,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF08181A),
                  fontWeight: FontWeight.bold,
                  fontSize: 13.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              '₹${_formatPrice(rate.price.value)}',
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: AppColors.accentGold,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Percentage change indicator text
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '$trendSymbol ${priceChangeVal.toStringAsFixed(2)}%',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: indicatorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ],
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

  void _showSnackBar(BuildContext context, String title, double value) {
    Get.snackbar(
      title,
      'Current balance: ₹${value.toStringAsFixed(2)}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF122326),
      colorText: const Color(0xFFE5C158),
      borderColor: const Color(0xFF1D3538),
      borderWidth: 1.0,
      margin: const EdgeInsets.all(16.0),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.primaryDark,
      child: Column(
        children: [
          // Drawer Header
          DrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.secondaryDark,
              border: Border(
                bottom: BorderSide(
                  color: AppColors.borderDark,
                  width: 1.5,
                ),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    AppImages.appLogo,
                    height: 70,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.workspace_premium,
                      color: AppColors.accentGold,
                      size: 48,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ShaderMask(
                    shaderCallback: (bounds) => const LinearGradient(
                      colors: [Color(0xFFFFF7D6), AppColors.accentGold],
                    ).createShader(bounds),
                    child: const Text(
                      'OMIGA VIP',
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Drawer Body Items
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              children: [
                _buildDrawerItem(
                  icon: Icons.help_outline_rounded,
                  title: 'FAQ',
                  onTap: () {
                    Get.back(); // close drawer
                    Get.toNamed('/faq');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.lock_outline_rounded,
                  title: 'Change Password',
                  onTap: () {
                    Get.back(); // close drawer
                    Get.toNamed('/changePassword');
                  },
                ),
                _buildDrawerItem(
                  icon: Icons.info_outline_rounded,
                  title: 'About App',
                  onTap: () {
                    Get.back(); // close drawer
                    _showAboutDialog(context);
                  },
                ),
              ],
            ),
          ),
          // Footer
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Version 1.0.0',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 11,
                color: AppColors.textSecondary.withValues(alpha: 0.5),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.borderDark, width: 1.0),
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: AppColors.accentGold, size: 20),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: AppColors.textSecondary,
          size: 11,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        dense: true,
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.secondaryDark,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text(
            'About App',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.accentGold,
            ),
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'OMIGA VIP Client App',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Version: 1.0.0 (Build 1)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 12),
              Text(
                'A premium application platform for secure gold acquisition and live rate tracking.',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 12,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'Close',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}