class SigninFormModel {
  final String? username;
  final String? password;
  final String? deviceId;

  SigninFormModel({this.username, this.password, this.deviceId});

  Map<String, dynamic> toJson() {
    return {'user_name': username, 'password': password, 'device_id': deviceId};
  }

  Map<String, String?> toLogoutJson() {
    return {"user_name": username, "device_id": deviceId};
  }
}
