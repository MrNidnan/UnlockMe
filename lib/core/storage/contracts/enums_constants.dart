class ReserveStatus {
  static const String active = 'active';
  static const String cancelled = 'cancelled';
  static const String finished = 'finished';
  static const String used = 'used';
}

class BikeStatus {
  static const String available = 'available';
  static const String inUse = 'inUse';
  static const String reserved = 'reserved';
  static const String maintenance = 'maintenance';
  static const String lowBattery = 'lowBattery';
}

class VehicleAction {
  static const String started = 'started';
  static const String ended = 'ended';
}
