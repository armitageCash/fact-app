class User {
  final int idusuario; // int NOT NULL AUTO_INCREMENT
  final String usuario; // varchar(20) NOT NULL
  final String password; // varchar(20) NOT NULL
  final int? tipo; // int DEFAULT NULL
  final String? nombre; // varchar(100) DEFAULT NULL
  final String? cargo; // varchar(30) DEFAULT NULL
  final String? departamento; // varchar(20) DEFAULT NULL
  final int? idprefijoevento; // int DEFAULT NULL
  final int idprefijoevtacuse; // int NOT NULL
  final int grupo; // int NOT NULL

  User({
    required this.idusuario,
    required this.usuario,
    required this.password,
    this.tipo,
    this.nombre,
    this.cargo,
    this.departamento,
    this.idprefijoevento,
    required this.idprefijoevtacuse,
    required this.grupo,
  });

  // Factory constructor para crear una instancia desde un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idusuario: json['Idusuario'] as int,
      usuario: json['Usuario'] as String,
      password: json['Password'] as String,
      tipo: json['Tipo'] != null ? json['Tipo'] as int : null,
      nombre: json['Nombre'] != null ? json['Nombre'] as String : null,
      cargo: json['Cargo'] != null ? json['Cargo'] as String : null,
      departamento:
          json['Departamento'] != null ? json['Departamento'] as String : null,
      idprefijoevento: json['Idprefijoevento'] != null
          ? json['Idprefijoevento'] as int
          : null,
      idprefijoevtacuse: json['Idprefijoevtacuse'] as int,
      grupo: json['Grupo'] as int,
    );
  }

  // Método para convertir la clase a un JSON (opcional si necesitas convertirlo de vuelta)
  Map<String, dynamic> toJson() {
    return {
      'Idusuario': idusuario,
      'Usuario': usuario,
      'Password': password,
      'Tipo': tipo,
      'Nombre': nombre,
      'Cargo': cargo,
      'Departamento': departamento,
      'Idprefijoevento': idprefijoevento,
      'Idprefijoevtacuse': idprefijoevtacuse,
      'Grupo': grupo,
    };
  }
}
