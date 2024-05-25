// reserve.dart
class Reserve {
  final int? reserveId;
  final int userId;
  final int bikeId;
  final String createdAt;
  final String endsAt;
  final String status;

  Reserve({
    this.reserveId,
    required this.userId,
    required this.bikeId,
    required this.createdAt,
    required this.endsAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'reserveId': reserveId,
      'userId': userId,
      'bikeId': bikeId,
      'createdAt': createdAt,
      'endsAt': endsAt,
      'status': status,
    };
  }

  factory Reserve.fromMap(Map<String, dynamic> map) {
    return Reserve(
      reserveId: map['reserveId'],
      userId: map['userId'],
      bikeId: map['bikeId'],
      createdAt: map['createdAt'],
      endsAt: map['endsAt'],
      status: map['status'],
    );
  }
}
