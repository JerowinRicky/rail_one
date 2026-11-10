class Station {
  final String code;
  final String name;
  final String hindiName;
  final String zone;
  final String state;
  final double? latitude;
  final double? longitude;

  const Station({
    required this.code,
    required this.name,
    required this.hindiName,
    required this.zone,
    required this.state,
    this.latitude,
    this.longitude,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      hindiName: json['hindiName'] ?? json['name'] ?? '',
      zone: json['zone'] ?? 'IR',
      state: json['state'] ?? '',
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() => {
        'code': code,
        'name': name,
        'hindiName': hindiName,
        'zone': zone,
        'state': state,
        'latitude': latitude,
        'longitude': longitude,
      };
}
