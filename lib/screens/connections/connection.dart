import 'package:fact_app/components/menu/menu.dart';
import 'package:fact_app/controllers/company/company.dart';
import 'package:fact_app/controllers/connections/connectionsController.dart';
import 'package:fact_app/shared/providers/user.dart';
import 'package:fact_app/types/company/company.dart';
import 'package:fact_app/types/connection/connection.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Connections extends StatefulWidget {
  final int nit;
  const Connections({
    Key? key,
    required this.nit,
  }) : super(key: key);

  @override
  _ConnectionState createState() => _ConnectionState();
}

class _ConnectionState extends State<Connections> {
  final _companyController = Companycontroller();
  final _connectionsController = Connectionscontroller();
  final _controller = SideMenuController();
  int _currentIndex = 0;
  List<String> companies = [];
  List<Connection?> connections = [];
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
        fetchConnections(fetchCompany.nit.toString());
        setState(() {
          company = fetchCompany;
        });
      }
    }
  }

  void fetchConnections(String nit) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String? jwt = Provider.of<UserProvider>(context, listen: false).jwtToken;
    if (user != null && jwt != null) {
      List<Connection?> fetchConnections =
          await _connectionsController.getConnections(nit, jwt, context);

      if (fetchConnections.isNotEmpty) {
        setState(() {
          connections = fetchConnections;
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
              /* leading: InkWell(
                child: Container(
                  child: Icon(Icons.menu),
                ),
                onTap: () {
                  print("InkWell tapped!");
                },
              ),*/
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
                title: const Text('Conexiones'),
                background: Image.asset(
                  '/images/checkout-image-header.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= connections.length) return null;
                  return ListTile(
                    enableFeedback: true,
                    trailing: const Icon(Icons.arrow_forward),
                    leading: Image.asset(
                        "/images/cash-register.png"), // Aquí colocas el ícono
                    onTap: () {
                      context.push(
                          "/connections-detail/${connections[index]!.id}");
                    },
                    title: Text(
                        "Caja - ${connections[index]!.conPrefijo}"), // Mostrar nombres de compañías
                    subtitle:
                        Text("NIT : ${connections[index]!.conNitempresa}"),
                  );
                },
                childCount: connections.length, // Cantidad de items en la lista
              ),
            ),
          ],
        ),
      ),
    );
  }
}
