import 'package:flutter/material.dart';
import 'empleado.dart';
import 'empleado_database.dart';

class EmpleadoFormView extends StatefulWidget {
  final EmpleadoModel? empleado;

  EmpleadoFormView({this.empleado});

  @override
  _EmpleadoFormViewState createState() => _EmpleadoFormViewState();
}

class _EmpleadoFormViewState extends State<EmpleadoFormView> {
  final _formKey = GlobalKey<FormState>();
  String _nombre = '';
  String _dni = '';
  double _salario = 0.0;

  @override
  void initState() {
    super.initState();
    if (widget.empleado != null) {
      _nombre = widget.empleado!.nombre;
      _dni = widget.empleado!.dni;
      _salario = widget.empleado!.salario;
    }
  }

  void _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final empleado = EmpleadoModel(
        id: widget.empleado?.id,
        nombre: _nombre,
        dni: _dni,
        salario: _salario,
        fechaIngreso: widget.empleado?.fechaIngreso ?? DateTime.now().toIso8601String(),
      );
      if (widget.empleado == null) {
        await EmpleadoDatabase.instance.insertEmpleado(empleado);
      } else {
        await EmpleadoDatabase.instance.updateEmpleado(empleado);
      }
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.empleado == null ? 'Agregar Empleado' : 'Editar Empleado'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _nombre,
                decoration: InputDecoration(labelText: 'Nombre', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Ingrese un nombre' : null,
                onSaved: (value) => _nombre = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _dni,
                decoration: InputDecoration(labelText: 'DNI', border: OutlineInputBorder()),
                validator: (value) => value!.isEmpty ? 'Ingrese un DNI' : null,
                onSaved: (value) => _dni = value!,
              ),
              SizedBox(height: 16),
              TextFormField(
                initialValue: _salario.toString(),
                decoration: InputDecoration(labelText: 'Salario', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Ingrese un salario' : null,
                onSaved: (value) => _salario = double.parse(value!),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(widget.empleado == null ? 'Agregar' : 'Actualizar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
