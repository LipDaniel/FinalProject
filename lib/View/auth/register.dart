// ignore_for_file: unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:iconsax/iconsax.dart';
import 'package:projectsem4/View/auth/login.dart';
import 'package:projectsem4/repository/authenticate_repo.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lasNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> handleRegisterSubmit() async {
    if (!validateForm()) {
      AppConstraint.errorToast("Please fill required fields");
      return;
    }
    await EasyLoading.show();
    Map<String, dynamic> params = {
      "_cus_first_name": firstNameController.text,
      "_cus_last_name": lasNameController.text,
      "_cus_email": emailController.text,
      "_cus_phone": phoneController.text,
      "_cus_password": passwordController.text
    };
    var response = await AuthenticateRepository.register(params);
    if (response != "Success") {
      await AppConstraint.errorToast(response);
      await EasyLoading.dismiss();
      return;
    }
    AppConstraint.successToast('Successfully registration');
    EasyLoading.dismiss();
    Route route = MaterialPageRoute(builder: (context) => const Login());
    Navigator.push(context, route);
  }

  bool validateForm() {
    bool check = true;
    if (firstNameController.text == '' ||
        lasNameController.text == '' ||
        phoneController.text == '' ||
        emailController.text == '' ||
        firstNameController.text == '') {
      check = false;
    }
    return check;
  }

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
    AppConstraint.initLoading;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.only(right: 30, left: 30),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                      "https://ouch-cdn2.icons8.com/kQoUOOANZvS258QGQr73eYz78IWO65f-_Q-rjkScBEA/rs:fit:368:410/czM6Ly9pY29uczgu/b3VjaC1wcm9kLmFz/c2V0cy9zdmcvODgx/Lzk5ZWI5NTg3LTYy/OWUtNGIzYi1hOWJj/LTZjYjJmZDQ5YTA0/Zi5zdmc.png",
                      width: 280,
                      fit: BoxFit.cover),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                  FadeInDown(
                      child: Column(
                    children: [
                      _textField(
                          'First name',
                          const Icon(Iconsax.user,
                              color: Colors.black, size: 18),
                          firstNameController),
                      const SizedBox(height: 10),
                      _textField(
                          'Last name',
                          const Icon(Iconsax.user,
                              color: Colors.black, size: 18),
                          lasNameController),
                      const SizedBox(height: 10),
                      _textField(
                          'Email',
                          const Icon(Iconsax.sms_notification,
                              color: Colors.black, size: 18),
                          emailController),
                      const SizedBox(height: 10),
                      _textField(
                          'Phone',
                          const Icon(Iconsax.call,
                              color: Colors.black, size: 18),
                          phoneController),
                      const SizedBox(height: 10),
                      _textField(
                          'Password',
                          const Icon(Iconsax.key,
                              color: Colors.black, size: 18),
                          passwordController),
                    ],
                  )),
                  const SizedBox(height: 20),
                  FadeInDown(
                      child: MaterialButton(
                    onPressed: () => handleRegisterSubmit(),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 30),
                    minWidth: double.infinity,
                    child: const Text("Register",
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
                      TextButton(
                          onPressed: () {
                            Route route = MaterialPageRoute(
                                builder: (context) => const Login());
                            Navigator.push(context, route);
                          },
                          child: const Text("Login"))
                    ],
                  ))
                ],
              ),
            ),
          ),
        ));
  }

  TextField _textField(
      String text, Icon icon, TextEditingController controller) {
    bool isPassword = text == 'Password' ? true : false;
    return TextField(
      obscureText: isPassword,
      cursorColor: Colors.black,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(0.0),
        labelText: text,
        hintText: text,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 14.0,
        ),
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        prefixIcon: icon,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade200, width: 2),
          borderRadius: BorderRadius.circular(10.0),
        ),
        floatingLabelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 18.0,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.black, width: 1.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
      onChanged: (value) {
        setState(() {
          controller.text = value;
        });
      },
    );
  }
}
