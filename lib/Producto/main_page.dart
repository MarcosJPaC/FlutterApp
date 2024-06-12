import 'package:flutter/material.dart';
import 'package:flutter_web_api/Producto/add_user.dart';
import 'package:flutter_web_api/Producto/api_handler.dart';
import 'package:flutter_web_api/Producto/edit_page.dart';
import 'package:flutter_web_api/Producto/find_user.dart';
import 'package:flutter_web_api/Producto/model.dart';

class MainPageProducto extends StatefulWidget {
  const MainPageProducto({Key? key}) : super(key: key);

  @override
  State<MainPageProducto> createState() => _MainPageProductoState();
}

class _MainPageProductoState extends State<MainPageProducto> {
  ApiHandler apiHandler = ApiHandler();
  late List<Producto> data = [];

  void getData() async {
    data = await apiHandler.getUserData();
    setState(() {});
  }

  void deleteUser(int userId) async {
    await apiHandler.deleteUser(userId: userId);
    getData();
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
        title: const Text("Registro de Producto"),
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
                  builder: (context) => const AddUser(),
                ),
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
                    "${data[index].idProducto}",
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
                      deleteUser(data[index].idProducto);
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