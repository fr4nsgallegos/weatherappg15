import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ForecastWidget extends StatelessWidget {
  String hour;
  String temp;
  int isDay;

  ForecastWidget({
    super.key,
    required this.hour,
    required this.temp,
    required this.isDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: 20,
      // height: 20,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        color: Color(0xff404446),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(color: Colors.black, blurRadius: 5, offset: Offset(4, 5)),
        ],
      ),

      child: Column(
        children: [
          Text(hour, style: TextStyle(color: Colors.white38, fontSize: 15)),
          Image.asset(
            "assets/icons/${isDay == 1 ? 'sunny' : 'overcast'}.png",
            width: 50,
            height: 50,
            fit: BoxFit.contain,
          ),
          Text("$temp°C", style: TextStyle(color: Colors.white, fontSize: 20)),
        ],
      ),
    );
  }
}
