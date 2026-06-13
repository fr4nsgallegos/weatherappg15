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
      List data = jsonDecode(response.body);
      return data.map((user) => UserModel.fromJson(user)).toList();
    } else {
      throw Exception("ERROR AL CARGAR LOS USUARIOS");
    }
  }

  // POST
  Future<UserModel> createUser(UserModel user) async {
    final response = await http.post(
      Uri.parse("$baseUrl/users"),
      body: jsonEncode(user.toJson()),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 201) {
      print(response.body);
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception();
    }
  }

  // PUT
  Future<UserModel?> updateUser(UserModel user) async {
    final response = await http.put(
      Uri.parse("$baseUrl/users/${user.id}"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(user.toJson()),
    );

    try {
      if (response.statusCode == 200) {
        return UserModel.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("error: $e");
    }
  }
}
