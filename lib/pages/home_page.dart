import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherappg15/models/user_model.dart';
import 'package:weatherappg15/services/api_weather_service.dart';
import 'package:weatherappg15/services/user_mockapi_service.dart';
import 'package:weatherappg15/widgets/search_city_widget.dart';
import 'package:weatherappg15/widgets/weather_item.dart';

class HomePage extends StatelessWidget {
  TextEditingController _cityController = TextEditingController();

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
          IconButton(onPressed: () {}, icon: Icon(Icons.location_on_outlined)),
        ],
      ),
      body: ListView(
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
                  "Lima, Perú",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                SizedBox(height: 32),
                Image.asset("assets/icons/heavycloudy.png", height: 100),
                Text(
                  "23.9 °",
                  style: TextStyle(color: Colors.white, fontSize: 100),
                ),
                Divider(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WeatherItem(value: 18, unit: "km/h", image: "windspeed"),
                    WeatherItem(value: 70, unit: "%", image: "humidity"),
                    WeatherItem(value: 58, unit: "%", image: "cloud"),
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
