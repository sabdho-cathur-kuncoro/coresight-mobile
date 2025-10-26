class StoreVisitModel {
  String? salesId;
  String? salesName;
  dynamic month;
  dynamic year;
  dynamic totalVisit;
  String? targetVisit;
  dynamic percentase;
  String? storeId;
  String? filePhotoFile;
  String? createdBy;

  StoreVisitModel({
    this.salesId,
    this.salesName,
    this.month,
    this.year,
    this.totalVisit,
    this.targetVisit,
    this.percentase,
    this.storeId,
    this.filePhotoFile,
    this.createdBy,
  });

  factory StoreVisitModel.fromJson(Map<String, dynamic> json) {
    return StoreVisitModel(
      salesId: json['sales_id'],
      salesName: json['sales_name'],
      month: json['month'],
      year: json['year'],
      totalVisit: json['total_visit'],
      targetVisit: json['target_visit'],
      percentase: json['percentase'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sales_id': salesId,
      'store_id': storeId,
      'file_photo_visit': filePhotoFile,
      'created_by': createdBy,
    };
  }
}
