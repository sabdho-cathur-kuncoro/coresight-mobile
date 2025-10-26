class RegionModel {
  int? id;
  String? regionId;
  String? regionName;
  String? areaId;
  String? areaName;
  String? cityId;
  String? cityName;
  String? salesId;
  String? salesName;
  String? storeId;
  String? storeName;
  String? longitude;
  String? latitude;
  String? radius;
  DateTime? createdDate;
  String? createdBy;
  DateTime? updatedDate;
  String? updatedBy;

  RegionModel({
    this.id,
    this.regionId,
    this.regionName,
    this.areaId,
    this.areaName,
    this.cityId,
    this.cityName,
    this.salesId,
    this.salesName,
    this.storeId,
    this.storeName,
    this.longitude,
    this.latitude,
    this.radius,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
  });

  factory RegionModel.fromJson(Map<String, dynamic> json) {
    return RegionModel(
      id: json['id'],
      regionId: json['region_id'],
      regionName: json['region_name'],
      areaId: json['area_id'],
      areaName: json['area_name'],
      cityId: json['city_id'],
      cityName: json['city_name'],
      salesId: json['sales_id'],
      salesName: json['sales_name'],
      storeId: json['store_id'],
      storeName: json['store_name'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      radius: json['radius'],
      createdDate: json['created_date'],
      createdBy: json['created_by'],
      updatedBy: json['updated_by'],
      updatedDate: json['updated_date'],
    );
  }
}
