class Route {
  final int? routeId;
  final String createdAt;
  final String? finishedAt;
  final int vehicleId;
  final int userId;
  final double startLatitude;
  final double startLongitude;
  final double? endLatitude;
  final double? endLongitude;

  Route({
    this.routeId,
    required this.createdAt,
    this.finishedAt,
    required this.vehicleId,
    required this.userId,
    required this.startLatitude,
    required this.startLongitude,
    this.endLatitude,
    this.endLongitude,
  });

  Map<String, dynamic> toMap() {
    return {
      'routeId': routeId,
      'createdAt': createdAt,
      'finishedAt': finishedAt,
      'vehicleId': vehicleId,
      'userId': userId,
      'startLatitude': startLatitude,
      'startLongitude': startLongitude,
      'endLatitude': endLatitude,
      'endLongitude': endLongitude,
    };
  }

  static Route fromMap(Map<String, dynamic> map) {
    return Route(
      routeId: map['routeId'],
      createdAt: map['createdAt'],
      finishedAt: map['finishedAt'],
      vehicleId: map['vehicleId'],
      userId: map['userId'],
      startLatitude: map['startLatitude'],
      startLongitude: map['startLongitude'],
      endLatitude: map['endLatitude'],
      endLongitude: map['endLongitude'],
    );
  }
}
