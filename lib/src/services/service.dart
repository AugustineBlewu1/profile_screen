import 'package:dio/dio.dart';

// API SERVICE
class ApiService {
  static ApiService? _apiService;

  late Dio dio;

  factory ApiService({
    String? token,
  }) {
    _apiService ??= ApiService._internal(token: token);
    return _apiService!;
  }

  ApiService._internal({required String? token}) {
    BaseOptions options = BaseOptions(
        persistentConnection: true,
        contentType: "application/json",
        baseUrl: "https://fixit-testing.tuulbox.app/api/");

    dio = Dio(options);

    dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (token!.isNotEmpty) {
          options.headers['Autorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onResponse: (response, handler) => handler.next(response),
      onError: (error, handler) => handler.next(error),
    ));
  }

  Future<Response> submitFormdata(Map<String, dynamic> data) async {
    try {
      final response = await dio
          .patch("accounts/6d475484-c5d6-492d-98c7-27b0733806b1", data: data);

      return response;
    } catch (error) {
      rethrow;
    }
  }
}
