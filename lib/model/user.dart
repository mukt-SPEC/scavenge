import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scavenge/common/enums.dart';
import 'package:scavenge/model/location.dart';

sealed class UserModel {
  final String id;
  final String name;
  final String email;
  final UserType role;
  final String phoneNumber;
  final String? profilePicUrl;
  final double walletBalance;
  final String? fcmToken;
  final Location? location;
  final bool isLiveChatActive;

  const UserModel({
    required this.role,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profilePicUrl,
    required this.walletBalance,
    this.fcmToken,
    this.location,
    required this.isLiveChatActive,
  });

  Map<String, dynamic> toMap();

  factory UserModel.fromMap(Map<String, dynamic> map) {
    final userTypeString = map['role'] as String? ?? '';

    final roleEnum = UserType.values.byName(userTypeString);

    if (roleEnum == UserType.customer) {
      return Customer.fromMap(map);
    } else if (roleEnum == UserType.agent) {
      return Agent.fromMap(map);
    } else {
      throw Exception('Unknown user role in database');
    }
  }
}

class Customer extends UserModel {
  final List<WasteType> preferredWasteTypes;
  final List<Transaction> transactionHistory;
  final int activePickupRequests;

  const Customer({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    super.role = UserType.customer,
    super.profilePicUrl,
    super.walletBalance = 0.0,
    super.fcmToken,
    super.location,
    super.isLiveChatActive = false,
    this.preferredWasteTypes = const [],
    this.transactionHistory = const [],
    this.activePickupRequests = 0,
  });
  Customer copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profilePicUrl,
    double? walletBalance,
    String? fcmToken,
    Location? location,
    bool? isLiveChatActive,
    List<WasteType>? preferredWasteTypes,
    List<Transaction>? transactionHistory,
    int? activePickupRequests,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      walletBalance: walletBalance ?? this.walletBalance,
      fcmToken: fcmToken ?? this.fcmToken,
      location: location ?? this.location,
      isLiveChatActive: isLiveChatActive ?? this.isLiveChatActive,
      preferredWasteTypes: preferredWasteTypes ?? this.preferredWasteTypes,
      transactionHistory: transactionHistory ?? this.transactionHistory,
      activePickupRequests: activePickupRequests ?? this.activePickupRequests,
    );
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicUrl: map['profilePicUrl'],
      walletBalance: (map['walletBalance'] as num?)?.toDouble() ?? 0.0,
      fcmToken: map['fcmToken'],
      location: Location.fromMap(map['location']),
      isLiveChatActive: map['isLiveChatActive'] ?? false,
      preferredWasteTypes:
          (map['preferredWasteTypes'] as List?)
              ?.map((e) => WasteType.values.byName(e))
              .toList() ??
          [],
      activePickupRequests: map['activePickupRequests'] ?? 0,
      // Note: transactionHistory usually handled separately in sub-collections
    );
  }

  /// Converts Customer Object to Map (JSON)
  @override
  Map<String, dynamic> toMap() {
    return {
      'role': role.name,
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicUrl': profilePicUrl,
      'walletBalance': walletBalance,
      'fcmToken': fcmToken,
      'location': location!.toMap(),
      'isLiveChatActive': isLiveChatActive,
      'preferredWasteTypes': preferredWasteTypes.map((e) => e.name).toList(),
      'activePickupRequests': activePickupRequests,
    };
  }
}

class Agent extends UserModel {
  final bool isAvailable;
  final List<WasteType> acceptedWasteTypes;
  final double rating;
  final int completedPickups;
  final String? vehicleLicensePlate;

  const Agent({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    super.role = UserType.agent,
    super.profilePicUrl,
    super.walletBalance = 0.0,
    super.fcmToken,
    super.location,
    super.isLiveChatActive = false,
    this.isAvailable = true,
    this.acceptedWasteTypes = WasteType.values,
    this.rating = 0.0,
    this.completedPickups = 0,
    this.vehicleLicensePlate,
  });

  Agent copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profilePicUrl,
    double? walletBalance,
    String? fcmToken,
    Location? location,
    bool? isLiveChatActive,
    bool? isAvailable,
    List<WasteType>? acceptedWasteTypes,
    double? rating,
    int? completedPickups,
    String? vehicleLicensePlate,
  }) {
    return Agent(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      walletBalance: walletBalance ?? this.walletBalance,
      fcmToken: fcmToken ?? this.fcmToken,
      location: location ?? this.location,
      isLiveChatActive: isLiveChatActive ?? this.isLiveChatActive,
      isAvailable: isAvailable ?? this.isAvailable,
      acceptedWasteTypes: acceptedWasteTypes ?? this.acceptedWasteTypes,
      rating: rating ?? this.rating,
      completedPickups: completedPickups ?? this.completedPickups,
      vehicleLicensePlate: vehicleLicensePlate ?? this.vehicleLicensePlate,
    );
  }

  factory Agent.fromMap(Map<String, dynamic> map) {
    return Agent(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicUrl: map['profilePicUrl'],
      walletBalance: (map['walletBalance'] as num?)?.toDouble() ?? 0.0,
      fcmToken: map['fcmToken'],
      location: Location.fromMap(map['location']),
      isLiveChatActive: map['isLiveChatActive'] ?? false,
      isAvailable: map['isAvailable'] ?? true,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      completedPickups: map['completedPickups'] ?? 0,
      vehicleLicensePlate: map['vehicleLicensePlate'],
      acceptedWasteTypes:
          (map['acceptedWasteTypes'] as List?)
              ?.map((e) => WasteType.values.byName(e))
              .toList() ??
          WasteType.values,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'role': role.name,
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicUrl': profilePicUrl,
      'walletBalance': walletBalance,
      'fcmToken': fcmToken,
      'location': location!.toMap(),
      'isLiveChatActive': isLiveChatActive,
      'isAvailable': isAvailable,
      'rating': rating,
      'completedPickups': completedPickups,
      'vehicleLicensePlate': vehicleLicensePlate,
      'acceptedWasteTypes': acceptedWasteTypes.map((e) => e.name).toList(),
    };
  }
}
