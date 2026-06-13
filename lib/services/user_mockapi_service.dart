import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weatherappg15/models/user_model.dart';

class UserMockapiService {
  final String baseUrl = "https://68cedf266dc3f35077803c79.mockapi.io/api/v1/";

  // GET
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(Uri.parse("$baseUrl/users"));
    print("-------------------------");
    print(response);
    print(response.statusCode);
    print(response.body);
    print("-------------------------");

    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data = jsonDecode(response.body);
      return data.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception("ERROR AL CARGAR LOS USUARIOS");
    }
  }
}
