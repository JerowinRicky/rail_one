import 'dart:math';

class GeofenceResult {
  final bool isEligible;
  final double distanceMeters;
  final String message;

  const GeofenceResult({
    required this.isEligible,
    required this.distanceMeters,
    required this.message,
  });
}

class GeofenceService {
  static const double maxAllowedDistanceMeters = 5000.0; // 5 km max
  static const double minAllowedDistanceMeters = 30.0;   // 30m track buffer

  /// Calculates Haversine distance between user coordinates and station coordinates
  static double calculateDistanceMeters(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371000; // in meters
    final dLat = _toRadians(lat2 - lat1);
    final dLon = _toRadians(lon2 - lon1);

    final a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  static double _toRadians(double degree) => degree * (pi / 180.0);

  /// Validates UTS Paperless Geofencing Rules
  static GeofenceResult validatePaperlessEligibility({
    required double userLat,
    required double userLon,
    required double stationLat,
    required double stationLon,
  }) {
    final dist = calculateDistanceMeters(userLat, userLon, stationLat, stationLon);

    if (dist > maxAllowedDistanceMeters) {
      return GeofenceResult(
        isEligible: false,
        distanceMeters: dist,
        message: 'You are ${(dist / 1000).toStringAsFixed(1)} km away. Paperless booking is allowed only within 5 km of departure station.',
      );
    } else if (dist < minAllowedDistanceMeters) {
      return GeofenceResult(
        isEligible: false,
        distanceMeters: dist,
        message: 'You appear to be inside station/track premises. To prevent ticketing fraud, paperless booking is blocked inside the station.',
      );
    } else {
      return GeofenceResult(
        isEligible: true,
        distanceMeters: dist,
        message: 'Eligible for Paperless ticket (${dist.toInt()}m from station).',
      );
    }
  }
}
