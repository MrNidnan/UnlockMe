class BikeHelper {
  // Method to calculate autonomy based on battery life
  static double calculateAutonomy(int batteryPercentage) {
    // Define the maximum autonomy (40 km for 100% battery life)
    const double maxAutonomy = 50.0;

    // Calculate the autonomy based on the battery percentage
    double autonomy = (batteryPercentage / 100) * maxAutonomy;

    return autonomy;
  }
}
