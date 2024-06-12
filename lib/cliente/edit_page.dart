import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/cliente/api_handler.dart';
import 'package:flutter_web_api/cliente/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final Empleado user;
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

      final user = Empleado(
        idCliente: widget.user.idCliente,
        nombre: data['nombre'],
        direccion: data['direccion'],
        telefono: data['telefono'],
        status: widget.user.status, // Mantener el estado actual
      );

      response = await apiHandler.updateUser(
        userId: widget.user.idCliente,
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
        title: const Text("Editar Cliente"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
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
            'direccion': widget.user.direccion,
            'telefono': widget.user.telefono,
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
                name: 'direccion',
                decoration: const InputDecoration(labelText: 'Direccion'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'telefono',
                decoration: const InputDecoration(labelText: 'Telefono'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.numeric(),
                  FormBuilderValidators.maxLength(10),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
