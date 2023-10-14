import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter/material.dart';
import 'package:projectsem4/View/auth/login.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(30),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      "https://ouch-cdn2.icons8.com/kQoUOOANZvS258QGQr73eYz78IWO65f-_Q-rjkScBEA/rs:fit:368:410/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvODgx/Lzk5ZWI5NTg3LTYy/OWUtNGIzYi1hOWJj/LTZjYjJmZDQ5YTA0/Zi5zdmc.png",
                      width: 280,
                      fit: BoxFit.cover),
                  const SizedBox(height: 50),
                  FadeInDown(
                    child: const Text("REGISTER",
                        style: TextStyle(
                            fontSize: 24,
                            fontFamily: AppConstraint.fontFamilyBold)),
                  ),
                  FadeInDown(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Text(
                        "Enter your phone number to continue, we will send you OTP to verify",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey.shade700)),
                  )),
                  const SizedBox(height: 30),
                  FadeInDown(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                              color: Color(0xffeeeeee),
                              blurRadius: 10,
                              offset: Offset(0, 4))
                        ],
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.black.withOpacity(0.13))),
                    child: Stack(
                      children: [
                        InternationalPhoneNumberInput(
                          onInputChanged: (value) {},
                          cursorColor: Colors.black,
                          formatInput: false,
                          selectorConfig: const SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              leadingPadding: 10.0),
                          inputDecoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.only(bottom: 13, left: 10),
                              border: InputBorder.none,
                              hintText: "Phone Number",
                              hintStyle: TextStyle(
                                  color: Colors.grey.shade500, fontSize: 16)),
                        ),
                        Positioned(
                          left: 90,
                          top: 8,
                          bottom: 8,
                          child: Container(
                            height: 40,
                            width: 1,
                            color: Colors.black.withOpacity(0.13),
                          ),
                        ),
                      ],
                    ),
                  )),
                  const SizedBox(height: 150),
                  FadeInDown(
                      child: MaterialButton(
                    onPressed: () {},
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    minWidth: double.infinity,
                    child: const Text("Send OTP",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: AppConstraint.fontFamilyBold)),
                  )),
                  FadeInDown(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an account?",
                          style: TextStyle(color: Colors.grey.shade700)),
                      TextButton(onPressed: () {
                        Route route = MaterialPageRoute(
                                builder: (context) => const Login());
                            Navigator.push(context, route);
                      }, child: const Text("Login"))
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }
}
