import 'package:flutter/material.dart';
import 'package:flutter_web_api/Proveedor/api_handler.dart';
import 'package:flutter_web_api/Proveedor/model.dart';
import 'package:flutter_web_api/operaciones.dart';

class FindUser extends StatefulWidget {
  const FindUser({Key? key}) : super(key: key);

  @override
  State<FindUser> createState() => _FindUserState();
}

class _FindUserState extends State<FindUser> {
  final ApiHandler apiHandler = ApiHandler();
  Proveedor user = Proveedor.empty();
  final TextEditingController textEditingController = TextEditingController();

  Future<void> findUser(int userId) async {
    Proveedor? foundUser = await apiHandler.getUserById(userId: userId);
    if (foundUser == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Usuario no encontrado'),
            content: Text('El usuario con ID $userId no se encontró.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      setState(() {
        user = foundUser;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find User"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[900],
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: () {
          findUser(int.parse(textEditingController.text));
        },
        child: const Text('Find'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
                hintText: 'Enter User ID',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              cursorColor: Colors.white,
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Text(
                "${user.idProveedor}",
                style: const TextStyle(color: Colors.white),
              ),
              title: Text(
                user.nombre,
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                user.telefono.toString(),
                style: const TextStyle(color: Colors.white70),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

