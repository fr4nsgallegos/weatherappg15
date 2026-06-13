import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiWeatherService {
  String urlBase = "http://api.weatherapi.com/v1";
  Logger logger = Logger();

  Future<void> getWeatherInfo() async {
    final url = Uri.parse(
      "$urlBase/current.json?key=70866d7ade244a3c9ca20142230509&q=Lima&aqi=no",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        logger.i("""
          WEATHER API REPSONSE 
          respone: $response
          statuscode: ${response.statusCode}
          body: ${response.body}
          """);
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }
}
