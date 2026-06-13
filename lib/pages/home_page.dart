import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherappg15/services/user_mockapi_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          UserMockapiService().getUsers();
        },
      ),
    );
  }
}
