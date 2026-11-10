enum GrievanceType { train, station }
enum GrievanceStatus { registered, assigned, inProgress, resolved }

class GrievanceRecord {
  final String referenceNumber;
  final GrievanceType type;
  final String pnrOrStation;
  final String category;
  final String subCategory;
  final String description;
  final DateTime incidentTime;
  final GrievanceStatus status;
  final String? attachmentPath;
  final int? rating; // 1: Poor, 2: Average, 3: Good

  const GrievanceRecord({
    required this.referenceNumber,
    required this.type,
    required this.pnrOrStation,
    required this.category,
    required this.subCategory,
    required this.description,
    required this.incidentTime,
    required this.status,
    this.attachmentPath,
    this.rating,
  });
}
