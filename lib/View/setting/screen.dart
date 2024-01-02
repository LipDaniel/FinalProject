// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:projectsem4/View/auth/login.dart';
import 'package:projectsem4/View/setting/profile.dart';
import 'package:projectsem4/ulits/constraint.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({
    super.key,
  });

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late String fname = '';
  late String lname = '';
  late String email = '';
  late String phone = '';
  late String dob = '';
  late String avatar = '';
  Map<String, dynamic>? userInfo;
  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    String firstName = await AppConstraint.loadData('fname') ?? '';
    String lastName = await AppConstraint.loadData('lname') ?? '';
    String userEmail = await AppConstraint.loadData('email') ?? '';
    String userPhone = await AppConstraint.loadData('phone') ?? '';
    String userDob = await AppConstraint.loadData('dob') ?? '';
    String userAvatar = await AppConstraint.loadData('avatar') ?? '';

    setState(() {
      fname = firstName;
      lname = lastName;
      email = userEmail;
      phone = userPhone;
      dob = userDob;
      avatar = userAvatar;
      userInfo = {
        'fname': fname,
        'lname': lname,
        'email': email,
        'phone': phone,
        'dob': dob,
        'avatar': avatar
      };
    });
  }

  void handleLogout() async {
    await EasyLoading.show();
    await Future.delayed(const Duration(seconds: 2));
    await AppConstraint.removeData();
    Route route = MaterialPageRoute(builder: (context) => const Login());
    Navigator.push(context, route);
    await EasyLoading.dismiss();
  }

  void handleEditProfile() {
    Route route = MaterialPageRoute(builder: (context) => ProfileScreen(userInfo: userInfo));
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              const Text('Setting',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                decoration: BoxDecoration(
                    color: AppConstraint.mainColor,
                    borderRadius: BorderRadius.circular(8)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Container(
                            height: 75,
                            width: 75,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  'assets/image/avatar.jpeg',
                                  fit: BoxFit.cover,
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('$fname $lname',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  email,
                                  style: const TextStyle(
                                      color: AppConstraint.colorSlogan),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              _item(
                title: 'Account',
                data: Column(
                  children: [
                    __itemSetting(
                        onTap: () => handleEditProfile(),
                        title: 'Profile',
                        subTitle: 'Edit your information account',
                        icon: const Icon(Icons.supervised_user_circle)),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                        title: 'Face ID / Touch ID',
                        subTitle: 'Login authenticate management',
                        icon: const Icon(Icons.lock)),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                      title: 'Upgrade',
                      subTitle: 'Upgrade your account to get more promotion',
                      icon: const Icon(Icons.airplane_ticket),
                    ),
                  ],
                ),
              ),
              _item(
                title: 'System',
                data: Column(
                  children: [
                    __itemSetting(
                      title: 'Support & Report',
                      icon: const Icon(Icons.support_agent),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                        title: 'About',
                        icon: const Icon(Icons.info)),
                    const SizedBox(
                      height: 20,
                    ),
                    __itemSetting(
                        title: 'Logout',
                        icon: const Icon(Icons.logout),
                        onTap: () => handleLogout(),
                        suffix: Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _item({required String title, required Widget data}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
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
            child: data),
        const SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget __itemSetting(
      {required String title,
      String? subTitle,
      required Icon icon,
      Function()? onTap,
      Widget? suffix}) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: title == 'Logout'
                            ? Color.fromARGB(255, 240, 91, 91).withOpacity(0.5)
                            : AppConstraint.mainColor.withOpacity(0.2),
                        shape: BoxShape.circle),
                    child: icon),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      if (subTitle != null)
                        const SizedBox(
                          height: 5,
                        ),
                      if (subTitle != null)
                        Text(
                          subTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                )
              ],
            ),
          ),
          suffix ??
              const Icon(
                Icons.arrow_forward_ios_rounded,
                color: Colors.grey,
              )
        ],
      ),
    );
  }
}
