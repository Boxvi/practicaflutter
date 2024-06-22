import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/firebase_options.dart';
import 'package:myapp/pages/home_pages.dart';
import 'package:myapp/pages/login_pages.dart';
import 'package:myapp/pages/signup_pages.dart';
import 'package:myapp/preferences/pref_usuarios.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenciasUsuario.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            fontFamily: 'Ubuntu'
          ),
        ),
      ),
      initialRoute: prefs.ultimaPagina,
      routes: {
        HomePage.routename: (context) => HomePage(),
        LoginPage.routename: (context) => LoginPage(),
        SignupPage.routename: (context) => SignupPage(),
        
      } ,
    );

  }
}
    //return MaterialApp(
    //  initialRoute: prefs.ultimaPagina,
    //  routes: {
    //    LoginPage.routename: (context) => LoginPage(),
    //  },
    //);