class VehicleAction {
  final int? actionId;
  final String actionType;
  final String createdAt;
  final int vehicleId;
  final int userId;

  VehicleAction({
    this.actionId,
    required this.actionType,
    required this.createdAt,
    required this.vehicleId,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    return {
      'actionId': actionId,
      'action_type': actionType,
      'createdAt': createdAt,
      'vehicleId': vehicleId,
      'userId': userId,
    };
  }

  factory VehicleAction.fromMap(Map<String, dynamic> map) {
    return VehicleAction(
      actionId: map['actionId'],
      actionType: map['action_type'],
      createdAt: map['createdAt'],
      vehicleId: map['vehicleId'],
      userId: map['userId'],
    );
  }
}
