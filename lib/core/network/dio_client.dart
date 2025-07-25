import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class ApiUrls {
  static const String baseUrl = "https://opentdb.com/";
}

class QuizApiService {
  Future<List<dynamic>> fetchQuestions({required int amount, String? category, String? difficulty, String? type}) async {
    try {
      final queryParams = {
        "amount": amount.toString(),
        if (category != null && category.isNotEmpty) "category": category,
        if (difficulty != null && difficulty.isNotEmpty) "difficulty": difficulty,
        if (type != null && type.isNotEmpty) "type": type,
      };

      final response = await DioClient().dio.get("${ApiUrls.baseUrl}api.php", queryParameters: queryParams);

      if (response.statusCode == 200) {
        return response.data["results"];
      } else {
        throw Exception("Failed to load questions");
      }
    } catch (e) {
      rethrow;
    }
  }
}

class DioClient {
  static final DioClient _singleton = DioClient._internal();
  final Dio dio;

  factory DioClient() => _singleton;

  DioClient._internal()
    : dio = Dio(
        BaseOptions(
          connectTimeout: const Duration(seconds: 15),
          receiveTimeout: const Duration(seconds: 20),
          sendTimeout: const Duration(seconds: 15),
        ),
      ) {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) => handler.next(options),
        onResponse: (response, handler) => handler.next(response),
        onError: (error, handler) async {
          final response = error.response;

          if (response != null) {}

          handler.next(error);
        },
      ),
    );
  }
}
