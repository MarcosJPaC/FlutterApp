import 'package:flutter/material.dart';
import 'package:flutter_web_api/Empleado/add_user.dart';
import 'package:flutter_web_api/Empleado/api_handler.dart';
import 'package:flutter_web_api/Empleado/edit_page.dart';
import 'package:flutter_web_api/Empleado/find_user.dart';
import 'package:flutter_web_api/Empleado/model.dart';

class MainPageEmpleado extends StatefulWidget {
  const MainPageEmpleado({Key? key}) : super(key: key);

  @override
  State<MainPageEmpleado> createState() => _MainPageEmpleadoState();
}

class _MainPageEmpleadoState extends State<MainPageEmpleado> {
  ApiHandler apiHandler = ApiHandler();
  late List<Empleado> data = [];

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
        title: const Text("Registro de Empleados"),
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
                    "${data[index].idEmpleado}",
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  title: Text(
                    data[index].nombre,
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  subtitle: Text(
                    data[index].puesto,
                    style: const TextStyle(color: Colors.white), // Color de texto blanco
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline),
                    onPressed: () {
                      deleteUser(data[index].idEmpleado);
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
