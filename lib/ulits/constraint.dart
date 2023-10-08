import 'package:flutter/material.dart';
import 'package:projectsem4/model/seat_model.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

class AppConstraint {
  static const fontFamilyBold = "Montserrat-Bold";
  static const fontFamilyRegular = "Montserrat-Regular";
  static const mainColor = Color(0xff009688);
  static const colorBox = Color.fromARGB(255, 227, 227, 227);
  static const colorSlogan = Color.fromARGB(255, 255, 255, 255);
  static const colorSubSlogan = Color.fromARGB(255, 255, 255, 255);
  static const colorInput = Color.fromARGB(255, 234, 234, 234);
  static const colorIcon = Color.fromARGB(255, 167, 166, 166);
  static const colorLabel = Color.fromARGB(255, 161, 161, 161);
  static const baseUrl = 'http://localhost:8080/';
  static final initLoading = EasyLoading.instance
    ..maskType = EasyLoadingMaskType.black
    ..loadingStyle = EasyLoadingStyle.custom
    ..textColor = Colors.black
    ..backgroundColor = Colors.transparent
    ..indicatorColor = Colors.white
    ..boxShadow = <BoxShadow>[]
    ..indicatorWidget = Image.asset(
      'assets/image/flight_loading.gif',
      scale: 1.7,
    );
  static errorToast(String title) {
    Toast.show(title,
        duration: Toast.lengthLong,
        gravity: Toast.top,
        backgroundColor: Color.fromARGB(255, 249, 87, 97).withOpacity(0.9),
        textStyle: const TextStyle(
            fontFamily: AppConstraint.fontFamilyBold,
            color: Colors.white,
            fontSize: 16));
  }

  static successToast(String title) {
    Toast.show(title,
        duration: Toast.lengthLong,
        gravity: Toast.top,
        backgroundColor: Color.fromARGB(255, 153, 252, 142),
        textStyle: const TextStyle(
            fontFamily: AppConstraint.fontFamilyBold,
            color: Colors.white,
            fontSize: 16));
  }
}

List<SeatsModel> firtClass = [
  const SeatsModel(id: 'A1'),
  const SeatsModel(id: 'A2'),
  const SeatsModel(id: 'A3'),
  const SeatsModel(id: 'A4'),
  const SeatsModel(id: 'A5'),
  const SeatsModel(id: 'A6'),
  const SeatsModel(id: 'A7'),
  const SeatsModel(id: 'A8'),
  const SeatsModel(id: 'A2'),
  const SeatsModel(id: 'A3'),
  const SeatsModel(id: 'A4'),
  const SeatsModel(id: 'A5'),
  const SeatsModel(id: 'A6'),
  const SeatsModel(id: 'A7'),
  const SeatsModel(id: 'A8'),
  const SeatsModel(id: 'A1'),
  const SeatsModel(id: 'A2'),
  const SeatsModel(id: 'A3'),
  const SeatsModel(id: 'A4'),
  const SeatsModel(id: 'A5'),
  const SeatsModel(id: 'A6'),
  const SeatsModel(id: 'A7'),
  const SeatsModel(id: 'A8'),
  const SeatsModel(id: 'A2'),
];
List<SeatsModel> businessClass = [
  const SeatsModel(id: 'B1'),
  const SeatsModel(id: 'B2'),
  const SeatsModel(id: 'B3'),
  const SeatsModel(id: 'B4'),
  const SeatsModel(id: 'B5'),
  const SeatsModel(id: 'B6'),
  const SeatsModel(id: 'B7'),
  const SeatsModel(id: 'B8'),
];
List<SeatsModel> economyClass = [
  const SeatsModel(id: 'C1'),
  const SeatsModel(id: 'C2'),
  const SeatsModel(id: 'C3'),
  const SeatsModel(id: 'C4'),
  const SeatsModel(id: 'C5'),
  const SeatsModel(id: 'C6'),
  const SeatsModel(id: 'C7'),
  const SeatsModel(id: 'C8'),
];
