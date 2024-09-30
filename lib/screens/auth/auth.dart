import 'package:fact_app/components/buttons/button.dart';
import 'package:fact_app/components/spacing/spacing.dart';
import 'package:fact_app/components/textfield/textfield.dart';
import 'package:fact_app/controllers/auth/auth.dart';
import 'package:fact_app/shared/providers/user.dart';
import 'package:fact_app/types/auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<AuthPage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<AuthPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthController _authController = AuthController();
  final _formKey = GlobalKey<FormState>();
  String _txtUsername = '';
  String _txtPassword = '';

  bool _isUsernameValid = true;
  bool _isPasswordValid = true;
  bool _isLoading = false;

  void _submitLoginForm() async {
    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      // Si el formulario es válido, puedes enviar los datos o hacer otra lógica.
      print("Formulario válido");
      print("Usuario: ${_usernameController.text}");
      print("Contraseña: ${_passwordController.text}");
      Auth? auth = await _authController.login(
          AuthInput(usuario: _txtUsername, password: _txtPassword), context);

      if (mounted) {
        if (auth != null) {
          setState(() {
            _isLoading = false;
          });
          Provider.of<UserProvider>(context, listen: false).setUser(auth.user);
          Provider.of<UserProvider>(context, listen: false)
              .setJWTToken(auth.jwt);
          context.go("/companies");
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      setState(() {
        _isUsernameValid = _usernameController.text.isNotEmpty;
        _isPasswordValid = _passwordController.text.isNotEmpty;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(), // Indicador de carga
            )
          : Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                // Column is also a layout widget. It takes a list of children and
                // arranges them vertically. By default, it sizes itself to fit its
                // children horizontally, and tries to be as tall as its parent.
                //
                // Column has various properties to control how it sizes itself and
                // how it positions its children. Here we use mainAxisAlignment to
                // center the children vertically; the main axis here is the vertical
                // axis because Columns are vertical (the cross axis would be
                // horizontal).
                //
                // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
                // action in the IDE, or press "p" in the console), to see the
                // wireframe for each widget.
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 300,
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                child: Image.asset(
                                  '/images/logo/logo.png',
                                  width: 200,
                                  height: 200,
                                ),
                              ),
                              Spacing(orientation: 'horizontal', size: 20),
                              Column(
                                children: [
                                  CustomTextField(
                                    hintText: 'Usuario',
                                    controller: _usernameController,
                                    errorText: _isUsernameValid
                                        ? null
                                        : "El campo usuario es obligatorio.",
                                    onChanged: (value) {
                                      setState(() {
                                        _txtUsername = value;
                                        _isUsernameValid = value.isNotEmpty;
                                        ;
                                      });
                                    },
                                    onSubmitted: (value) {
                                      print('Submitted: $value');
                                    },
                                  ),
                                  const Spacing(
                                    orientation: 'horizontal',
                                    size: 15.0, // Altura del espaciador
                                  ),
                                  CustomTextField(
                                    hintText: 'Contraseña',
                                    controller: _passwordController,
                                    errorText: _isPasswordValid
                                        ? null
                                        : "El campo contraseña es obligatorio.",
                                    isObscured: true,
                                    onChanged: (value) {
                                      setState(() {
                                        _txtPassword = value;
                                        _isPasswordValid = value.isNotEmpty;
                                      });
                                    },
                                    onSubmitted: (value) {
                                      print('Submitted: $value');
                                    },
                                  ),
                                ],
                              )
                            ],
                          ))),
                  const Spacing(
                    orientation: 'horizontal',
                    size: 15.0, // Altura del espaciador
                  ),
                  Button(
                    label: "Ingresar",
                    isLoading: false,
                    onPressed: () {
                      _submitLoginForm();
                    },
                  ),
                ],
              ),
            ),
    );
  }
}
