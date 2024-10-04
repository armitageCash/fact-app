import 'package:fact_app/components/buttons/button.dart';
import 'package:fact_app/components/spacing/spacing.dart';
import 'package:fact_app/components/textarea/textarea.dart';
import 'package:fact_app/components/textfield/textfield.dart';
import 'package:fact_app/controllers/connections/connectionsController.dart';
import 'package:fact_app/shared/providers/user.dart';
import 'package:fact_app/types/connection/connection.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectionDetails extends StatefulWidget {
  final String? connectionId;

  const ConnectionDetails({
    Key? key,
    required this.connectionId,
  }) : super(key: key);

  @override
  _ConnectionDetailsState createState() => _ConnectionDetailsState();
}

class _ConnectionDetailsState extends State<ConnectionDetails> {
  Connectionscontroller _connectionscontroller = Connectionscontroller();

  late Future<Connection?> conenctionFuture;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  // Campos que se inicializan desde el widget.connection
  String? _conTipo = '';
  String? _conNitempresa = '';
  String? _conPrefijo = '';
  int? _conFacpendientes = 0;
  String? _ultimaconexion = '';
  String? _log = '';

  // Text controllers
  TextEditingController _idController = TextEditingController();
  TextEditingController _conTipoController = TextEditingController();
  TextEditingController _conNitempresaController = TextEditingController();
  TextEditingController _conPrefijoController = TextEditingController();
  TextEditingController _conFacpendientesController = TextEditingController();
  TextEditingController _ultimaconexionController = TextEditingController();
  TextEditingController _logController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _conTipoController.text = _conTipo!;
    _conNitempresaController.text = _conNitempresa!;
    _conPrefijoController.text = _conPrefijo!;
    _conFacpendientesController.text = _conFacpendientes!.toString();
    _ultimaconexionController.text = _ultimaconexion!;
    _logController.text = _log!;

    conenctionFuture = fetchConnectionDetails(widget.connectionId!);
  }

  @override
  void dispose() {
    _idController.dispose();
    _conTipoController.dispose();
    _conNitempresaController.dispose();
    _conPrefijoController.dispose();
    _conFacpendientesController.dispose();
    _ultimaconexionController.dispose();
    _logController.dispose();
    super.dispose();
  }

  Future<Connection?> fetchConnectionDetails(String connectionId) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String? jwt = Provider.of<UserProvider>(context, listen: false).jwtToken;
    if (user != null && jwt != null) {
      Connection? connection = await _connectionscontroller.getConnection(
          connectionId, jwt, context);

      setState(() {
        _idController.text = connection!.id.toString();
        _conTipoController.text = connection!.conTipo;
        _conNitempresaController.text = connection.conNitempresa;
        _conPrefijoController.text = connection.conPrefijo;
        _conFacpendientesController.text =
            connection.conFacpendientes.toString();
        _ultimaconexionController.text = connection.ultimaconexion;
        _logController.text = connection.log ?? "";
      });

      return connection;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles de Conexión ${widget.connectionId}'),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomTextField(
                controller: _idController,
                labelText: 'ID',
                isEnabled: false,
              ),
              const Spacing(orientation: "horizontal", size: 20),
              CustomTextField(
                controller: _conTipoController,
                labelText: 'Tipo de Conexión',
                hintText: 'Ingresa el tipo de conexión',
                onChanged: (value) {
                  setState(() {
                    _conTipo = value;
                  });
                },
              ),
              const Spacing(orientation: "horizontal", size: 20),
              CustomTextField(
                controller: _conNitempresaController,
                isEnabled: false,
                labelText: 'NIT Empresa',
                hintText: 'Ingresa el NIT de la empresa',
                onChanged: (value) {
                  setState(() {
                    _conNitempresa = value;
                  });
                },
              ),
              const Spacing(orientation: "horizontal", size: 20),
              CustomTextField(
                controller: _conPrefijoController,
                isEnabled: false,
                labelText: 'Prefijo',
                hintText: 'Ingresa el prefijo de la empresa',
                onChanged: (value) {
                  setState(() {
                    _conPrefijo = value;
                  });
                },
              ),
              const Spacing(orientation: "horizontal", size: 20),
              CustomTextField(
                controller: _conFacpendientesController,
                labelText: 'Facturas Pendientes',
                hintText: 'Ingresa la cantidad de facturas pendientes',
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _conFacpendientes = int.tryParse(value) ?? 0;
                  });
                },
              ),
              const Spacing(orientation: "horizontal", size: 20),
              CustomTextField(
                controller: _ultimaconexionController,
                labelText: 'Última Conexión',
                hintText: 'Ingresa la última fecha de conexión',
              ),
              const Spacing(orientation: "horizontal", size: 20),
              CustomTextArea(
                hintText: 'Log de facturas',
                controller: _logController,
              ),
              const Spacing(orientation: "horizontal", size: 20),
              Button(
                label: 'Guardar',
                isEnabled: false,
                isLoading: _loading,
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      _loading = true;
                    });

                    // Lógica para actualizar la conexión (API u otra)
                    await Future.delayed(
                        Duration(seconds: 2)); // Simula una llamada a la API

                    setState(() {
                      _loading = false;
                    });
                    Navigator.of(context).pop(); // Cierra el formulario
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
