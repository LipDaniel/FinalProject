// ignore_for_file: must_be_immutable, avoid_print, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/View/bottomnavi/screen.dart';
import 'package:projectsem4/repository/authenticate_repo.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key, required this.userInfo});
  Map<String, dynamic>? userInfo;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController idController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController countryController = TextEditingController();

  File? _image;
  String avatar = 'assets/image/avatar.jpg';
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  void handleUpdateProfile() async {
    await EasyLoading.show();
    Map<String, dynamic> params = {
      "_cus_id": int.parse(idController.text),
      "_cus_first_name": fnameController.text,
      "_cus_last_name": lnameController.text,
      "_cus_dob": dobController.text,
      "_cus_phone": phoneController.text,
      "_cus_email": emailController.text
    };

    var response = await AuthenticateRepository.updateProfile(params);
    if (response == 'Something wrong in server') {
      AppConstraint.errorToast(response);
      await EasyLoading.dismiss();
      return;
    } else {
      storeUserInfo(response);
      AppConstraint.successToast("Update profile successfully");
      Route route =
          MaterialPageRoute(builder: (context) => BottomScreen(tab: 3));
      Navigator.pushReplacement(context, route);
      await EasyLoading.dismiss();
    }
  }

  void storeUserInfo(
    params,
  ) async {
    AppConstraint.saveData('id', params['_cus_id'].toString());
    AppConstraint.saveData('fname', params['_cus_first_name']);
    AppConstraint.saveData('lname', params['_cus_last_name']);
    AppConstraint.saveData('email', params['_cus_email']);
    AppConstraint.saveData('phone', params['_cus_phone']);
    AppConstraint.saveData('dob', params['_cus_dob']);
  }

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
    String formattedDate = '';
    if (widget.userInfo?['dob'].isNotEmpty ?? true) {
      DateTime originalDate = DateTime.parse(widget.userInfo?['dob']);
      formattedDate = DateFormat('dd-MM-yyyy').format(originalDate);
    }

    idController.text = widget.userInfo?['id'];
    fnameController.text = widget.userInfo?['fname'];
    lnameController.text = widget.userInfo?['lname'];
    phoneController.text = widget.userInfo?['phone'];
    emailController.text = widget.userInfo?['email'];
    dobController.text = formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: const Center(
        heightFactor: 5,
        child: Text('Made by Lip Daniel'),
      ),
      body: SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  const Text('Profile',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 15),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 15,
                              spreadRadius: 0.1,
                              offset: const Offset(3, 8),
                              color: Colors.grey.withOpacity(0.3))
                        ],
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppConstraint.mainColor,
                          radius: 80,
                          backgroundImage: AssetImage(avatar),
                          // _image != null ? FileImage(_image!) : null,
                          child: null,
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: getImage,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstraint.mainColor),
                          child: const Text('Change',
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        ),
                        const SizedBox(height: 15),
                        _textField('First name', fnameController),
                        const SizedBox(height: 10),
                        _textField('Last name', lnameController),
                        const SizedBox(height: 10),
                        _textField('Email', emailController),
                        const SizedBox(height: 10),
                        _textField('Phone', phoneController),
                        const SizedBox(height: 10),
                        _textField('Date of birth', dobController),
                        const SizedBox(height: 30),
                        Center(
                            child: SizedBox(
                          width: double.infinity, // Set the width here
                          child: ElevatedButton(
                            onPressed: () => handleUpdateProfile(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppConstraint.mainColor,

                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 12), // Button padding
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8.0), // Button border radius
                              ),
                            ),
                            child: const Text('SAVE',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                          ),
                        )),
                      ],
                    ),
                  )
                ],
              ))),
    );
  }

  TextField _textField(String suffix, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 5.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.grey[300], // Light grey background color for prefix
          ),
          child: Text(
            suffix,
            style: const TextStyle(color: AppConstraint.mainColor),
          ),
        ),
        filled: true,
        fillColor: Colors.grey[200], // Light grey background color
        hintStyle:
            const TextStyle(color: Colors.grey), // Optional: Hint text color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none, // No border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none, // No border
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
      ),
      style:
          const TextStyle(color: Color.fromARGB(255, 98, 98, 98)), // Text color
      textAlign: TextAlign.end,
      cursorColor: Colors.black,
    );
  }
}
