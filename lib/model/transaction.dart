import 'package:scavenge/common/enums.dart';

class Transaction {
  final String id;
  final TransactionType type;
  final WasteType wasteType;
  final double amount;
  final DateTime date;
  final String? attachedImageUrl;

  const Transaction({
    required this.id,
    required this.type,
    required this.wasteType,
    required this.amount,
    required this.date,
    this.attachedImageUrl,
  });
}