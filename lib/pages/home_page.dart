import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherappg15/models/user_model.dart';
import 'package:weatherappg15/services/user_mockapi_service.dart';
import 'package:weatherappg15/widgets/search_city_widget.dart';

class HomePage extends StatelessWidget {
  TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(onPressed: () async {}),
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
        ],
      ),
    );
  }
}
