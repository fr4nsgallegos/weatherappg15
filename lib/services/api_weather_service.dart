import 'dart:convert';

import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:weatherappg15/models/forecast_model.dart';
import 'package:weatherappg15/models/weather_model.dart';

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

  Future<WeatherModel?> getWeatherInfoByName() async {
    final url = Uri.parse(
      "$urlBase/current.json?key=70866d7ade244a3c9ca20142230509&q=Cusco&aqi=no",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        logger.f(data);
        WeatherModel weatherModel = WeatherModel.fromJson(data);
        logger.w(weatherModel.location.name);
        return weatherModel;
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }

  Future<WeatherModel?> getWeatherInfoByPos(Position position) async {
    final url = Uri.parse(
      "$urlBase/current.json?key=70866d7ade244a3c9ca20142230509&q=${position.latitude},${position.longitude}&aqi=no",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        logger.f(data);
        WeatherModel weatherModel = WeatherModel.fromJson(data);
        logger.w(weatherModel.location.name);
        return weatherModel;
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }

  Future<ForecastModel?> getForecastInfoByPos(Position position) async {
    final url = Uri.parse(
      "$urlBase/forecast.json?key=70866d7ade244a3c9ca20142230509&q=${position.latitude},${position.longitude}&aqi=no",
    );

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        logger.f(data);
        ForecastModel forecastModel = ForecastModel.fromJson(data);
        logger.w(forecastModel.location.name);
        return forecastModel;
      }
    } catch (e) {
      throw Exception("Error inesperado: $e");
    }
  }
}
