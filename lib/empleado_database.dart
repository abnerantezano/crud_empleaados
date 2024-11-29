import 'empleado.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class EmpleadoDatabase {
  static final EmpleadoDatabase instance = EmpleadoDatabase._internal();
  static Database? _database;

  EmpleadoDatabase._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  // Inicializa la base de datos
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'empleados.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Crea la tabla empleados
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${EmpleadoFields.values.join(",")}
      (${EmpleadoFields.id} ${EmpleadoFields.idType},
      ${EmpleadoFields.nombre} ${EmpleadoFields.nombreType},
      ${EmpleadoFields.dni} ${EmpleadoFields.dniType},
      ${EmpleadoFields.salario} ${EmpleadoFields.salarioType},
      ${EmpleadoFields.fechaIngreso} ${EmpleadoFields.fechaIngresoType},
      ${EmpleadoFields.imagenPerfil} ${EmpleadoFields.imagenPerfilType}
      )
    ''');
  }

  // Insertar empleado
  Future<int> insertEmpleado(EmpleadoModel empleado) async {
    final db = await instance.database;
    return await db.insert('empleados', empleado.toJson());
  }

  // Obtener todos los empleados
  Future<List<EmpleadoModel>> getEmpleados() async {
    final db = await instance.database;
    final result = await db.query('empleados');

    return result.map((json) => EmpleadoModel.fromJson(json)).toList();
  }

  // Actualizar empleado
  Future<int> updateEmpleado(EmpleadoModel empleado) async {
    final db = await instance.database;
    return await db.update(
      'empleados',
      empleado.toJson(),
      where: '${EmpleadoFields.id} = ?',
      whereArgs: [empleado.id],
    );
  }

  // Eliminar empleado por ID
  Future<int> deleteEmpleado(int id) async {
    final db = await instance.database;
    return await db.delete(
      'empleados',
      where: '${EmpleadoFields.id} = ?',
      whereArgs: [id],
    );
  }
}
