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
