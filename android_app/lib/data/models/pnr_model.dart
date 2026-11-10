class PassengerStatus {
  final int number;
  final String bookingStatus; // e.g. "B2, 45, MB"
  final String currentStatus; // e.g. "CNF", "WL 12", "RAC 4"
  final String coach;
  final int berth;
  final String berthType; // Lower, Middle, Upper, Side Lower, Side Upper

  const PassengerStatus({
    required this.number,
    required this.bookingStatus,
    required this.currentStatus,
    required this.coach,
    required this.berth,
    required this.berthType,
  });
}

class PnrRecord {
  final String pnrNumber;
  final String trainNumber;
  final String trainName;
  final String journeyDate;
  final String fromStation;
  final String toStation;
  final String boardingPoint;
  final String reservedClass;
  final bool chartPrepared;
  final List<PassengerStatus> passengers;

  const PnrRecord({
    required this.pnrNumber,
    required this.trainNumber,
    required this.trainName,
    required this.journeyDate,
    required this.fromStation,
    required this.toStation,
    required this.boardingPoint,
    required this.reservedClass,
    required this.chartPrepared,
    required this.passengers,
  });
}
