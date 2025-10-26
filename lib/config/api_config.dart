import 'package:coresight/ui/widgets/loading.dart';
import 'package:dio/dio.dart';

class ApiService {
  static final Dio _baseDio = Dio(
    BaseOptions(
      baseUrl: 'https://view-lt.my.id/api/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {'Content-Type': 'application/json'},
    ),
  );

  /// Public instance (no token, e.g. login, register)
  static Dio get public {
    final dio = Dio(_baseDio.options);
    return dio;
  }

  /// Private instance (with Bearer token)
  static Dio withToken(String token) {
    final dio = Dio(_baseDio.options);
    dio.interceptors.add(_globalInterceptor(token: token));
    return dio;
  }

  /// 🔄 Shared global interceptor for logging, loading, and errors
  static InterceptorsWrapper _globalInterceptor({String? token}) {
    return InterceptorsWrapper(
      onRequest: (options, handler) {
        final showLoading = options.extra['showLoading'] ?? true;
        // 🔐 Add token if available
        if (token != null && token.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer $token';
        }

        // 🌀 Show loading overlay
        if (showLoading) {
          GlobalLoading.show();
        }

        return handler.next(options);
      },
      onResponse: (response, handler) {
        final showLoading =
            response.requestOptions.extra['showLoading'] ?? true;
        // ✅ Hide loading when success
        if (showLoading) {
          GlobalLoading.hide();
        }
        return handler.next(response);
      },
      onError: (DioException e, handler) {
        final showLoading = e.requestOptions.extra['showLoading'] ?? true;
        // ❌ Hide loading when error
        if (showLoading) {
          GlobalLoading.hide();
        }

        // Optional global 401 handler
        if (e.response?.statusCode == 401) {
          print("⚠️ Token expired or unauthorized.");
        }

        return handler.next(e);
      },
    );
  }
}
