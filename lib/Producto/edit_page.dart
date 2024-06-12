import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/Producto/api_handler.dart';
import 'package:flutter_web_api/Producto/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final Producto user;
  const EditPage({Key? key, required this.user}) : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();
  late http.Response response;

  void updateData() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      final user = Producto(
        idProducto: widget.user.idProducto,
        nombre: data['nombre'],
        descripcion: data['descripcion'],
        precio: double.parse(data['precio']),
        status: widget.user.status, // Mantener el estado original del producto
      );

      response = await apiHandler.updateUser(
        userId: widget.user.idProducto,
        user: user,
      );
    }

    if (!mounted) return;
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar Producto"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white, // Cambia el color de fondo a blanco

      bottomNavigationBar: MaterialButton(
        color: Colors.teal,
        textColor: Colors.white,
        padding: const EdgeInsets.all(20),
        onPressed: updateData,
        child: const Text('Actualizar'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: FormBuilder(
          key: _formKey,
          initialValue: {
            'nombre': widget.user.nombre,
            'descripcion': widget.user.descripcion,
            'precio': widget.user.precio.toString(),
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'nombre',
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'descripcion',
                decoration: const InputDecoration(labelText: 'Descripcion'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'precio',
                decoration: const InputDecoration(labelText: 'Precio'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(), // Validador numérico
                  FormBuilderValidators.maxLength(10), // Máximo 10 caracteres
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
