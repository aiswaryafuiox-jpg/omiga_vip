import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_color.dart';
import '../../core/utils/helper/text_helper.dart';
import '../controller/products_controller.dart';

class ProductDetailView extends StatefulWidget {
  const ProductDetailView({super.key});

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  int _quantity = 1;
  final _transactionIdController = TextEditingController();
  final _remarkController = TextEditingController();
  String _fileName = "No file chosen";

  @override
  void dispose() {
    _transactionIdController.dispose();
    _remarkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get the product item passed from the previous screen
    final ProductItem product = Get.arguments as ProductItem;
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
          'Product Details',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final bool isWide = constraints.maxWidth > 800;

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Split Layout (Image + Specs Grid)
                isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 4,
                            child: _buildProductImage(product),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 6,
                            child: _buildProductSpecs(product),
                          ),
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildProductImage(product),
                          const SizedBox(height: 24),
                          _buildProductSpecs(product),
                        ],
                      ),
                const SizedBox(height: 28),

                // Bottom Checkout Form Container (Own This Product)
                _buildOwnProductForm(product, controller),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- Image Builder ---
  Widget _buildProductImage(ProductItem product) {
    return Container(
      width: double.infinity,
      height: 380,
      decoration: BoxDecoration(
        color: AppColors.secondaryDark,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF133F44),
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_not_supported_outlined,
              color: AppColors.accentGold,
              size: 80,
            );
          },
        ),
      ),
    );
  }

  // --- Specifications Column & Table Builder ---
  Widget _buildProductSpecs(ProductItem product) {
    final purity = product.barcode.contains('STL') ? '9K' : '18K';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Brand Pill
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.accentGold.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.accentGold.withValues(alpha: 0.4), width: 0.8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.workspace_premium_rounded, color: AppColors.accentGold, size: 12),
              const SizedBox(width: 6),
              Text(
                'OMIGA VIP',
                style: TextHelper.caption.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.bold,
                  fontSize: 9.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),

        // Product Title
        Text(
          product.title,
          style: const TextStyle(
            fontFamily: 'Serif',
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 6),

        // Price
        Text(
          '₹${_formatPrice(product.price)}',
          style: const TextStyle(
            fontFamily: 'Poppins',
            color: AppColors.accentGold,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 14),

        // Indicators Row
        Row(
          children: [
            _buildIndicatorLabel('Barcode', product.barcode),
            const SizedBox(width: 12),
            _buildIndicatorLabel('Category', purity),
          ],
        ),
        const SizedBox(height: 20),

        // Expandable Product Details Box
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0A1D20).withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: const Color(0xFF133F44),
              width: 1.0,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              initiallyExpanded: true,
              leading: const Icon(Icons.diamond_outlined, color: AppColors.accentGold, size: 20),
              title: const Text(
                'Product Details',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              iconColor: AppColors.accentGold,
              collapsedIconColor: AppColors.accentGold,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Column(
                    children: [
                      _buildSpecRow('Piece ID', '${3000 + int.parse(product.id)}'),
                      _buildSpecRow('Barcode', product.barcode),
                      _buildSpecRow('HSN', '711319'),
                      _buildSpecRow('Per Gram Gold Price', '₹6,025.00'),
                      _buildSpecRow('MC Per Gram Price', '₹2,200.00'),
                      _buildSpecRow('Making Charge', '₹30,824.20'),
                      _buildSpecRow('Diamond Cent', '0'),
                      _buildSpecRow('Diamond Cent Per Gram Price', '₹130,000.00'),
                      _buildSpecRow('Amount', '₹${_formatPrice(product.price)}', isHighlight: true),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildIndicatorLabel(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2326),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF1B383C), width: 1),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 11, color: Colors.white60),
          children: [
            TextSpan(text: '$label '),
            TextSpan(text: value, style: const TextStyle(color: AppColors.accentGold, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildSpecRow(String key, String val, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            key,
            style: const TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white60,
              fontSize: 12,
            ),
          ),
          Text(
            val,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: isHighlight ? AppColors.accentGold : Colors.white,
              fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }

  // --- Own This Product Checkout Form Banner ---
  Widget _buildOwnProductForm(ProductItem product, ProductsController controller) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0C2326).withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF133F44),
          width: 1.2,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.diamond_outlined, color: AppColors.accentGold, size: 22),
              const SizedBox(width: 8),
              ShaderMask(
                shaderCallback: (bounds) => const LinearGradient(
                  colors: [Color(0xFFFFF8D6), AppColors.accentGold],
                ).createShader(bounds),
                child: const Text(
                  'Own This Product',
                  style: TextStyle(
                    fontFamily: 'Serif',
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          const Text(
            'Enter your payment details to submit your purchase request',
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white38,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 24),

          // Inputs Responsive Grid
          LayoutBuilder(
            builder: (context, formConstraints) {
              final bool isFormWide = formConstraints.maxWidth > 650;

              return Column(
                children: [
                  isFormWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildQuantitySelector()),
                            const SizedBox(width: 20),
                            Expanded(child: _buildInputField('Transaction ID', 'Enter Transaction ID', _transactionIdController)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildQuantitySelector(),
                            const SizedBox(height: 16),
                            _buildInputField('Transaction ID', 'Enter Transaction ID', _transactionIdController),
                          ],
                        ),
                  const SizedBox(height: 16),
                  isFormWide
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(child: _buildFilePicker()),
                            const SizedBox(width: 20),
                            Expanded(child: _buildInputField('Remark', 'Enter Remark', _remarkController)),
                          ],
                        )
                      : Column(
                          children: [
                            _buildFilePicker(),
                            const SizedBox(height: 16),
                            _buildInputField('Remark', 'Enter Remark', _remarkController),
                          ],
                        ),
                ],
              );
            },
          ),
          const SizedBox(height: 28),

          // Submit CTA Buy Now Button
          SizedBox(
            width: 220,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                if (_transactionIdController.text.isEmpty) {
                  Get.snackbar(
                    'Verification Alert',
                    'Please fill in your payment Transaction ID.',
                    snackPosition: SnackPosition.TOP,
                    backgroundColor: const Color(0xFF1D3538),
                    colorText: AppColors.accentGold,
                    margin: const EdgeInsets.all(16),
                  );
                  return;
                }

                // Submit request to admin and navigate to requests view
                controller.submitPurchaseRequest(
                  product: product,
                  quantity: _quantity,
                  transactionId: _transactionIdController.text.trim(),
                  fileName: _fileName,
                  remark: _remarkController.text.trim(),
                );

                // Reset form fields
                setState(() {
                  _quantity = 1;
                  _transactionIdController.clear();
                  _remarkController.clear();
                  _fileName = "No file chosen";
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentGold,
                foregroundColor: AppColors.primaryDark,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.diamond_outlined, color: AppColors.primaryDark, size: 18),
                  SizedBox(width: 8),
                  Text(
                    'BUY NOW',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // --- Form Element: Quantity Selector ---
  Widget _buildQuantitySelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          decoration: BoxDecoration(
            color: const Color(0xFF0A1D20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF133F44), width: 1.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.remove, color: AppColors.accentGold, size: 16),
                onPressed: () {
                  if (_quantity > 1) {
                    setState(() {
                      _quantity--;
                    });
                  }
                },
              ),
              Text(
                '$_quantity',
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add, color: AppColors.accentGold, size: 16),
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // --- Form Element: Standard Text Input ---
  Widget _buildInputField(String label, String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        SizedBox(
          height: 48,
          child: TextField(
            controller: controller,
            style: const TextStyle(fontFamily: 'Poppins', color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFF0A1D20),
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white24, fontSize: 13),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Color(0xFF133F44), width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.accentGold, width: 1.2),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // --- Form Element: Upload Receipt Picker ---
  Widget _buildFilePicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Upload Receipt',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 13, fontWeight: FontWeight.bold, color: Colors.white70),
        ),
        const SizedBox(height: 8),
        Container(
          height: 48,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF0A1D20),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFF133F44), width: 1.0),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 32,
                child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _fileName = "receipt_${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}.jpg";
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1E3538),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                  ),
                  child: const Text(
                    'Choose file',
                    style: TextStyle(fontFamily: 'Poppins', fontSize: 11, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _fileName,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white38,
                    fontSize: 12,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
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
