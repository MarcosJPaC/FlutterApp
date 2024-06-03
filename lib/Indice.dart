import 'package:flutter/material.dart';
import 'package:flutter_web_api/Empleado/main_page.dart';
import 'package:flutter_web_api/Producto/main_page.dart';
import 'package:flutter_web_api/Proveedor/main_page.dart';
import 'package:flutter_web_api/Venta/main_page.dart';
import 'package:flutter_web_api/login_page.dart';
import 'package:flutter_web_api/Producto//find_user.dart';
import 'package:flutter_web_api/categoria/add_user.dart';
import 'package:flutter_web_api/categoria/main_page.dart';
import 'package:flutter_web_api/cliente/main_page.dart';
import 'package:flutter_web_api/operaciones.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu Principal"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://tse2.mm.bing.net/th/id/OIG3.Wyu5yfrkTZ_ZcPW0OR.e?pid=ImgGn',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(),
            ),

            ListTile(
              title: Text('Carrito de compras'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ShoppingCartPage()),
                );
              },
            ),
            ListTile(
              title: Text('Cliente'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPageCliente()),
                );
              },
            ),
            ListTile(
              title: Text('Empleado'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPageEmpleado()),
                );
              },
            ),
            ListTile(
              title: Text('Categoria'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPageCategoria()),
                );
              },
            ),
            ListTile(
              title: Text('Producto'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPageProducto()),
                );
              },
            ),
            ListTile(
              title: Text('Venta'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPageVenta()),
                );

              },
            ),
            ListTile(
              title: Text('Proveedor'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MainPageProveedor()),
                );
              },
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://d100mj7v0l85u5.cloudfront.net/s3fs-public/2023-04/funciones-del-jefe-de-compras-6.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Aplicacion elaborada por',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  '• Marcos Palomo\n• Brandon Lugo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40), // Ajusta esta altura según sea necesario
                Image.network(
                  'https://adventech-soluciones.com/wp-content/uploads/2019/05/android-logo-png-transparent.png',
                  height: 150, // Ajusta la altura de la imagen según sea necesario
                ),
                const SizedBox(height: 40), // Ajusta esta altura según sea necesario
                const Text(
                  'Apps Moviles',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const Text(
                  'Prof. Ruben Riojas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        blurRadius: 10.0,
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: MainMenu(),
  ));
}
