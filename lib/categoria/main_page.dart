import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_web_api/categoria/add_user.dart';
import 'package:flutter_web_api/categoria/api_handler.dart';
import 'package:flutter_web_api/categoria/edit_page.dart';
import 'package:flutter_web_api/categoria/find_user.dart';
import 'package:flutter_web_api/categoria/model.dart';

class MainPageCategoria extends StatefulWidget {
  const MainPageCategoria({Key? key}) : super(key: key);

  @override
  State<MainPageCategoria> createState() => _MainPageState();
}

class _MainPageState extends State<MainPageCategoria> {
  ApiHandler apiHandler = ApiHandler();
  late List<Categoria> data = [];

  void getData() async {
    data = await apiHandler.getUserData();
    setState(() {});
  }

  void deleteUser(int userId) async {
    await apiHandler.deleteUser(userId: userId);
    getData();
  }

  void confirmDeleteUser(int userId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this category?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                deleteUser(userId);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Categorias"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[900], // Cambia el color de fondo a gris oscuro
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: getData,
        child: const Text('Refresh'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 1,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: ((context) => const FindUser()),
                ),
              );
            },
            child: const Icon(Icons.search),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            heroTag: 2,
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddUserCategoria()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditPage(user: data[index]),
                      ),
                    );
                  },
                  leading: Text(
                    "${data[index].idCategoria}",
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  title: Text(
                    data[index].nombre,
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  subtitle: Text(
                    data[index].descripcion,
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      confirmDeleteUser(data[index].idCategoria);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
