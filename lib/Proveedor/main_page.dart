import 'package:flutter/material.dart';
import 'package:flutter_web_api/Proveedor/add_user.dart';
import 'package:flutter_web_api/Proveedor/api_handler.dart';
import 'package:flutter_web_api/Proveedor/edit_page.dart';
import 'package:flutter_web_api/Proveedor/find_user.dart';
import 'package:flutter_web_api/Proveedor/model.dart';

class MainPageProveedor extends StatefulWidget {
  const MainPageProveedor({Key? key}) : super(key: key);

  @override
  State<MainPageProveedor> createState() => _MainPageProveedorState();
}

class _MainPageProveedorState extends State<MainPageProveedor> {
  ApiHandler apiHandler = ApiHandler();
  late List<Proveedor> data = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    try {
      final newData = await apiHandler.getUserData();
      setState(() {
        data = newData;
      });
      print('Data loaded successfully: $data');
    } catch (e) {
      print('Error getting data: $e');
    }
  }

  void deleteUser(int userId) async {
    try {
      await apiHandler.deleteUser(userId: userId);
      getData();
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registro de Proveedores"),
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
                    builder: (context) => const AddUser()),
              );
            },
            child: const Icon(Icons.add),
          ),
        ],
      ),
      body: data.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
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
              "${data[index].idProveedor}",
              style: const TextStyle(color: Colors.white), // Color de texto blanco
            ),
            title: Text(
              data[index].nombre,
              style: const TextStyle(color: Colors.white), // Color de texto blanco
            ),
            subtitle: Text(
              data[index].direccion.toString(),
              style: const TextStyle(color: Colors.white), // Color de texto blanco
            ),
            trailing: IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: () {
                deleteUser(data[index].idProveedor);
              },
            ),
          );
        },
      ),
    );
  }
}
