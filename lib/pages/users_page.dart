import 'package:flutter/material.dart';
import 'package:weatherappg15/models/user_model.dart';
import 'package:weatherappg15/services/user_mockapi_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  List<UserModel> userList = [];
  UserMockapiService userMockapiService = UserMockapiService();

  Future<void> getUsers() async {
    userList = await userMockapiService.getUsers();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          UserModel _nuevoUsuario = UserModel(
            createdAt: DateTime.now(),
            name: "Benito",
            avatar:
                "https://images.pexels.com/photos/17340271/pexels-photo-17340271.jpeg",
          );

          await userMockapiService.createUser(_nuevoUsuario);
          await getUsers();

          setState(() {});
        },
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ListTile(
              title: Text(userList[index].name),
              subtitle: Text(userList[index].createdAt.toString()),
              leading: Image.network(
                userList[index].avatar,
                fit: BoxFit.cover,
                width: 50,
                height: 50,
              ),

              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      UserModel userUpdated = UserModel(
                        createdAt: DateTime.now(),
                        name: "Ximena Juarez",
                        avatar:
                            "https://images.pexels.com/photos/19338521/pexels-photo-19338521.jpeg",
                        id: userList[index].id,
                      );
                      await userMockapiService.updateUser(userUpdated);
                      await getUsers();
                      setState(() {});
                    },
                    icon: Icon(Icons.edit),
                  ),

                  IconButton(
                    onPressed: () async {
                      await userMockapiService.deleteUser(
                        userList[index].id.toString(),
                      );

                      await getUsers();
                      setState(() {});
                    },
                    icon: Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
