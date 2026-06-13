import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WeatherItem extends StatelessWidget {
  double value;
  String unit;
  String image;
  WeatherItem({
    super.key,
    required this.value,
    required this.unit,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/icons/$image.png", height: 50),
        SizedBox(height: 8),
        Text(
          "${value.toStringAsFixed(0)} $unit",
          style: TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
