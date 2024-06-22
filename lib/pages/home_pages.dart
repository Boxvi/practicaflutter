import 'package:flutter/material.dart';
import 'package:myapp/components/components.dart';
import 'package:myapp/pages/login_pages.dart';
import 'package:myapp/pages/signup_pages.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  static const String routename = 'home_page';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const TopScreenImage(screenImageName: 'home.jpg'),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(right: 15.0, left: 15, bottom: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const ScreenTitle(title: 'HOLA'),
                        const Text(
                          'Bienvenido a mi App soy Boris mucho Gusto',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Hero(
                          tag: 'login_btn',
                          child: CustomButton(
                            buttonText: 'Login',
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.routename);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Hero(
                          tag: 'signup_btn',
                          child: CustomButton(
                            buttonText: 'Sign Up',
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, SignupPage.routename);
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        const Text(
                          'Ingresa con lo siguiente:',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: CircleAvatar(
                                radius: 25,
                                child: Image.asset(
                                    'assets/images/icons/google.png'),
                              ),
                            ),
                          ],
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
    );
  }
}
