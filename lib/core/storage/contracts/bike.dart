class Bike {
  final int? id;
  final double latitude;
  final double longitude;
  final int batteryLife;
  final int hotelId;
  final String status;

  Bike({
    this.id,
    required this.latitude,
    required this.longitude,
    required this.batteryLife,
    required this.hotelId,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'latitude': latitude,
      'longitude': longitude,
      'battery_life': batteryLife,
      'hotelId': hotelId,
      'status': status,
    };
  }

  factory Bike.fromMap(Map<String, dynamic> map) {
    return Bike(
      id: map['id'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      batteryLife: map['battery_life'],
      hotelId: map['hotelId'],
      status: map['status'],
    );
  }
}