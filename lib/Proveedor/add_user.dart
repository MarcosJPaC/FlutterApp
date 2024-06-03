import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/Venta/api_handler.dart';
import 'package:flutter_web_api/Venta/model.dart';
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

      final user = Venta(
        idVenta: 0, // No es necesario establecer manualmente el idCliente
        fecha: data['fecha'],
        total: int.parse(data['total']),
        status: 1, // Establecemos el status predeterminado como 1
      );

      final uri = Uri.parse(
          "https://10.0.2.2:7267/api/Producto/CrearProduto/Create?"
              "nombre=${Uri.encodeComponent(user.fecha)}&"
              "descripcion=${Uri.encodeComponent(user.total.toString())}&"
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
                name: 'fecha',
                decoration: const InputDecoration(labelText: 'Fecha'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(
                height: 10,
              ),

              FormBuilderTextField(
                name: 'total',
                decoration: const InputDecoration(labelText: 'Total'),
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
