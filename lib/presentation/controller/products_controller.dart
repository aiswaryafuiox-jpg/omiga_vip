import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/const/app_images.dart';
import 'dashboard_controller.dart';

class ProductItem {
  final String id;
  final String title;
  final String barcode;
  final double price;
  final String imageUrl;
  final RxBool isFavorite;

  ProductItem({
    required this.id,
    required this.title,
    required this.barcode,
    required this.price,
    required this.imageUrl,
    bool isFav = false,
  }) : isFavorite = isFav.obs;
}

class AdminRequest {
  final String id;
  final String productTitle;
  final String barcode;
  final int quantity;
  final double unitPrice;
  final double totalPrice;
  final String transactionId;
  final String fileName;
  final String remark;
  final DateTime date;
  final String status;

  AdminRequest({
    required this.id,
    required this.productTitle,
    required this.barcode,
    required this.quantity,
    required this.unitPrice,
    required this.totalPrice,
    required this.transactionId,
    required this.fileName,
    required this.remark,
    required this.date,
    this.status = 'Pending',
  });
}

class ProductsController extends GetxController {
  final RxList<AdminRequest> adminRequests = <AdminRequest>[].obs;
  final RxList<ProductItem> products = <ProductItem>[
    ProductItem(id: '1', title: 'STUD', barcode: 'STL-000223', price: 75776.82, imageUrl: AppImages.goldEarrings),
    ProductItem(id: '2', title: 'STUD', barcode: 'STL-000224', price: 88369.40, imageUrl: AppImages.goldEarrings),
    ProductItem(id: '3', title: 'STUD', barcode: 'STL-000225', price: 81460.40, imageUrl: AppImages.goldEarrings),
    ProductItem(id: '4', title: 'STUD', barcode: 'STL-000226', price: 68859.70, imageUrl: AppImages.goldEarrings),
    ProductItem(id: '5', title: 'STUD', barcode: 'STL-000227', price: 92450.00, imageUrl: AppImages.goldEarrings),
    ProductItem(id: '6', title: 'STUD', barcode: 'STL-000228', price: 115300.00, imageUrl: AppImages.goldEarrings),
  ].obs;

  final RxBool isLoadingAll = false.obs;
  final RxBool isAllLoaded = false.obs;

  // Cart Management
  final RxList<ProductItem> cartItems = <ProductItem>[].obs;

  void addToCart(ProductItem product) {
    cartItems.add(product);
    Get.snackbar(
      'Added to Cart',
      '${product.title} has been added to your cart.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF122326),
      colorText: const Color(0xFFE5C158),
      borderColor: const Color(0xFF1D3538),
      borderWidth: 1.0,
      margin: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 2),
    );
  }

  void removeFromCart(ProductItem product) {
    cartItems.remove(product);
  }

  double get cartTotal => cartItems.fold(0, (sum, item) => sum + item.price);

  void checkoutCart() {
    if (cartItems.isEmpty) return;
    try {
      final dashboardController = Get.find<DashboardController>();
      dashboardController.myPurchase.value += cartTotal;
      
      Get.snackbar(
        'Purchase Successful',
        'Successfully purchased ${cartItems.length} items for ₹${cartTotal.toStringAsFixed(2)}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF122326),
        colorText: const Color(0xFFE5C158),
        borderColor: const Color(0xFF1D3538),
        borderWidth: 1.0,
        margin: const EdgeInsets.all(16.0),
        duration: const Duration(seconds: 3),
      );
      cartItems.clear();
    } catch (e) {
      Get.snackbar(
        'Success',
        'Purchased items for ₹${cartTotal.toStringAsFixed(2)}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF122326),
        colorText: const Color(0xFFE5C158),
        margin: const EdgeInsets.all(16.0),
      );
      cartItems.clear();
    }
  }

  Future<void> loadAllProducts() async {
    if (isAllLoaded.value || isLoadingAll.value) return;

    isLoadingAll.value = true;

    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    // Generate remaining 70 products
    final List<String> categories = ['STUD', 'NECKLACE', 'RING', 'BANGLES', 'BRACELET', 'EARRINGS'];
    final List<String> codes = ['STL', 'NCK', 'RNG', 'BGL', 'BRC', 'EAR'];
    
    final List<ProductItem> newProducts = [];
    for (int i = 7; i <= 76; i++) {
      int catIdx = i % categories.length;
      String category = categories[catIdx];
      String code = codes[catIdx];
      double basePrice = 50000.0 + (i * 1234.56) % 150000.0;
      
      newProducts.add(
        ProductItem(
          id: i.toString(),
          title: category,
          barcode: '$code-${(220 + i).toString().padLeft(6, '0')}',
          price: double.parse(basePrice.toStringAsFixed(2)),
          imageUrl: AppImages.goldEarrings,
        ),
      );
    }

    products.addAll(newProducts);
    isAllLoaded.value = true;
    isLoadingAll.value = false;
  }

  void ownProduct(ProductItem product) {
    try {
      final dashboardController = Get.find<DashboardController>();
      dashboardController.myPurchase.value += product.price;
      
      Get.snackbar(
        'Purchase Successful',
        'Successfully owned ${product.title} (${product.barcode}) for ₹${product.price.toStringAsFixed(2)}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF122326),
        colorText: const Color(0xFFE5C158),
        borderColor: const Color(0xFF1D3538),
        borderWidth: 1.0,
        margin: const EdgeInsets.all(16.0),
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Success',
        'Owned product for ₹${product.price.toStringAsFixed(2)}',
        snackPosition: SnackPosition.TOP,
        backgroundColor: const Color(0xFF122326),
        colorText: const Color(0xFFE5C158),
        margin: const EdgeInsets.all(16.0),
      );
    }
  }

  void toggleFavorite(ProductItem product) {
    product.isFavorite.value = !product.isFavorite.value;
  }

  void submitPurchaseRequest({
    required ProductItem product,
    required int quantity,
    required String transactionId,
    required String fileName,
    required String remark,
  }) {
    final request = AdminRequest(
      id: '${DateTime.now().millisecondsSinceEpoch}',
      productTitle: product.title,
      barcode: product.barcode,
      quantity: quantity,
      unitPrice: product.price,
      totalPrice: product.price * quantity,
      transactionId: transactionId,
      fileName: fileName,
      remark: remark,
      date: DateTime.now(),
    );

    adminRequests.add(request);

    Get.snackbar(
      'Request Submitted',
      'Your purchase request has been sent to the Admin for approval.',
      snackPosition: SnackPosition.TOP,
      backgroundColor: const Color(0xFF122326),
      colorText: const Color(0xFFE5C158),
      borderColor: const Color(0xFF1D3538),
      borderWidth: 1.0,
      margin: const EdgeInsets.all(16.0),
      duration: const Duration(seconds: 3),
    );
  }
}
