class TrainClassAvailability {
  final String classCode;
  final String className;
  final String status; // e.g. "AVAILABLE 45", "WL 12", "RAC 8"
  final double fare;
  final bool isAvailable;

  const TrainClassAvailability({
    required this.classCode,
    required this.className,
    required this.status,
    required this.fare,
    required this.isAvailable,
  });
}

class Train {
  final String trainNumber;
  final String trainName;
  final String departureStation;
  final String departureTime;
  final String arrivalStation;
  final String arrivalTime;
  final String duration;
  final List<String> runDays;
  final List<TrainClassAvailability> classes;
  final String? currentStation;
  final int? delayMinutes;

  const Train({
    required this.trainNumber,
    required this.trainName,
    required this.departureStation,
    required this.departureTime,
    required this.arrivalStation,
    required this.arrivalTime,
    required this.duration,
    required this.runDays,
    required this.classes,
    this.currentStation,
    this.delayMinutes,
  });
}

class CoachInfo {
  final int position;
  final String code; // e.g. ENG, H1, A1, B1, S1, PC, PWR
  final String type; // e.g. 1A, 2A, 3A, SL, GEN, PANTRY
  final int berthCount;

  const CoachInfo({
    required this.position,
    required this.code,
    required this.type,
    this.berthCount = 72,
  });
}
