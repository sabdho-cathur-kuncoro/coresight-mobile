class PresenceModel {
  final String? salesId;
  final String? salesName;
  final String? absentCode;
  final String? absentName;
  final int? month;
  final int? year;
  final String? createdBy;
  final String? updatedBy;
  final String? createdDate;
  final String? incomingAttendance;
  final String? repeatAttendance;
  final String? incomingFilePhoto;
  final String? incomingUrlPhoto;
  final double? incomingLatitude;
  final double? incomingLongitude;
  final String? repeatFilePhoto;
  final String? repeatUrlPhoto;
  final double? repeatLatitude;
  final double? repeatLongitude;

  PresenceModel({
    this.salesId,
    this.salesName,
    this.absentCode,
    this.absentName,
    this.month,
    this.year,
    this.incomingFilePhoto,
    this.incomingUrlPhoto,
    this.incomingLatitude,
    this.incomingLongitude,
    this.repeatFilePhoto,
    this.repeatUrlPhoto,
    this.repeatLatitude,
    this.repeatLongitude,
    this.createdBy,
    this.updatedBy,
    this.createdDate,
    this.incomingAttendance,
    this.repeatAttendance,
  });

  factory PresenceModel.fromJson(Map<String, dynamic> json) {
    double? parseDouble(dynamic v) {
      if (v == null) return null;
      if (v is double) return v;
      if (v is int) return v.toDouble();
      return double.tryParse(v.toString());
    }

    return PresenceModel(
      salesId: json['sales_id']?.toString(),
      salesName: json['sales_name']?.toString(),
      absentName: json['absent_name']?.toString(),
      incomingAttendance: json['incoming_attendance']?.toString(),
      repeatAttendance: json['repeat_attendance']?.toString(),
      createdDate: json['created_date']?.toString(),
      incomingUrlPhoto: json['incoming_url_photo'].toString(),
      repeatFilePhoto: json['repeat_url_photo'].toString(),
      incomingLatitude: parseDouble(json['incoming_latitude']),
      incomingLongitude: parseDouble(json['incoming_longitude']),
      repeatLatitude: parseDouble(json['repeat_latitude']),
      repeatLongitude: parseDouble(json['repeat_longitude']),
    );
  }

  factory PresenceModel.fromDetailJson(Map<String, dynamic> json) =>
      PresenceModel.fromJson(json);

  Map<String, dynamic> toJson({required bool isClockOut}) {
    return {
      'sales_id': salesId,
      'absent_code': absentCode,
      if (!isClockOut) ...{
        'incoming_latitude': incomingLatitude,
        'incoming_longitude': incomingLongitude,
        'incoming_file_photo': incomingFilePhoto,
        'created_by': createdBy,
      } else ...{
        'repeat_latitude': repeatLatitude,
        'repeat_longitude': repeatLongitude,
        'repeat_file_photo': repeatFilePhoto,
        'updated_by': updatedBy,
      },
    };
  }
}
