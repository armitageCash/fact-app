class Company {
  final int nit;
  final String razonsocial;
  final String direccion;
  final String pais;
  final String departamento;
  final String ciudad;
  final String telefono;
  final String tipoPersona; // "PERSONA_NATURAL" | "PERSONA_JURIDICA"
  final String regFiscal; // "NO_APLICA" | "APLICA"
  final String respFiscal; // "RESPONSABLE" | "NO_RESPONSABLE"
  final String respTributaria; // "APLICA" | "NO_APLICA"
  final String email;
  final String nombreCertificado;
  final String pwdCertificado;
  final int filecons;
  final int replay;
  final int activate;
  final int id;
  final int nitempresa;
  final int idusuario;
  final int idalmacen;

  Company({
    required this.nit,
    required this.razonsocial,
    required this.direccion,
    required this.pais,
    required this.departamento,
    required this.ciudad,
    required this.telefono,
    required this.tipoPersona,
    required this.regFiscal,
    required this.respFiscal,
    required this.respTributaria,
    required this.email,
    required this.nombreCertificado,
    required this.pwdCertificado,
    required this.filecons,
    required this.replay,
    required this.activate,
    required this.id,
    required this.nitempresa,
    required this.idusuario,
    required this.idalmacen,
  });

  // Factory constructor to create a new Company from a JSON object
  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      nit: json['Nit'],
      razonsocial: json['Razonsocial'],
      direccion: json['Direccion'],
      pais: json['Pais'],
      departamento: json['Departamento'],
      ciudad: json['Ciudad'],
      telefono: json['Telefono'],
      tipoPersona: json['TipoPersona'], // Assuming it's already a string
      regFiscal: json['RegFiscal'], // Assuming it's already a string
      respFiscal: json['RespFiscal'], // Assuming it's already a string
      respTributaria: json['RespTributaria'], // Assuming it's already a string
      email: json['Email'],
      nombreCertificado: json['NombreCertificado'],
      pwdCertificado: json['PwdCertificado'],
      filecons: json['Filecons'],
      replay: json['Replay'],
      activate: json['Activate'],
      id: json['id'],
      nitempresa: json['Nitempresa'],
      idusuario: json['Idusuario'],
      idalmacen: json['Idalmacen'],
    );
  }

  // Method to convert an instance of Company to JSON
  Map<String, dynamic> toJson() {
    return {
      'Nit': nit,
      'Razonsocial': razonsocial,
      'Direccion': direccion,
      'Pais': pais,
      'Departamento': departamento,
      'Ciudad': ciudad,
      'Telefono': telefono,
      'TipoPersona': tipoPersona,
      'RegFiscal': regFiscal,
      'RespFiscal': respFiscal,
      'RespTributaria': respTributaria,
      'Email': email,
      'NombreCertificado': nombreCertificado,
      'PwdCertificado': pwdCertificado,
      'Filecons': filecons,
      'Replay': replay,
      'Activate': activate,
      'id': id,
      'Nitempresa': nitempresa,
      'Idusuario': idusuario,
      'Idalmacen': idalmacen,
    };
  }

  static List<Company> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => Company.fromJson(json)).toList();
  }
}
