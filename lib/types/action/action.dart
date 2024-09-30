class ActionCompany {
  final int id;
  final int insArqueos;
  final int ejeAccion;
  final String accion;
  final int compVentas;
  final String prefijoCaja;
  final String nitEmpresa;
  final String usuario;
  final int accion1;
  final int accion2;
  final int accion3;
  final int tope;
  final int transaccionesPen;
  final String almacen;
  final int estado;
  final String fecha1;
  final String fecha2;
  final int auditar;

  ActionCompany({
    required this.id,
    required this.insArqueos,
    required this.ejeAccion,
    required this.accion,
    required this.compVentas,
    required this.prefijoCaja,
    required this.nitEmpresa,
    required this.usuario,
    required this.accion1,
    required this.accion2,
    required this.accion3,
    required this.tope,
    required this.transaccionesPen,
    required this.almacen,
    required this.estado,
    required this.fecha1,
    required this.fecha2,
    required this.auditar,
  });

  // Fábrica para deserializar desde JSON
  factory ActionCompany.fromJson(Map<String, dynamic> json) {
    return ActionCompany(
      id: json['ID'] ?? 0,
      insArqueos: json['Ins_arqueos'] ?? 0,
      ejeAccion: json['Eje_accion'] ?? 0,
      accion: json['Accion'] ?? '-',
      compVentas: json['Comp_ventas'] ?? 0,
      prefijoCaja: json['Prefijo_caja'] ?? '',
      nitEmpresa: json['Nitempresa'] ?? '',
      usuario: json['Usuario'] ?? '',
      accion1: int.parse(json['Accion1']) ?? 0,
      accion2: int.parse(json['Accion2']) ?? 0,
      accion3: int.parse(json['Accion3']) ?? 0,
      tope: json['Tope'] ?? 0,
      transaccionesPen: json['Transaccionespen'] ?? 0,
      almacen: json['Almacen'] ?? '',
      estado: json['Estado'] ?? 0,
      fecha1: json['Fecha1'] ?? '',
      fecha2: json['Fecha2'] ?? '',
      auditar: json['Auditar'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Ins_arqueos': insArqueos,
      'Eje_accion': ejeAccion,
      'Accion': accion,
      'Comp_ventas': compVentas,
      'Prefijo_caja': prefijoCaja,
      'Nitempresa': nitEmpresa,
      'Usuario': usuario,
      'Accion1': accion1.toString(),
      'Accion2': accion2.toString(),
      'Accion3': accion3.toString(),
      'Tope': tope,
      'Transaccionespen': transaccionesPen,
      'Almacen': almacen,
      'Estado': estado,
      'Fecha1': fecha1,
      'Fecha2': fecha2,
      'Auditar': auditar,
    };
  }

  static List<ActionCompany> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => ActionCompany.fromJson(json)).toList();
  }
}
