class Location {
  double latitude;
  double longitude;
  String? address;

  Location({required this.latitude, required this.longitude, this.address});

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
