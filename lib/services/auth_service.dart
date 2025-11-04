import 'dart:convert';

import 'package:coresight/config/api_config.dart';
import 'package:coresight/models/signin_form_model.dart';
import 'package:coresight/models/user_model.dart';
import 'package:coresight/ui/widgets/loading.dart';
import 'package:coresight/utils/device_info_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<UserModel> login(SigninFormModel data) async {
    try {
      final deviceInfo = await DeviceInfoHelper.getDeviceDetails();
      final Dio dio = ApiService.public;
      final dataSubmit = {
        "user_name": data.username,
        "password": data.password,
        "device_id": deviceInfo['device_id'],
      };
      final res = await dio.post('/user/login', data: dataSubmit);

      if (res.statusCode == 200) {
        UserModel user = UserModel.fromJson(res.data);
        user = user.copyWith(
          username: dataSubmit["user_name"],
          password: dataSubmit["password"],
          deviceId: dataSubmit["device_id"],
        );

        await storeCredentialToLocal(user);

        return user;
      } else {
        throw Exception('Invalid response');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    } finally {
      GlobalLoading.hide();
    }
  }

  Future<void> logout(Map<String, String?> data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = await getToken();
      final Dio dioBearer = ApiService.withToken(token);

      final res = await dioBearer.post('user/logout', data: data);

      if (res.statusCode == 200) {
        await prefs.remove('onboarding_complete');
        await clearLocalStorage();
      } else {
        throw jsonDecode(res.data)['message'];
      }
    } catch (e) {
      rethrow;
    } finally {
      GlobalLoading.hide();
    }
  }

  Future<void> storeCredentialToLocal(UserModel user) async {
    try {
      const storage = FlutterSecureStorage();
      await storage.write(key: 'token', value: user.token);
      await storage.write(key: 'deviceId', value: user.deviceId);
      await storage.write(key: 'name', value: user.name);
      await storage.write(key: 'user_name', value: user.username);
      await storage.write(key: 'password', value: user.password);
      await storage.write(key: 'sales_id', value: user.salesId);
    } catch (e) {
      rethrow;
    }
  }

  Future<SigninFormModel> getCredentialFromLocal() async {
    try {
      const storage = FlutterSecureStorage();

      Map<String, String> values = await storage.readAll();

      if (values['user_name'] == null ||
          values['password'] == null ||
          values["deviceId"] == null) {
        throw 'Not Authenticated';
      } else {
        final SigninFormModel data = SigninFormModel(
          username: values['user_name'],
          password: values['password'],
          deviceId: values['deviceId'],
        );

        return data;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<String> getToken() async {
    try {
      String token = '';
      const storage = FlutterSecureStorage();
      String? value = await storage.read(key: 'token');

      if (value != null) {
        token = 'Bearer $value';

        return token;
      } else {
        return '';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearLocalStorage() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();
  }
}
