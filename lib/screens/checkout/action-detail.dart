import 'package:fact_app/components/buttons/button.dart';
import 'package:fact_app/components/checkbox/checkbox.dart';
import 'package:fact_app/components/datepicker/datepicker.dart';
import 'package:fact_app/components/modal/modal.dart';
import 'package:fact_app/components/spacing/spacing.dart';
import 'package:fact_app/components/textfield/textfield.dart';
import 'package:fact_app/controllers/actions/actionsController.dart';
import 'package:fact_app/shared/providers/user.dart';
import 'package:fact_app/types/action/action.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ActionDetails extends StatefulWidget {
  final String? actionId;

  const ActionDetails({
    Key? key,
    required this.actionId,
  }) : super(key: key);

  @override
  _ActionDetailsState createState() => _ActionDetailsState();
}

class _ActionDetailsState extends State<ActionDetails> {
  late Future<ActionCompany?> actionFuture;
  Actionscontroller _actionscontroller = Actionscontroller();
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  // Text controllers
  TextEditingController _accionController = TextEditingController();
  TextEditingController _prefijoCajaController = TextEditingController();
  TextEditingController _nitEmpresaController = TextEditingController();
  TextEditingController _usuarioController = TextEditingController();
  TextEditingController _topeController = TextEditingController();
  TextEditingController _transaccionesPendientesController =
      TextEditingController();
  TextEditingController _almacenController = TextEditingController();
  //form values
  bool? insertarArqueos = false;
  DateTime? selectedDate;

  bool? ejecutarAccion;
  bool? compararVentas;
  bool? accion1;
  bool? accion2;
  bool? accion3;
  bool? estado;
  bool? auditar;

  String? accion;
  String? prefijoCaja;
  String? nitEmpresa;
  String? usuario;
  String? tope;
  String? almacen;
  String? transaccionesPendientes;
  DateTime? fecha1;
  DateTime? fecha2;

  @override
  void initState() {
    super.initState();
    actionFuture = fetchActionDetails(widget.actionId!);
  }

  @override
  void dispose() {
    // Asegúrate de liberar los controladores al salir
    _accionController.dispose();
    _prefijoCajaController.dispose();
    _nitEmpresaController.dispose();
    _usuarioController.dispose();
    _topeController.dispose();
    _transaccionesPendientesController.dispose();
    _almacenController.dispose();
    super.dispose();
  }

  Future<ActionCompany?> fetchActionDetails(String actionId) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String? jwt = Provider.of<UserProvider>(context, listen: false).jwtToken;
    if (user != null && jwt != null) {
      ActionCompany? action =
          await _actionscontroller.getAction(actionId, jwt, context);

      setState(() {
        _accionController.text = action?.accion ?? "";
        _prefijoCajaController.text = action?.prefijoCaja ?? "";
        _nitEmpresaController.text = action?.nitEmpresa ?? "";
        _usuarioController.text = action?.usuario ?? "";
        _topeController.text = action?.tope.toString() ?? "";
        _transaccionesPendientesController.text =
            action?.transaccionesPen.toString() ?? "";
        _almacenController.text = action?.almacen ?? "";
        insertarArqueos = action!.insArqueos == 1 ? true : false;
        ejecutarAccion = action!.ejeAccion == 1 ? true : false;
        compararVentas = action.compVentas == 1 ? true : false;
        accion1 = action.accion1 == 1 ? true : false;
        accion2 = action.accion2 == 1 ? true : false;
        accion3 = action.accion3 == 1 ? true : false;
        estado = action.estado == 1 ? true : false;
        auditar = action.auditar == 1 ? true : false;
        fecha1 = DateTime.parse(action.fecha1);
        fecha2 = DateTime.parse(action.fecha2);
      });

      return action;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            child: const Icon(Icons.arrow_back),
            onTap: () {
              if (context.canPop()) {
                context.pop(); // Solo hará pop si hay una ruta previa
              } else {
                // Si no hay rutas previas, redirige a otra página (por ejemplo, a la página inicial)
                context.go('/'); // Cambia esto según tu lógica
              }
            }),
        title: Text('Detalle de Acción ${widget.actionId}'),
      ),
      body: FutureBuilder<ActionCompany?>(
        future: actionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los detalles'));
          } else if (snapshot.hasData) {
            final action = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      CustomCheckbox(
                        labelText: 'Insertar Arqueos',
                        value: insertarArqueos ?? false,
                        onChanged: (bool? newValue) {
                          if (newValue != null && !newValue) {
                            return setState(() {
                              insertarArqueos = newValue;
                            });
                          }
                          Modal.showModal(
                              context: context,
                              title: "Insertar Arqueos",
                              OkText: "OK",
                              Canceltext: "Cancelar",
                              content: Text("¿Permitir insertar arqueos?"),
                              onOk: () {
                                setState(() {
                                  insertarArqueos = newValue ?? false;
                                });
                              },
                              onCancel: () {});
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomCheckbox(
                        labelText: 'Ejecutar Acción',
                        value: ejecutarAccion ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            ejecutarAccion = newValue ?? false;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomTextField(
                        controller: _accionController,
                        hintText: 'Acción',
                        labelText: 'Acción',
                        onChanged: (value) {
                          setState(() {
                            accion = value;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomCheckbox(
                        labelText: 'Comparar Ventas',
                        value: compararVentas ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            compararVentas = newValue ?? false;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomTextField(
                        controller: _prefijoCajaController,
                        hintText: 'Prefijo Caja',
                        labelText: 'Prefijo Caja',
                        isEnabled: false,
                        onChanged: (value) {
                          setState(() {
                            prefijoCaja = value;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 10),
                      CustomTextField(
                        controller: _nitEmpresaController,
                        hintText: 'NIT Empresa',
                        isEnabled: false,
                        labelText: 'NIT Empresa',
                        onChanged: (value) {
                          setState(() {
                            nitEmpresa = value;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 10),
                      CustomTextField(
                        controller: _usuarioController,
                        hintText: 'Usuario',
                        labelText: 'Usuario',
                        onChanged: (value) {
                          setState(() {
                            usuario = value;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomCheckbox(
                        labelText: 'Accion 1',
                        value: accion1 ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            accion1 = newValue ?? false;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomCheckbox(
                        labelText: 'Accion 2',
                        value: accion2 ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            accion2 = newValue ?? false;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomCheckbox(
                        labelText: 'Accion 3',
                        value: accion3 ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            accion3 = newValue ?? false;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomTextField(
                        controller: _topeController,
                        hintText: 'Tope',
                        labelText: 'Tope',
                        onChanged: (value) {
                          tope = value;
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 10),
                      CustomTextField(
                        controller: _transaccionesPendientesController,
                        hintText: 'Transacciones Pendientes',
                        labelText: 'Transacciones Pendientes',
                        onChanged: (value) {
                          transaccionesPendientes = value;
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 10),
                      CustomTextField(
                        controller: _almacenController,
                        hintText: 'Almacén',
                        labelText: 'Almacén',
                        onChanged: (value) {
                          setState(() {
                            almacen = value;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 10),
                      CustomCheckbox(
                        labelText: 'Estado',
                        value: estado ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            estado = newValue ?? false;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomDatePicker(
                        labelText: 'Fecha 1',
                        selectedDate: fecha1,
                        onChanged: (DateTime? newDate) {
                          setState(() {
                            fecha1 = newDate;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 10),
                      CustomDatePicker(
                        labelText: 'Fecha 2',
                        selectedDate: fecha2,
                        onChanged: (DateTime? newDate) {
                          setState(() {
                            fecha2 = newDate;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      CustomCheckbox(
                        labelText: 'Auditar',
                        value: auditar ?? false,
                        onChanged: (bool? newValue) {
                          setState(() {
                            auditar = newValue ?? false;
                          });
                        },
                      ),
                      const Spacing(orientation: "horizontal", size: 20),
                      Button(
                        isLoading: _loading,
                        label: "Actualizar",
                        onPressed: () async {
                          String? jwt =
                              Provider.of<UserProvider>(context, listen: false)
                                  .jwtToken;
                          if (jwt != null) {
                            Modal.showModal(
                                context: context,
                                title: "Actualizar",
                                OkText: "OK",
                                Canceltext: "Cancelar",
                                content: Text("¿Desea actualizar esta caja?"),
                                onOk: () async {
                                  setState(() {
                                    _loading = true;
                                  });
                                  ActionCompany? updatedAction = await _actionscontroller.updateAction(
                                      ActionCompany(
                                          id: action.id,
                                          insArqueos: insertarArqueos! ? 1 : 0,
                                          ejeAccion: ejecutarAccion! ? 1 : 0,
                                          accion: _accionController.text!,
                                          compVentas: compararVentas! ? 1 : 0,
                                          prefijoCaja:
                                              _prefijoCajaController.text ?? '',
                                          nitEmpresa:
                                              _nitEmpresaController.text ?? '',
                                          usuario: _usuarioController.text,
                                          accion1: accion1! ? 1 : 0,
                                          accion2: accion2! ? 1 : 0,
                                          accion3: accion3! ? 1 : 0,
                                          tope: int.parse(
                                              _topeController.text ?? "0"),
                                          transaccionesPen: int.parse(
                                              _transaccionesPendientesController
                                                      .text ??
                                                  "0"),
                                          almacen:
                                              _almacenController.text ?? '',
                                          estado: estado! ? 1 : 0,
                                          fecha1: DateFormat('yyyy-MM-dd')
                                              .format(fecha1!),
                                          fecha2: DateFormat('yyyy-MM-dd')
                                              .format(fecha2!),
                                          auditar: auditar! ? 1 : 0),
                                      jwt,
                                      context);
                                  setState(() {
                                    _loading = false;
                                  });

                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text("Caja actualizada.")));
                                },
                                onCancel: () {});
                          }
                        },
                      ),
                    ],
                  )),
            );
          } else {
            return Center(child: Text('No se encontraron datos'));
          }
        },
      ),
    );
  }
}
