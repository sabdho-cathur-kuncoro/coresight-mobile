class RegionStoreModel {
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
  String? createdDate;
  String? updatedDate;

  RegionStoreModel({
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
    this.updatedDate,
  });

  factory RegionStoreModel.fromJson(Map<String, dynamic> json) {
    return RegionStoreModel(
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
      updatedDate: json['updated_date'],
    );
  }

  RegionStoreModel copyWith({
    String? regionId,
    String? regionName,
    String? areaId,
    String? areaName,
    String? cityId,
    String? cityName,
    String? salesId,
    String? salesName,
    String? storeId,
    String? storeName,
    String? longitude,
    String? latitude,
    String? radius,
    String? createdDate,
    String? updatedDate,
  }) => RegionStoreModel(
    regionId: regionId ?? this.regionId,
    regionName: regionName ?? this.regionName,
    areaId: areaId ?? this.areaId,
    areaName: areaName ?? this.areaName,
    cityId: cityId ?? this.cityId,
    cityName: cityName ?? this.cityName,
    salesId: salesId ?? this.salesId,
    salesName: salesName ?? this.salesName,
    storeId: storeId ?? this.storeId,
    storeName: storeName ?? this.storeName,
    longitude: longitude ?? this.longitude,
    latitude: latitude ?? this.latitude,
    radius: radius ?? this.radius,
    createdDate: createdDate ?? this.createdDate,
    updatedDate: updatedDate ?? this.updatedDate,
  );
}
