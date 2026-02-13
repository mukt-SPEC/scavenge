import 'package:scavenge/common/enums.dart';

sealed class User {
  final String id;
  final String name;
  final String? profilePicUrl;
  final double walletBalance;
  
  final String? fcmToken;
  final Location location;
  final bool isLiveChatActive;

  const User({
    required this.id,
    required this.name,
    this.profilePicUrl,
    required this.walletBalance,
   
    this.fcmToken,
    required this.location,
    required this.isLiveChatActive,
  });
}

/// Represents a standard app user (e.g., Mustapha)
class Customer extends User {
  final List<WasteType> preferredWasteTypes;
  final List<Transaction> transactionHistory;
  final int activePickupRequests;

  const Customer({
    required super.id,
    required super.name,
    super.profilePicUrl,
    super.walletBalance = 0.0,
    
    super.fcmToken,
    required super.location,
    super.isLiveChatActive = false,
    this.preferredWasteTypes = const [],
    this.transactionHistory = const [],
    this.activePickupRequests = 0,
  });

  // Equivalent to Kotlin's .copy()
  Customer copyWith({
    String? id,
    String? name,
    String? profilePicUrl,
    double? walletBalance,
    int? rewardPoints,
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
}

/// Represents a recycling agent
class Agent extends User {
  final bool isAvailable;
  final List<WasteType> acceptedWasteTypes;
  final double rating;
  final int completedPickups;
  final String? vehicleLicensePlate;

  const Agent({
    required super.id,
    required super.name,
    super.profilePicUrl,
    super.walletBalance = 0.0,
    
    super.fcmToken,
    required super.location,
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
    String? profilePicUrl,
    double? walletBalance,
    int? rewardPoints,
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
}
