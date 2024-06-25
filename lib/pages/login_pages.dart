import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myapp/components/components.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/pages/home_pages.dart';
import 'package:myapp/pages/palabras_pages.dart';

import '../preferences/pref_usuarios.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static const String routename = 'login_page';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  bool _saving = false;
  final prefs = PreferenciasUsuario();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoadingOverlay(
        isLoading: _saving,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const TopScreenImage(screenImageName: 'welcome.png'),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ScreenTitle(title: 'Login'),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textField: TextField(
                              onChanged: (value) {
                                _email = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration:
                              kTextInputDecoration.copyWith(hintText: 'Correo'),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textField: TextField(
                              obscureText: true,
                              onChanged: (value) {
                                _password = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                  hintText: 'Contrasena'),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomBottomScreen(
                            textButton: 'Login',
                            heroTag: 'login_btn',
                            question: 'Contra olvidada?',
                            buttonPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(() {
                                _saving = true;
                              });
                              try {
                                await _auth.signInWithEmailAndPassword(
                                    email: _email, password: _password);

                                if (context.mounted) {
                                  setState(() {
                                    _saving = false;
                                    Navigator.popAndPushNamed(
                                        context, LoginPage.routename);
                                  });
                                  prefs.ultimaPagina = PalabraPage.routename;
                                  Navigator.pushNamed(context, PalabraPage.routename);
                                }
                              } catch (e) {
                                signUpAlert(
                                  context: context,
                                  onPressed: () {
                                    setState(
                                          () {
                                        _saving = false;
                                      },
                                    );
                                    Navigator.popAndPushNamed(
                                        context, LoginPage.routename);
                                  },
                                  title: 'Ups... Algo Salio mal =D',
                                  desc:
                                  'Confirma si escribiste tu correo y contrasena correctamente',
                                  btnText: 'Try Now',
                                ).show();
                              }
                            },
                            questionPressed: () {
                              signUpAlert(
                                onPressed: () async {},
                                title: 'Restablecer Contrasena',
                                desc:
                                'Click en el boton para restablecer tu contrasena',
                                btnText: 'Restablecer',
                                context: context,
                              ).show();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}