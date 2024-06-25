import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:myapp/components/components.dart';
import 'package:myapp/constants.dart';
import 'package:myapp/pages/login_pages.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  static const String routename = 'signup_page';

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _auth = FirebaseAuth.instance;
  late String _email;
  late String _password;
  late String _confirmPass;
  bool _saving = false;

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
                const TopScreenImage(screenImageName: 'signup.png'),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const ScreenTitle(title: 'Sign Up'),
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
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Correo',
                              ),
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
                                hintText: 'Password',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomTextField(
                            textField: TextField(
                              obscureText: true,
                              onChanged: (value) {
                                _confirmPass = value;
                              },
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                              decoration: kTextInputDecoration.copyWith(
                                hintText: 'Confirm Password',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          CustomBottomScreen(
                            textButton: 'Sign Up',
                            heroTag: 'signup_btn',
                            question: 'Tiene una Cuenta?',
                            //question: 'Tiene una cuenta?',
                            buttonPressed: () async {
                              FocusManager.instance.primaryFocus?.unfocus();
                              setState(
                                () {
                                  _saving = true;
                                },
                              );

                              if (_confirmPass == _password) {
                                try {
                                  await _auth.createUserWithEmailAndPassword(
                                      email: _email, password: _password);

                                  if (context.mounted) {
                                    signUpAlert(
                                      context: context,
                                      title: "Registro Exitoso",
                                      desc: "Bienvenido, ingresa al login de nuevo",
                                      btnText: "Login ",
                                      onPressed: (){
                                        setState(() {
                                          _saving = false;
                                          Navigator.popAndPushNamed(
                                              context, SignupPage.routename);
                                        });
                                        Navigator.pushNamed(context, LoginPage.routename);
                                      },
                                    ).show();
                                  }
                                } catch (e) {
                                  signUpAlert(
                                    context: context,
                                    onPressed: () {
                                      SystemNavigator.pop();
                                    },
                                    title: "Algo salio muy mal",
                                    desc: "Por favor intentelo de nuevo",
                                    btnText: "Cerrar",
                                  );
                                }
                              } else {
                                showAlert(
                                  context: context,
                                  title: "Contrasena incorrecta",
                                  desc: "Sus contrasenas deben ser iguales",
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ).show();
                              }
                            },
                            questionPressed: () async {
                              Navigator.pushNamed(context, LoginPage.routename);
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

// const SizedBox(
//   height: 15,
// ),
// CustomTextField(
//   textField: TextField(
//     onChanged: (value) {
//       _username = value;
//     },
//     style: const TextStyle(
//       fontSize: 20,
//     ),
//     decoration: kTextInputDecoration.copyWith(
//       hintText: 'Usuario',
//     ),
//   ),
// ),
