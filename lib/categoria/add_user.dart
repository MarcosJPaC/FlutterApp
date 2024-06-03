import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/categoria/api_handler.dart';
import 'package:flutter_web_api/categoria/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddUserCategoria extends StatefulWidget {
  const AddUserCategoria({Key? key}) : super(key: key);

  @override
  State<AddUserCategoria> createState() => _AddUserCategoriaState();
}

class _AddUserCategoriaState extends State<AddUserCategoria> {
  final _formKey = GlobalKey<FormBuilderState>();
  ApiHandler apiHandler = ApiHandler();

  void addUser() async {
    if (_formKey.currentState!.saveAndValidate()) {
      final data = _formKey.currentState!.value;

      final user = Categoria(
        idCategoria: 0, // No es necesario establecer manualmente el idCliente
        nombre: data['nombre'],
        descripcion: data['direccion'], // Agregamos la dirección
        estado: data['telefono'], // Agregamos el teléfono
        status: 1, // Establecemos el status predeterminado como 1
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
      backgroundColor: Colors.grey[900], // Cambia el color de fondo a gris oscuro
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
                style: const TextStyle(color: Colors.white), // Color del texto
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.white), // Color del texto del label
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Borde cuando está habilitado
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal), // Borde cuando está enfocado
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'direccion',
                style: const TextStyle(color: Colors.white), // Color del texto
                decoration: const InputDecoration(
                  labelText: 'Descripcion',
                  labelStyle: TextStyle(color: Colors.white), // Color del texto del label
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Borde cuando está habilitado
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal), // Borde cuando está enfocado
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),
              FormBuilderTextField(
                name: 'telefono',
                style: const TextStyle(color: Colors.white), // Color del texto
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  labelStyle: TextStyle(color: Colors.white), // Color del texto del label
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white), // Borde cuando está habilitado
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.teal), // Borde cuando está enfocado
                  ),
                ),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
