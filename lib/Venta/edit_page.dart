import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_web_api/Venta/api_handler.dart';
import 'package:flutter_web_api/Venta/model.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:http/http.dart' as http;

class EditPage extends StatefulWidget {
  final Venta user;
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

      final user = Venta(
        idVenta: widget.user.idVenta,
        fecha: data['fecha'],
        total: int.parse(data['total']),  // Convertir a cadena
        status: data['status'] == true ? 1 : 0,  // Convertir a 1 si está seleccionado, de lo contrario a 0
      );

      response = await apiHandler.updateUser(
        userId: widget.user.idVenta,
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
        title: const Text("Editar Venta"),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.grey[900],  // Cambia el color de fondo a gris oscuro

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
            'fecha': widget.user.fecha,
            'total': widget.user.total.toString(),  // Asegúrate de que sea una cadena
            'status': widget.user.status == 1,  // Convertir a booleano
          },
          child: Column(
            children: [
              FormBuilderTextField(
                name: 'fecha',
                decoration: const InputDecoration(labelText: 'Fecha'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderTextField(
                name: 'total',
                decoration: const InputDecoration(labelText: 'Total'),
                validator: FormBuilderValidators.compose([
                  FormBuilderValidators.required(),
                ]),
              ),
              const SizedBox(height: 10),
              FormBuilderCheckbox(
                name: 'status',
                title: const Text('Activo'),
                initialValue: widget.user.status == 1,  // Convertir a booleano
              ),
            ],
          ),
        ),
      ),
    );
  }
}
