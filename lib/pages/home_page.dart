import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weatherappg15/models/user_model.dart';
import 'package:weatherappg15/services/user_mockapi_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          UserModel userModelExample = UserModel(
            createdAt: DateTime.now(),
            name: "María Fernandez",
            avatar:
                "https://images.pexels.com/photos/18092083/pexels-photo-18092083.jpeg",
            id: "26",
          );
          await UserMockapiService().updateUser(userModelExample);

          // await UserMockapiService().createUser(userModelExample);

          List<UserModel> usuarios = await UserMockapiService().getUsers();
          usuarios.forEach((usuario) {
            print(usuario.name);
          });
        },
      ),
    );
  }
}
