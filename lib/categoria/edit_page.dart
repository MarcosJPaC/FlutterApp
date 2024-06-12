import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/categoria/api_handler.dart';
import 'package:flutter_web_api/categoria/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final Categoria user;
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

      final user = Categoria(
        idCategoria: widget.user.idCategoria,
        nombre: data['nombre'],
        descripcion: data['descripcion'],
        estado: data['estado'],
        status: widget.user.status, // Mantener el valor original del estado
      );

      response = await apiHandler.updateUser(
        userId: widget.user.idCategoria,
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
        title: const Text("Editar Categoria"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[900], // Cambia el color de fondo a gris oscuro

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
            'estado': widget.user.estado,
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'nombre',
                decoration: InputDecoration(
                  labelText: 'Nombre',
                  labelStyle: TextStyle(color: Colors.white), // Color del texto de la etiqueta
                ),
                style: TextStyle(color: Colors.white), // Color del texto del campo de texto
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'descripcion',
                decoration: InputDecoration(
                  labelText: 'Descripcion',
                  labelStyle: TextStyle(color: Colors.white), // Color del texto de la etiqueta
                ),
                style: TextStyle(color: Colors.white), // Color del texto del campo de texto
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'estado',
                decoration: InputDecoration(
                  labelText: 'Estado',
                  labelStyle: TextStyle(color: Colors.white), // Color del texto de la etiqueta
                ),
                style: TextStyle(color: Colors.white), // Color del texto del campo de texto
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
