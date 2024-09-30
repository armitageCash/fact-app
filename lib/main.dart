import 'package:fact_app/components/layout/screen.dart';
import 'package:fact_app/components/splash/splash.dart';
import 'package:fact_app/screens/auth/auth.dart';
import 'package:fact_app/screens/checkout/action-detail.dart';
import 'package:fact_app/screens/checkout/checkout.dart';
import 'package:fact_app/screens/companies/companies.dart';
import 'package:fact_app/screens/connections/connection-detail.dart';
import 'package:fact_app/screens/connections/connection.dart';
import 'package:fact_app/shared/providers/company.dart';
import 'package:fact_app/shared/providers/user.dart';
import 'package:fact_app/types/user/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'splash',
      builder: (context, state) => Screen(child: SplashScreen()),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) =>
          const Screen(child: AuthPage(title: "Ingresar")),
    ),
    GoRoute(
      path: '/companies',
      name: 'companies',
      builder: (context, state) => const Screen(child: Companies()),
    ),
    GoRoute(
        path: '/checkout/:nit',
        name: 'checkout',
        builder: (context, state) {
          String? nit = state.pathParameters["nit"];
          return Screen(
              child: Checkout(
            nit: int.parse(nit!),
          ));
        }),
    GoRoute(
        path: '/connections',
        name: 'connections',
        builder: (context, state) => const Screen(child: Companies())),
    GoRoute(
        path: '/connections/:nit',
        name: 'connection-list',
        builder: (context, state) {
          String? nit = state.pathParameters["nit"];
          return Screen(
              child: Connections(
            nit: int.parse(nit!),
          ));
        }),
    GoRoute(
        path: '/checkout-detail/:actionId',
        name: 'checkoutDetail',
        builder: (context, state) {
          String? actionId = state.pathParameters["actionId"];
          return Screen(child: ActionDetails(actionId: actionId));
        }),
    GoRoute(
        path: '/connections-detail/:connectionId',
        name: 'connectionDetail',
        builder: (context, state) {
          String? connectionId = state.pathParameters["connectionId"];
          return Screen(child: ConnectionDetails(connectionId: connectionId));
        }),
  ],
  redirect: (context, state) {
    final User? user = Provider.of<UserProvider>(context, listen: false).user;

    // Si el usuario no está autenticado y está intentando ir a checkout
    if (user == null && state.topRoute!.name == "companies") {
      return '/'; // Redirigir a la página de autenticación
    }

    // Si el usuario está autenticado y está en la página de login, redirigir al checkout
    if (user != null && state.topRoute!.name == "login") {
      return '/companies';
    }

    return null; // No redirigir
  },
);
void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CompanyProvider()),
      ],
      child: const FactApp(),
    ),
  );
}

class FactApp extends StatelessWidget {
  const FactApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: Provider.of<UserProvider>(context, listen: false).isUserLoaded(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Muestra un loader mientras se carga el usuario
          return const Center(child: CircularProgressIndicator());
        }

        // Si el usuario se ha cargado, renderiza la app con GoRouter
        return MaterialApp.router(
          routerConfig: _router,
        );
      },
    );
  }
}
