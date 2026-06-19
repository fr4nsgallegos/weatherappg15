// se crea para no repetir configuraciones de consumo
import 'package:dio/dio.dart';

class DioClient {
  static Dio getDio() {
    return Dio(
      BaseOptions(
        headers: {"Content-Type": "application/json"},
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
  }
}
