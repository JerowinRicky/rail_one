enum TicketType { journey, platform, season }
enum TicketMode { paperless, paper }

class DigitalTicket {
  final String ticketId;
  final TicketType type;
  final TicketMode mode;
  final String sourceStation;
  final String sourceStationName;
  final String destinationStation;
  final String destinationStationName;
  final String trainType; // Ordinary, Mail Express, Superfast
  final String classType; // Second Class (II), First Class (I)
  final int adultCount;
  final int childCount;
  final double fare;
  final DateTime bookingTime;
  final DateTime validTill;
  final String qrPayload;
  final String barcodeNumber;
  final bool isExpired;

  const DigitalTicket({
    required this.ticketId,
    required this.type,
    required this.mode,
    required this.sourceStation,
    required this.sourceStationName,
    required this.destinationStation,
    required this.destinationStationName,
    required this.trainType,
    required this.classType,
    required this.adultCount,
    required this.childCount,
    required this.fare,
    required this.bookingTime,
    required this.validTill,
    required this.qrPayload,
    required this.barcodeNumber,
    this.isExpired = false,
  });
}
