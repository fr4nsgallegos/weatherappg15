import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherappg15/models/forecast_model.dart';
import 'package:weatherappg15/models/user_model.dart';
import 'package:weatherappg15/models/weather_model.dart';
import 'package:weatherappg15/services/api_weather_service.dart';
import 'package:weatherappg15/services/dio_client.dart';
import 'package:weatherappg15/services/user_api_retrofit.dart';
import 'package:weatherappg15/services/user_mockapi_service.dart';
import 'package:weatherappg15/widgets/forecast_widget.dart';
import 'package:weatherappg15/widgets/search_city_widget.dart';
import 'package:weatherappg15/widgets/weather_item.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _cityController = TextEditingController();
  // WeatherModel? _weatherModel;
  ForecastModel? _forecastModel;

  Future<Position?> getPosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    // Verificamos si el servicios esta habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      print(("Los servicios estan deshabilitados"));
      return null;
    }

    // Verificamos los permisos
    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied) {
        print("Permiso de ubicación denegado");
        return null;
      }
    }

    if (locationPermission == LocationPermission.deniedForever) {
      print("Los permisos de ubicación estan permanentemente denegados");
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition();
      print(position);
      return position;
    } catch (e) {
      print("ERROR AL OBTNER LA UBICACIÓN: $e");
      return null;
    }
  }

  // Future<void> getWeatherByPosition() async {
  //   Position? _pos = await getPosition();
  //   if (_pos == null) {
  //     print("No se pudo obtener la ubicación");
  //     return null;
  //   }

  //   _weatherModel = await ApiWeatherService().getWeatherInfoByPos(_pos);
  //   setState(() {});
  // }

  Future<void> getForecastByPosition() async {
    Position? _pos = await getPosition();
    if (_pos == null) {
      print("No se pudo obtener la ubicación");
      return null;
    }

    _forecastModel = await ApiWeatherService().getForecastInfoByPos(_pos);
    setState(() {});
  }

  // Future<void> getWeather() async {
  //   _weatherModel = await ApiWeatherService().getWeatherInfoByName();
  //   setState(() {});
  // }
  //
  // Future<void> getForecast() async {
  //   _forecastModel = await ApiWeatherService().getForecastInfoByPos();
  //   setState(() {});
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // getWeather();
    // getForecast();
    getForecastByPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ApiWeatherService().getWeatherInfo();
          final userApiRetrofit = UserApiRetrofit(DioClient.getDio());
          // Obteniendo usuarios con dio y retrofit
          await userApiRetrofit.getUsers().then((value) {
            value.forEach((e) {
              print(e.name);
            });
          });

          await userApiRetrofit.getUserById("5").then((value) {
            print(value.name);
          });
        },
      ),
      backgroundColor: Color(0xff2C2F31),
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: Color(0xff2C2F31),
        title: Text("Weather App"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await getForecastByPosition();
            },
            icon: Icon(Icons.location_on_outlined),
          ),
        ],
      ),
      body: _forecastModel == null
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                SearchCityWidget(controller: _cityController, function: () {}),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    // color: Colors.red,
                    gradient: LinearGradient(
                      colors: [Color(0xff2E5FEC), Color(0xff6B9BF8)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0.2, 0.8],
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "${_forecastModel!.location.name}, ${_forecastModel!.location.country}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 32),
                      Image.asset("assets/icons/heavycloudy.png", height: 100),
                      Text(
                        "${_forecastModel!.current.tempC} °",
                        style: TextStyle(color: Colors.white, fontSize: 100),
                      ),
                      Divider(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherItem(
                            value: _forecastModel!.current.visKm,
                            unit: "km/h",
                            image: "windspeed",
                          ),
                          WeatherItem(
                            value: _forecastModel!.current.humidity.toDouble(),
                            unit: "%",
                            image: "humidity",
                          ),
                          WeatherItem(
                            value: _forecastModel!.current.cloud.toDouble(),
                            unit: "%",
                            image: "cloud",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      _forecastModel!.forecast.forecastday[0].hour.length,
                      (index) => ForecastWidget(
                        hour: _forecastModel!
                            .forecast
                            .forecastday[0]
                            .hour[index]
                            .time
                            .toString()
                            .substring(11, 16),
                        temp: _forecastModel!
                            .forecast
                            .forecastday[0]
                            .hour[index]
                            .tempC
                            .toString(),
                        isDay: _forecastModel!
                            .forecast
                            .forecastday[0]
                            .hour[index]
                            .isDay,
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
