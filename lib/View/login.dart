import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:projectsem4/View/bottomnavi/bottomnavi_screen.dart';
import 'package:projectsem4/constraint.dart';

// ignore: must_be_immutable
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  int countdown() {
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            // mainAxisAlignment: ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Image.asset(
                'assets/image/4873.jpg',
              ),
              const SizedBox(height: 15),
              const Text(
                'Login',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: "Montserrat-Bold",
                    color: Color(0xff009688)),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: phoneController,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFcccccc))),
                    hintText: 'Email or phone number',
                    prefixIcon: Icon(Icons.perm_identity),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(height: 25),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFcccccc))),
                    hintText: 'Password',
                    prefixIcon: Icon(Icons.lock_outline),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue))),
              ),
              const SizedBox(height: 45),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 45,
                child: TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppConstraint.mainColor),
                      foregroundColor: MaterialStateProperty.all(Colors.white)),
                  child: const Text('Login',
                      style:
                          TextStyle(fontWeight: FontWeight.w900, fontSize: 17)),
                  onPressed: () {
                    Route route =
                        MaterialPageRoute(builder: (context) => const BottomNavigationBarApp());
                    Navigator.push(context, route);
                  },
                ),
              ),
              const SizedBox(height: 50),

              // SOCIAL MEDIA
              Positioned(
                bottom: 0.0,
                child: Center(
                  child: RichText(
                    text: TextSpan(
                      text: "Dont't have an account? ",
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: "Sign Up",
                          style: const TextStyle(color: AppConstraint.mainColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              // print('13');
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}