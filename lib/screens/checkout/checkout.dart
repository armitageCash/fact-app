import 'package:fact_app/components/dropdown/dropdown.dart';
import 'package:fact_app/components/menu/menu.dart';
import 'package:fact_app/controllers/actions/actionsController.dart';
import 'package:fact_app/controllers/company/company.dart';
import 'package:fact_app/shared/providers/user.dart';
import 'package:fact_app/types/action/action.dart';
import 'package:fact_app/types/company/company.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Checkout extends StatefulWidget {
  final int nit;
  const Checkout({
    Key? key,
    required this.nit,
  }) : super(key: key);

  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  final _companyController = Companycontroller();
  final _actionsController = Actionscontroller();
  final _controller = SideMenuController();
  int _currentIndex = 0;
  List<String> companies = [];
  List<ActionCompany?> actions = [];
  List<ActionCompany?> actionsItems = [];
  List<String> _warehouse = [];
  Company? company;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchCompany();
    });
  }

  void fetchCompany() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String? jwt = Provider.of<UserProvider>(context, listen: false).jwtToken;
    if (user != null && jwt != null) {
      Company? fetchCompany =
          await _companyController.getCompany(widget.nit, jwt, context);

      if (fetchCompany != null) {
        fetchStations(fetchCompany.nit.toString());
        setState(() {
          company = fetchCompany;
        });
      }
    }
  }

  void fetchStations(String nit) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String? jwt = Provider.of<UserProvider>(context, listen: false).jwtToken;
    if (user != null && jwt != null) {
      List<ActionCompany?> fetchActions =
          await _actionsController.getActions(nit, jwt, context);

      if (fetchActions.isNotEmpty) {
        setState(() {
          actions = fetchActions;
          actionsItems = fetchActions;
          _warehouse = fetchActions
              .map((action) => action!.almacen as String)
              .toSet()
              .toList();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: MenuDrawer(), // El Drawer personalizado,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: company != null ? Text(company!.razonsocial) : null,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              expandedHeight: 200.0, // Altura del header expandido
              pinned: true, // Se queda fijo al hacer scroll hacia abajo
              flexibleSpace: FlexibleSpaceBar(
                title: const Text('Cajas'),
                background: Image.asset(
                  '/images/checkout-image-header.png',
                  fit: BoxFit.cover,
                ),
              ),
              bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(60),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      child: Dropdown<String>(
                        allowSearch: true,
                        searchHintText: "Buscar...",
                        hintText: 'Almacen',
                        items: _warehouse,
                        onChanged: (value) {
                          setState(() {
                            actions = [...actionsItems]
                                .where((action) => action!.almacen == value)
                                .toList();
                          });
                          debugPrint('Changing value to: ${value}');
                        },
                      ),
                    ),
                  )),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= actions.length) return null;
                  return ListTile(
                    enableFeedback: true,
                    trailing: const Icon(Icons.arrow_forward),
                    leading: Image.asset(
                        "/images/cash-register.png"), // Aquí colocas el ícono
                    onTap: () {
                      context.push(
                          "/checkout-detail/${actions[index]!.prefijoCaja}");
                    },
                    title: Text(
                        "Caja - ${actions[index]!.prefijoCaja}"), // Mostrar nombres de compañías
                    subtitle: Text("Almacen : ${actions[index]!.almacen}"),
                  );
                },
                childCount: actions.length, // Cantidad de items en la lista
              ),
            ),
          ],
        ),
      ),
    );
  }
}
