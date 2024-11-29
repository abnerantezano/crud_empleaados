

class EmpleadoFields {
  static const List<String> values = [
    id,
    nombre,
    dni,
    salario,
    fechaIngreso,
    imagenPerfil,
  ];

  // Definiciones de los campos
  static const String id = '_id';
  static const String idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';

  static const String nombre = 'nombre';
  static const String nombreType = 'TEXT NOT NULL';

  static const String dni = 'dni';
  static const String dniType = 'TEXT NOT NULL';

  static const String salario = 'salario';
  static const String salarioType = 'REAL NOT NULL';

  static const String fechaIngreso = 'fechaIngreso';
  static const String fechaIngresoType = 'TEXT NOT NULL';

  static const String imagenPerfil = 'imagenPerfil';
  static const String imagenPerfilType = 'TEXT';
}

class EmpleadoModel {
  int? id;
  String nombre;
  String dni;
  double salario;
  String fechaIngreso;
  String? imagenPerfil;

  // Constructor
  EmpleadoModel({
    this.id,
    required this.nombre,
    required this.dni,
    required this.salario,
    required this.fechaIngreso,
    this.imagenPerfil,
  });

  // Método para convertir el modelo a JSON (mapa)
  Map<String, Object?> toJson() => {
        EmpleadoFields.id: id,
        EmpleadoFields.nombre: nombre,
        EmpleadoFields.dni: dni,
        EmpleadoFields.salario: salario,
        EmpleadoFields.fechaIngreso: fechaIngreso,
        EmpleadoFields.imagenPerfil: imagenPerfil,
      };

  // Método para crear una instancia de EmpleadoModel desde JSON (mapa)
  factory EmpleadoModel.fromJson(Map<String, Object?> json) => EmpleadoModel(
        id: json[EmpleadoFields.id] as int?,
        nombre: json[EmpleadoFields.nombre] as String,
        dni: json[EmpleadoFields.dni] as String,
        salario: json[EmpleadoFields.salario] as double,
        fechaIngreso: json[EmpleadoFields.fechaIngreso] as String,
        imagenPerfil: json[EmpleadoFields.imagenPerfil] as String?,
      );

  // Método para copiar y actualizar valores del modelo
  EmpleadoModel copy({
    int? id,
    String? nombre,
    String? dni,
    double? salario,
    String? fechaIngreso,
    String? imagenPerfil,
  }) =>
      EmpleadoModel(
        id: id ?? this.id,
        nombre: nombre ?? this.nombre,
        dni: dni ?? this.dni,
        salario: salario ?? this.salario,
        fechaIngreso: fechaIngreso ?? this.fechaIngreso,
        imagenPerfil: imagenPerfil ?? this.imagenPerfil,
      );
}
