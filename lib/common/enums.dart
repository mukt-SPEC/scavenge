import 'dart:convert';

enum WasteType {
  paper('Paper'),
  metal('Metal'),
  plastic('Plastic'),
  others('Others');

  final String label;
  const WasteType(this.label);
}

enum TransactionType { RECYCLE, TRADE }

class Location {
  final double latitude;
  final double longitude;
  final String address;

  const Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  Map<String, dynamic> toMap() => {
    'latitude': latitude,
    'longitude': longitude,
    'address': address,
  };

  factory Location.fromMap(Map<String, dynamic> map) => Location(
    latitude: map['latitude']?.toDouble() ?? 0.0,
    longitude: map['longitude']?.toDouble() ?? '',
    address: map['address'] ?? '',
  );
}

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
