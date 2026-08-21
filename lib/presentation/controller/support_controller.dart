import 'package:get/get.dart';

class SupportTicket {
  final String id;
  final String category;
  final String description;
  final String status;
  final String date;

  SupportTicket({
    required this.id,
    required this.category,
    required this.description,
    required this.status,
    required this.date,
  });
}

class SupportController extends GetxController {
  final RxList<SupportTicket> tickets = <SupportTicket>[].obs;

  void addTicket(String category, String description) {
    final newId = 'OMST${100000 + tickets.length + 1}';
    final now = DateTime.now();
    final formattedDate = '${now.day} ${_getMonthName(now.month)} ${now.year}';
    
    tickets.add(
      SupportTicket(
        id: newId,
        category: category,
        description: description,
        status: 'Open',
        date: formattedDate,
      ),
    );
  }

  String _getMonthName(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    if (month >= 1 && month <= 12) {
      return months[month - 1];
    }
    return 'Aug';
  }
}
