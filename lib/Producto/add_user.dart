import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/Producto/api_handler.dart';
import 'package:flutter_web_api/Producto/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddUser extends StatefulWidget {
  const AddUser({Key? key}) : super(key: key);

  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();

  void addUser() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      final user = Producto(
        idProducto: 0, // No es necesario establecer manualmente el idCliente
        nombre: data['nombre'] as String,
        descripcion: data['descripcion'] as String, // Agregamos la dirección
        precio: int.parse(data['precio'] as String), // Convertimos el precio a entero
        status: 1, // Establecemos el status predeterminado como 1
      );

      final uri = Uri.parse(
          "https://10.0.2.2:7267/api/Producto/CrearProduto/Create?"
              "nombre=${Uri.encodeComponent(user.nombre)}&"
              "descripcion=${Uri.encodeComponent(user.descripcion)}&"
              "precio=${Uri.encodeComponent(user.precio.toString())}&"
              "status=${user.status == 1 ? 'true' : 'false'}"
      );

      await apiHandler.addUser(user: user);
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Agregar"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: addUser,
        child: const Text('Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'nombre',
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'descripcion',
                decoration: const InputDecoration(labelText: 'Descripcion'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'precio',
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                  FormBuilderValidators.numeric(), // Validar que sea un número
                ]),
                keyboardType: TextInputType.number, // Establecer teclado numérico
              ),
            ],
          ),
        ),
      ),
    );
  }
}
