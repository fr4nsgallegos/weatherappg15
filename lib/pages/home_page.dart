import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherappg15/models/user_model.dart';
import 'package:weatherappg15/models/weather_model.dart';
import 'package:weatherappg15/services/api_weather_service.dart';
import 'package:weatherappg15/services/user_mockapi_service.dart';
import 'package:weatherappg15/widgets/search_city_widget.dart';
import 'package:weatherappg15/widgets/weather_item.dart';
import 'package:geolocator/geolocator.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _cityController = TextEditingController();
  WeatherModel? _weatherModel;

  Future<void> getPosition() async {
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

    Position position = await Geolocator.getCurrentPosition();
    print(position);
  }

  Future<void> getWeather() async {
    _weatherModel = await ApiWeatherService().getWeatherInfoByName();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          ApiWeatherService().getWeatherInfo();
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
              await getPosition();
            },
            icon: Icon(Icons.location_on_outlined),
          ),
        ],
      ),
      body: _weatherModel == null
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
                        "${_weatherModel!.location.name}, ${_weatherModel!.location.country}",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(height: 32),
                      Image.asset("assets/icons/heavycloudy.png", height: 100),
                      Text(
                        "${_weatherModel!.current.tempC} °",
                        style: TextStyle(color: Colors.white, fontSize: 100),
                      ),
                      Divider(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WeatherItem(
                            value: _weatherModel!.current.visKm,
                            unit: "km/h",
                            image: "windspeed",
                          ),
                          WeatherItem(
                            value: _weatherModel!.current.humidity.toDouble(),
                            unit: "%",
                            image: "humidity",
                          ),
                          WeatherItem(
                            value: _weatherModel!.current.cloud.toDouble(),
                            unit: "%",
                            image: "cloud",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
