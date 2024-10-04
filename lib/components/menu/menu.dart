import 'package:fact_app/components/modal/modal.dart';
import 'package:fact_app/shared/providers/user.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              /*image: DecorationImage(
                image: AssetImage(
                    'images/logo/logo.png'), // Ruta correcta del asset
                fit: BoxFit.cover, // Ajustar la imagen al fondo
              ),*/
              color: Colors.blue, // Esto es opcional si la imagen cubre todo
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Menú Principal',
                  style: TextStyle(
                    color: Colors.grey[100],
                    fontSize: 24,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.list),
            title: const Text('Empresas'),
            onTap: () {
              context.go("/companies");
            },
          ),
          ListTile(
            leading: const Icon(Icons.link),
            title: const Text('Conexiones'),
            onTap: () {
              context.go("/connections");
              print("Navegar a Conexiones");
            },
          ),
          const Divider(), // Separador
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Salir'),
            onTap: () {
              Modal.showModal(
                  context: context,
                  title: "Salir",
                  OkText: "Si",
                  Canceltext: "Cancelar",
                  content: Text("¿Desea salir?"),
                  onOk: () {
                    Provider.of<UserProvider>(context, listen: false)
                        .clearAllData();
                    context.go('/');
                  },
                  onCancel: () {});
            },
          ),
        ],
      ),
    );
  }
}
