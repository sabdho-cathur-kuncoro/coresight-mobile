class TodayActivitiesModel {
  final String? salesId;
  final String? salesName;
  final dynamic totalVisit;
  final dynamic totalPricing;
  final dynamic totalStock;

  TodayActivitiesModel({
    this.salesId,
    this.salesName,
    this.totalVisit,
    this.totalPricing,
    this.totalStock,
  });

  factory TodayActivitiesModel.fromJson(Map<String, dynamic> json) {
    return TodayActivitiesModel(
      salesId: json['sales_id'],
      salesName: json['sales_name'],
      totalVisit: json['total_visit'],
      totalPricing: json['total_pricing'],
      totalStock: json['total_stock'],
    );
  }
}
