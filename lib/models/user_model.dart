class UserModel {
  final String? salesId;
  final String? name;
  final String? username;
  final String? password;
  final String? deviceId;
  final String? regionId;
  final String? areaId;
  final String? cityId;
  final String? token;

  const UserModel({
    this.salesId,
    this.name,
    this.username,
    this.password,
    this.deviceId,
    this.regionId,
    this.areaId,
    this.cityId,
    this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    salesId: json['sales_id'],
    name: json['sales_name'],
    regionId: json['region_id'],
    areaId: json['area_id'],
    cityId: json['city_id'],
    token: json['token'],
  );

  UserModel copyWith({String? username, String? password, String? deviceId}) =>
      UserModel(
        salesId: salesId,
        name: name,
        username: username ?? this.username,
        password: password ?? this.password,
        deviceId: deviceId ?? this.deviceId,
        regionId: regionId,
        areaId: areaId,
        cityId: cityId,
        token: token,
      );
}
