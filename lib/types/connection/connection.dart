class Connection {
  final int id;
  final String conTipo;
  final String conNitempresa;
  final String conPrefijo;
  final int conFacpendientes;
  final String ultimaconexion;

  Connection({
    required this.id,
    required this.conTipo,
    required this.conNitempresa,
    required this.conPrefijo,
    required this.conFacpendientes,
    required this.ultimaconexion,
  });

  // Factory constructor to create an instance from JSON
  factory Connection.fromJson(Map<String, dynamic> json) {
    return Connection(
      id: json['Id'],
      conTipo: json['con_Tipo'],
      conNitempresa: json['con_Nitempresa'],
      conPrefijo: json['con_Prefijo'],
      conFacpendientes: json['con_Facpendientes'],
      ultimaconexion: json['Ultimaconexion'],
    );
  }

  // Method to convert an instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'con_Tipo': conTipo,
      'con_Nitempresa': conNitempresa,
      'con_Prefijo': conPrefijo,
      'con_Facpendientes': conFacpendientes,
      'Ultimaconexion': ultimaconexion,
    };
  }

  static List<Connection> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Connection.fromJson(json)).toList();
  }
}
