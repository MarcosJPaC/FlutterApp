import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product {
  final int idProducto;
  final String nombre;
  final String descripcion;
  final double precio; // Cambiado de int a double
  int quantity;

  Product({
    required this.idProducto,
    required this.nombre,
    required this.descripcion,
    required this.precio,
    this.quantity = 1,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      idProducto: json['idProducto'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: json['precio'].toDouble(), // Asegurarse de que precio sea un double
    );
  }
}

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({Key? key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Product> products = [];
  List<Product> cart = [];

  @override
  void initState() {
    super.initState();
    // Llamada a la función para obtener los productos desde el API
    fetchProducts().then((fetchedProducts) {
      setState(() {
        products = fetchedProducts;
      });
    });
  }

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('https://10.0.2.2:7267/api/Producto/GetTodasLasProducto'));
    if (response.statusCode == 200) {
      // Si la solicitud es exitosa, parsea la lista de productos
      List<dynamic> data = json.decode(response.body);
      List<Product> fetchedProducts = data.map((item) {
        return Product.fromJson(item);
      }).toList();
      return fetchedProducts;
    } else {
      // Si la solicitud falla, lanza una excepción
      throw Exception('Failed to load products');
    }
  }

  void addToCart(Product product) {
    setState(() {
      int index = cart.indexWhere((p) => p.idProducto == product.idProducto);
      if (index != -1) {
        cart[index].quantity++;
      } else {
        cart.add(product);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ListTile(
            title: Text(product.nombre),
            subtitle: Text('\$${product.precio.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.add_shopping_cart),
              onPressed: () {
                addToCart(product);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ShoppingCartScreen(cart: cart)),
          );
        },
        label: const Text('View Cart'),
        icon: const Icon(Icons.shopping_cart),
      ),
    );
  }
}

class ShoppingCartScreen extends StatelessWidget {
  final List<Product> cart;

  const ShoppingCartScreen({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = calculateTotal(cart);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          final product = cart[index];
          return ListTile(
            title: Text(product.nombre),
            subtitle: Text('\$${(product.precio * product.quantity).toStringAsFixed(2)}'),
            trailing: Text('Quantity: ${product.quantity}'),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Total: \$${total.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  double calculateTotal(List<Product> cart) {
    double total = 0;
    for (var product in cart) {
      total += product.precio * product.quantity;
    }
    return total;
  }
}

void main() {
  runApp(const MaterialApp(
    home: ShoppingCartPage(),
  ));
}
