// ignore_for_file: must_be_immutable, use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/View/confirm/confirm_screen.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/passenger_model.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:country_picker/country_picker.dart';

class InformationScreen extends StatefulWidget {
  InformationScreen({super.key, required this.model});
  BusinessModel model;
  @override
  State<InformationScreen> createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  final List<String> _bagageList = [
    '',
    '10 kg - 100.000',
    '20 kg - 200.000',
    '30 kg - 300.000',
    '50 kg - 500.000'
  ];
  final List<String> _titleList = ['Mr.', 'Ms.', 'Mrs.'];
  List<List<TextEditingController>> formControllers = [];

  @override
  void initState() {
    super.initState();
    formControllers = List.generate(
      widget.model.seatList!.length,
      (index) => List.generate(9, (index) => TextEditingController()),
    );
  }

  void handleSubmitInformation() async {
    await EasyLoading.show();
    List<PassengerModel> passengers = [];
    for (var i = 0; i < formControllers.length; i++) {
      PassengerModel passenger = PassengerModel();
      passenger.title = formControllers[i][0].text;
      passenger.name = formControllers[i][1].text;
      passenger.birth = formControllers[i][2].text;
      passenger.country = formControllers[i][3].text;
      passenger.national = formControllers[i][4].text;
      passenger.passport = formControllers[i][5].text;
      passenger.expire_date = formControllers[i][6].text;
      passenger.checked_baggage = formControllers[i][7].text;
      passenger.cabin_baggage = formControllers[i][8].text;
      passenger.seat = widget.model.seatList?[i];

      passengers.add(passenger);
    }
    widget.model.passenger_list = passengers;
    if (validateForm(passengers) == false) {
      AppConstraint.errorToast("PLease fill out into validate input");
      await EasyLoading.dismiss();
      return;
    }

    Route route = MaterialPageRoute(
        builder: (context) => ConfirmScreen(model: widget.model));
    Navigator.push(context, route);
    await EasyLoading.dismiss();
  }

  bool validateForm(List<PassengerModel> passengeForms) {
    var check = true;
    for (PassengerModel item in passengeForms) {
      if (item.name == '' ||
          item.birth == '' ||
          item.country == '' ||
          item.national == '') {
        check = false;
        return check;
      }
      if (passengerClassification(item.birth) == "Adult" && item.passport == '') {
        check = false;
        return check;
      }
    }
    return check;
  }

  String passengerClassification(String? birthDateStr) {
    DateTime currentDate = DateTime.now();
    DateTime birthDate = DateFormat('dd-MM-yyyy').parse(birthDateStr!);
    int age = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month &&
            currentDate.day < birthDate.day)) {
      age--;
    }
    if (age > 12) {
      return "Adult";
    } else {
      if (age > 2 && age <= 12) {
        return "Children";
      } else {
        return "Baby";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstraint.mainColor,
        title: const Text('PASSENGER INFORMATION',
            style: TextStyle(
                fontSize: 16, fontFamily: AppConstraint.fontFamilyBold)),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          ...widget.model.seatList!.map((item) {
            int index = widget.model.seatList!
                .indexOf(item); // Index of the current form
            return _passengerForm(item, formControllers[index]);
          }).toList(),
          const SizedBox(
            height: 100.0, // Customize the height as needed
          ),
        ]),
      ),
      bottomSheet: _btn(),
    );
  }

  Container _passengerForm(
      String seat, List<TextEditingController> controllers) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1)
          ],
        ),
        padding: const EdgeInsets.all(25),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Expanded(flex: 2, child: _title(context, controllers[0])),
            const SizedBox(width: 5),
            Expanded(flex: 14, child: _textField('Full name', controllers[1])),
            const SizedBox(width: 15),
            _seat(seat)
          ]),
          const SizedBox(height: 15),
          _dateOfBirth(controllers[2]),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                flex: 5,
                child: _textField('Country', controllers[3], country: true)),
            const SizedBox(width: 15),
            Expanded(
                flex: 5,
                child: _textField('National', controllers[4], country: true))
          ]),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                flex: 5,
                child: _textField('Citizen ID / Passport', controllers[5])),
            const SizedBox(width: 15),
            Expanded(flex: 5, child: _textField('Expire date', controllers[6]))
          ]),
          const SizedBox(height: 20),
          Row(children: [
            Expanded(
                flex: 5,
                child: _bagage(context, 'Checked baggage', controllers[7])),
            const SizedBox(width: 10),
            Expanded(
                flex: 5,
                child: _bagage(context, 'Cabin baggage', controllers[8]))
          ]),
          const SizedBox(height: 35),
          const Text('* Free 23kg checked baggage',
              style: TextStyle(color: AppConstraint.colorLabel)),
          const Text('* Free 12kg cabin baggage',
              style: TextStyle(color: AppConstraint.colorLabel)),
        ]));
  }

  CupertinoTextField _bagage(
      BuildContext context, String title, TextEditingController controller) {
    return CupertinoTextField(
        controller: controller,
        prefix: Text(title,
            style: TextStyle(
                color: AppConstraint.colorIcon,
                fontSize: controller.text != '' ? 10 : 15)),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppConstraint.colorInput))),
        readOnly: true,
        onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                actions: [buildBagage(controller)],
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ));
  }

  CupertinoTextField _title(
      BuildContext context, TextEditingController controller) {
    controller.text = controller.text == '' ? _titleList[0] : controller.text;
    return CupertinoTextField(
        controller: controller,
        padding: const EdgeInsets.only(top: 15.5, bottom: 0.0),
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: AppConstraint.colorInput))),
        readOnly: true,
        onTap: () => showCupertinoModalPopup(
              context: context,
              builder: (context) => CupertinoActionSheet(
                actions: [buildTitle(controller)],
                cancelButton: CupertinoActionSheetAction(
                  child: const Text('Cancel'),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ));
  }

  Widget buildTitle(TextEditingController controller) {
    FixedExtentScrollController scrollController = FixedExtentScrollController(
        initialItem: _titleList.indexOf(controller.text));
    return SizedBox(
      height: 350,
      child: Semantics(
        value: controller.text,
        child: CupertinoPicker(
          scrollController: scrollController,
          itemExtent: 64,
          onSelectedItemChanged: (value) => setState(() {
            controller.text = _titleList[value];
          }),
          children: List<Widget>.generate(_titleList.length, (int index) {
            return Center(
              child: Text(
                _titleList[index],
                style: const TextStyle(fontSize: 35),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget buildBagage(TextEditingController controller) {
    FixedExtentScrollController scrollController = FixedExtentScrollController(
        initialItem: _bagageList.indexOf(controller.text));
    return SizedBox(
      height: 350,
      child: Semantics(
        label: 'Cabin Baggage Selector',
        value: controller.text,
        child: CupertinoPicker(
          scrollController: scrollController,
          itemExtent: 64,
          onSelectedItemChanged: (value) => setState(() {
            controller.text = _bagageList[value] != ''
                ? '${_bagageList[value].substring(0, 2)} kg'
                : '';
          }),
          children: List<Widget>.generate(_bagageList.length, (int index) {
            return Center(
              child: Text(
                _bagageList[index],
                style: const TextStyle(fontSize: 35),
              ),
            );
          }),
        ),
      ),
    );
  }

  Expanded _seat(String seat) {
    return Expanded(
        flex: 4,
        child: Column(
          children: [
            const Text('Seat',
                style:
                    TextStyle(fontSize: 13, color: AppConstraint.colorLabel)),
            Text(seat,
                style: const TextStyle(
                    fontSize: 25, fontFamily: AppConstraint.fontFamilyBold))
          ],
        ));
  }

  TextField _textField(String labelInput, TextEditingController controller,
      {bool country = false}) {
    if (country == true) {
      return TextField(
          readOnly: true,
          onTap: () {
            showCountryPicker(
              context: context,
              onSelect: (Country country) {
                controller.text = country.displayNameNoCountryCode;
              },
              countryListTheme: CountryListThemeData(
                bottomSheetHeight: 650.0,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
                inputDecoration: InputDecoration(
                  labelText: 'Search',
                  labelStyle: const TextStyle(color: AppConstraint.colorLabel),
                  contentPadding: const EdgeInsets.all(1.0),
                  prefixIcon: const Icon(Icons.search),
                  prefixIconColor: AppConstraint.colorLabel,
                  focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: AppConstraint.mainColor),
                      borderRadius: BorderRadius.all(Radius.circular(40.0))),
                  // focusedBorder: const UnderlineInputBorder(
                  // borderSide: BorderSide(color: AppConstraint.mainColor)),
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(40.0)),
                    borderSide: BorderSide(
                      color: const Color(0xFF8C98A8).withOpacity(0.2),
                    ),
                  ),
                ),
              ),
            );
          },
          controller: controller,
          scrollPadding: const EdgeInsets.all(2),
          cursorColor: AppConstraint.colorLabel,
          decoration: InputDecoration(
              isDense: true,
              contentPadding: const EdgeInsets.all(0),
              enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConstraint.colorInput)),
              focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConstraint.mainColor)),
              label: Text(labelInput, style: const TextStyle(fontSize: 14)),
              labelStyle: const TextStyle(color: AppConstraint.colorLabel)));
    }
    return TextField(
        onChanged: (value) => {
              if (labelInput == 'Expire date')
                {
                  if (value.length > 7)
                    {controller.text = value.substring(0, 5)}
                  else if (value.length == 2)
                    {
                      controller.text =
                          '${value.substring(0, 2)} / ${value.substring(2)}'
                    }
                  else if (value.length == 4 && value[3] == '/')
                    {controller.text = value.substring(0, 2)}
                }
            },
        controller: controller,
        scrollPadding: const EdgeInsets.all(2),
        cursorColor: AppConstraint.colorLabel,
        decoration: InputDecoration(
            isDense: true,
            contentPadding: const EdgeInsets.all(0),
            enabledBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.colorInput)),
            focusedBorder: const UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.mainColor)),
            label: Text(labelInput, style: const TextStyle(fontSize: 14)),
            labelStyle: const TextStyle(color: AppConstraint.colorLabel)));
  }

  TextField _dateOfBirth(TextEditingController controller) {
    return TextField(
      readOnly: true,
      controller: controller,
      scrollPadding: const EdgeInsets.all(2),
      cursorColor: AppConstraint.colorLabel,
      decoration: const InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.all(0),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppConstraint.colorInput)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppConstraint.mainColor)),
          label: Text('Date of birth', style: TextStyle(fontSize: 14)),
          labelStyle: TextStyle(color: AppConstraint.colorLabel)),
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime.now(),
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme:
                      const ColorScheme.light(primary: AppConstraint.mainColor),
                ),
                child: child!,
              );
            });
        if (pickedDate != null) {
          String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
          setState(() {
            controller.text = formattedDate;
          });
        }
      },
    );
  }

  Widget _btn() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            bottom: 30,
          ),
          child: InkWell(
            onTap: () => handleSubmitInformation(),
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.symmetric(
                vertical: 15,
              ),
              decoration: BoxDecoration(
                  color: AppConstraint.mainColor,
                  borderRadius: BorderRadius.circular(30)),
              child: const Center(
                child: Text(
                  'Next',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
