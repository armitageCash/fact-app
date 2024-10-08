import 'package:fact_app/components/menu/menu.dart';
import 'package:fact_app/controllers/actions/actionsController.dart';
import 'package:fact_app/controllers/company/company.dart';
import 'package:fact_app/shared/providers/company.dart';
import 'package:fact_app/shared/providers/user.dart';
import 'package:fact_app/types/action/action.dart';
import 'package:fact_app/types/company/company.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_side_menu/flutter_side_menu.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;

class Companies extends StatefulWidget {
  const Companies({super.key});

  @override
  _CompaniesState createState() => _CompaniesState();
}

class _CompaniesState extends State<Companies> {
  final _companyController = Companycontroller();
  final _controller = SideMenuController();
  int _currentIndex = 0;
  List<Company?> companies = [];
  Company? company;
  bool _loading = true;

  @override
  void initState() {
    super.initState();

    SchedulerBinding.instance.addPostFrameCallback((_) {
      fetchCompanies();
    });
  }

  void fetchCompanies() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String? jwt = Provider.of<UserProvider>(context, listen: false).jwtToken;
    if (user != null && jwt != null) {
      List<Company>? fetchCompanies =
          await _companyController.getCompanies(user.idusuario, jwt, context);

      if (fetchCompanies != null) {
        setState(() {
          companies = fetchCompanies;
          _loading = false;
        });
      }
    }
  }

  void setCompany(Company company) {
    (Provider.of<CompanyProvider>(context, listen: false).company = company);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text('Empresas'),
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/menu-icon.svg', // Ícono personalizado
                  width: 30,
                  height: 30,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer(); // Abre el Drawer
                },
              );
            },
          ),
        ),
        drawer: MenuDrawer(), // El Drawer personalizado,
        body: _loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : CustomScrollView(
                slivers: [
                  SliverAppBar(
                    leading: Container(),
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
                      title: const Text(''),
                      background: Image.asset(
                        'assets/images/header-image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (index >= companies.length) return null;
                        return ListTile(
                          enableFeedback: true,
                          trailing: SvgPicture.asset(
                            "assets/icons/forward-icon.svg",
                            width: 34,
                            height: 34,
                          ),
                          leading: SvgPicture.asset(
                            "assets/icons/company-icon.svg",
                            width: 34,
                            height: 34,
                          ), // Aquí colocas el ícono
                          onTap: () {
                            setCompany(companies[index]!);
                            GoRouterState.of(context).name!;
                            if (GoRouterState.of(context).name! ==
                                "connections") {
                              context.push(
                                  "/connections/${companies[index]!.nitempresa}");
                            }
                            if (GoRouterState.of(context).name! ==
                                "companies") {
                              context.push(
                                  "/checkout/${companies[index]!.nitempresa}");
                            }
                          },
                          title: Text(
                              "Empresa - ${companies[index]!.razonsocial}"), // Mostrar nombres de compañías
                          subtitle: Text(
                            "NIT : ${companies[index]!.nit}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                      childCount:
                          companies.length, // Cantidad de items en la lista
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
