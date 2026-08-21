import 'package:get/get.dart';

class FAQItem {
  final String question;
  final String answer;

  FAQItem({required this.question, required this.answer});
}

class FAQController extends GetxController {
  final RxInt expandedIndex = 0.obs; // First item expanded by default

  final List<FAQItem> faqs = [
    FAQItem(
      question: 'What is this platform?',
      answer: 'This platform allows users to browse and purchase gold products securely at the best available rates.',
    ),
    FAQItem(
      question: 'How do I purchase a product?',
      answer: 'Browse our collection, click "Own It Now" to acquire gold items, and they will reflect under your purchase balances.',
    ),
    FAQItem(
      question: 'How can I check my purchases?',
      answer: 'Go to the Dashboard and tap on "My Purchase" to view detailed transaction statements and ownership proofs.',
    ),
    FAQItem(
      question: 'What payment methods are supported?',
      answer: 'We support secure payment methods including Net Banking, UPI, and debit/credit cards.',
    ),
    FAQItem(
      question: 'How can I contact support?',
      answer: 'You can create a ticket directly on the Support page, or click "Help & Support" in Settings.',
    ),
    FAQItem(
      question: 'Can I cancel a purchase?',
      answer: 'Yes, purchases can be cancelled within 24 hours, subject to gold rate fluctuation adjustments.',
    ),
    FAQItem(
      question: 'Is delivery available?',
      answer: 'Secure, insured home delivery of physical gold items is available to all registered pin codes.',
    ),
  ];

  void toggleExpand(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = -1; // Collapse
    } else {
      expandedIndex.value = index; // Expand
    }
  }
}
