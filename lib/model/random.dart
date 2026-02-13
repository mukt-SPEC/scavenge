/// The base sealed class for all users in the recycling app.
sealed class User {
  final String id;
  final String name;
  final String? profilePictureUrl;
  final String email;
  final DateTime createdAt;

  const User({
    required this.id,
    required this.name,
    this.profilePictureUrl,
    required this.email,
    required this.createdAt,
  });

  /// Standard factory constructor to parse JSON based on user role
  factory User.fromMap(Map<String, dynamic> map) {
    final role = map['role'] as String?;
    if (role == 'agent') {
      return Agent.fromMap(map);
    }
    // Defaults to Customer if no role is specified or it's 'customer'
    return Customer.fromMap(map);
  }

  Map<String, dynamic> toMap();
}

// --- CUSTOMER MODEL ---

/// Represents a standard user like "Mustapha" who recycles and trades.
class Customer extends User {
  final double walletBalance; // Relates to the "Wallet" card
  final int totalRecycledItems; // Relates to the "Recycle" action
  final int totalTradedItems; // Relates to the "Trade" action

  const Customer({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    super.profilePictureUrl,
    this.walletBalance = 0.0,
    this.totalRecycledItems = 0,
    this.totalTradedItems = 0,
  });

  Customer copyWith({
    String? id,
    String? name,
    String? profilePictureUrl,
    String? email,
    DateTime? createdAt,
    double? walletBalance,
    int? totalRecycledItems,
    int? totalTradedItems,
  }) {
    return Customer(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      walletBalance: walletBalance ?? this.walletBalance,
      totalRecycledItems: totalRecycledItems ?? this.totalRecycledItems,
      totalTradedItems: totalTradedItems ?? this.totalTradedItems,
    );
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      walletBalance: (map['walletBalance'] as num?)?.toDouble() ?? 0.0,
      totalRecycledItems: map['totalRecycledItems'] as int? ?? 0,
      totalTradedItems: map['totalTradedItems'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'role': 'customer',
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': createdAt.toIso8601String(),
      'walletBalance': walletBalance,
      'totalRecycledItems': totalRecycledItems,
      'totalTradedItems': totalTradedItems,
    };
  }
}

// --- AGENT MODEL ---

/// Represents an agent who facilitates the recycling/trading process.
class Agent extends User {
  final double rating; // Agent's performance rating
  final bool isAvailable; // Whether the agent is currently taking requests
  final int completedTransactions;

  const Agent({
    required super.id,
    required super.name,
    required super.email,
    required super.createdAt,
    super.profilePictureUrl,
    this.rating = 5.0,
    this.isAvailable = true,
    this.completedTransactions = 0,
  });

  Agent copyWith({
    String? id,
    String? name,
    String? profilePictureUrl,
    String? email,
    DateTime? createdAt,
    double? rating,
    bool? isAvailable,
    int? completedTransactions,
  }) {
    return Agent(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      email: email ?? this.email,
      createdAt: createdAt ?? this.createdAt,
      rating: rating ?? this.rating,
      isAvailable: isAvailable ?? this.isAvailable,
      completedTransactions:
          completedTransactions ?? this.completedTransactions,
    );
  }

  factory Agent.fromMap(Map<String, dynamic> map) {
    return Agent(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profilePictureUrl: map['profilePictureUrl'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      rating: (map['rating'] as num?)?.toDouble() ?? 5.0,
      isAvailable: map['isAvailable'] as bool? ?? true,
      completedTransactions: map['completedTransactions'] as int? ?? 0,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'role': 'agent',
      'id': id,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': createdAt.toIso8601String(),
      'rating': rating,
      'isAvailable': isAvailable,
      'completedTransactions': completedTransactions,
    };
  }
}
