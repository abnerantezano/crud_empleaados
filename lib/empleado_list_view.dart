import 'package:flutter/material.dart';
import 'empleado_form_view.dart'; // Vista del formulario de empleado
import 'empleado_database.dart';
import 'empleado.dart';

class EmpleadoListView extends StatefulWidget {
  @override
  _EmpleadoListViewState createState() => _EmpleadoListViewState();
}

class _EmpleadoListViewState extends State<EmpleadoListView> {
  late Future<List<EmpleadoModel>> _empleados;

  @override
  void initState() {
    super.initState();
    _refreshEmpleados();
  }

  void _refreshEmpleados() {
    _empleados = EmpleadoDatabase.instance.getEmpleados();
  }

  Future<void> _addOrUpdateEmpleado({EmpleadoModel? empleado}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => EmpleadoFormView(empleado: empleado),
      ),
    );
    if (result == true) {
      setState(() => _refreshEmpleados());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gestión de Empleados', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: FutureBuilder<List<EmpleadoModel>>(
        future: _empleados,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No hay empleados registrados',
                style: TextStyle(color: Colors.black54, fontSize: 18),
              ),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final empleado = snapshot.data![index];
              return Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(empleado.nombre, style: TextStyle(color: Colors.black)),
                  subtitle: Text('DNI: ${empleado.dni}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => _addOrUpdateEmpleado(empleado: empleado),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () async {
                          await EmpleadoDatabase.instance.deleteEmpleado(empleado.id!);
                          setState(() => _refreshEmpleados());
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => _addOrUpdateEmpleado(),
      ),
    );
  }
}
