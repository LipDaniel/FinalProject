// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/View/flight_list/screen.dart';
import 'package:projectsem4/model/airport_model.dart';
import 'package:projectsem4/model/flight_model.dart';
import 'package:projectsem4/model/seatclass_model.dart';
import 'package:projectsem4/repository/airport_repo.dart';
import 'package:projectsem4/repository/flight_repo.dart';
import 'package:projectsem4/repository/seat_repo.dart';
import 'package:projectsem4/view/home/widgets/header_widget.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:toast/toast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> _amountList = ['0', '1', '2', '3', '4'];
  final List<String> _lstOptionRadio = ['One way', 'Round trip'];
  final TextEditingController _adultAmount = TextEditingController();
  final TextEditingController _childrenAmount = TextEditingController();
  final TextEditingController _babyAmount = TextEditingController();
  final TextEditingController _departInput = TextEditingController();
  final TextEditingController _returnInput = TextEditingController();
  int? airFromSelected;
  int? airToSelected;
  AirportModel? _airportFrom;
  AirportModel? _airportTo;
  String? _selectedRadio;
  int? _seatClass;
  SeatClassModel? _seatSelected;
  List<AirportModel> lstAir = [];
  List<SeatClassModel> lstClass = [];

  double calculateFormHeight(screen, header, bottom) {
    return (screen - header - bottom) - 10;
  }

  void swapAirPort() {
    setState(() {
      AirportModel? tmp = _airportFrom;
      _airportFrom = _airportTo;
      _airportTo = tmp;
    });
  }

  void handleSearchFlight() async {
    int amountPassenger = int.parse(_babyAmount.text) +
        int.parse(_adultAmount.text) +
        int.parse(_childrenAmount.text);
    
    if (airFromSelected == null || airToSelected == null) {
      AppConstraint.errorToast("Depart or arrival place are required");
      return;
    } else if (_departInput.text == '') {
      AppConstraint.errorToast("Depart date is required");
      return;
    } else if (_seatClass == null) {
      AppConstraint.errorToast("Please choose seat class");
      return;
    } else if (amountPassenger == 0) {
      AppConstraint.errorToast("At least 1 passenger");
      return;
    }

    await EasyLoading.show();
    final Map<String, dynamic> body = {
      "_fl_from_id": airFromSelected,
      "_fl_to_id": airToSelected,
      "_fl_take_off": _departInput.text,
      "_fl_return_date": _returnInput.text == '' ? null : _returnInput.text,
      "_tc_id": _seatClass,
      "_pas_quantity": amountPassenger
    };
    List<FlightModel> response = await FlightRepository.getFlight(body);

    if (response.isNotEmpty) {
      EasyLoading.dismiss();
      Route route =
          MaterialPageRoute(builder: (context) => FlightListScreen(data: response));
      Navigator.push(context, route);
    } else {     
      AppConstraint.errorToast("No data founds");
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    ToastContext().init(context);
    AppConstraint.initLoading;
    _selectedRadio = _lstOptionRadio[0];
    _adultAmount.text = "0";
    _childrenAmount.text = "0";
    _babyAmount.text = "0";
    _babyAmount.text = "0";
    _departInput.text = "";
    _returnInput.text = "";
    fetch();
  }

  fetch() async {
    lstAir = await AirPortRepository.getAirPort();
    lstClass = await SeatClassRepository.getSeatClass();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(),
            const HeaderHomeWidget(),
            _searchForm(context)
          ],
        ),
      ),
    );
  }

  Positioned _searchForm(BuildContext context) {
    return Positioned(
      top: 250,
      right: 30,
      left: 30,
      child: Container(
        height: calculateFormHeight(
            MediaQuery.sizeOf(context).height,
            MediaQuery.sizeOf(context).height * 0.33,
            kBottomNavigationBarHeight),
        width: MediaQuery.sizeOf(context).width,
        decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(5, 0), blurRadius: 10)
            ],
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              _radioButton(),
              const SizedBox(height: 10),
              Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 5,
                          child: Column(
                            children: [
                              Expanded(child: _dropDownSearchFrom()),
                              Expanded(child: _dropDownSearchTo()),
                            ],
                          )),
                      Expanded(
                        flex: 1,
                        child: IconButton(
                            icon: const Icon(Icons.swap_vert),
                            onPressed: () => swapAirPort()),
                      ),
                    ],
                  )),
              _departDate(),
              _returnDate(),
              Expanded(
                child: _dropDownSeatClass(),
              ),
              Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      _amountAdultField(context),
                      const SizedBox(width: 20),
                      _amountChildrenField(context),
                      const SizedBox(width: 20),
                      _amountBabyField(context)
                    ],
                  )),
              // const Expanded(child: ),
              const SizedBox(height: 10.0),
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () => handleSearchFlight(),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      )),
                      backgroundColor: const MaterialStatePropertyAll(
                          AppConstraint.mainColor)),
                  child: const Text('Find',
                      style: TextStyle(color: AppConstraint.colorSlogan)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _amountAdultField(BuildContext context) {
    return Expanded(
        child: CupertinoTextField(
            controller: _adultAmount,
            suffix: const Text('Adult',
                style: TextStyle(color: AppConstraint.colorIcon)),
            prefix:
                const Icon(Icons.people_alt, color: AppConstraint.colorIcon),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppConstraint.colorInput))),
            readOnly: true,
            onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    actions: [buildPickerForAdult()],
                    cancelButton: CupertinoActionSheetAction(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                )));
  }

  Expanded _amountChildrenField(BuildContext context) {
    return Expanded(
        child: CupertinoTextField(
            controller: _childrenAmount,
            suffix: const Text('Child',
                style: TextStyle(color: AppConstraint.colorIcon)),
            prefix:
                const Icon(Icons.child_care, color: AppConstraint.colorIcon),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppConstraint.colorInput))),
            readOnly: true,
            onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    actions: [buildPickerForChildren()],
                    cancelButton: CupertinoActionSheetAction(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                )));
  }

  Expanded _amountBabyField(BuildContext context) {
    return Expanded(
        child: CupertinoTextField(
            controller: _babyAmount,
            suffix: const Text('Baby',
                style: TextStyle(color: AppConstraint.colorIcon)),
            prefix: const Icon(Icons.child_friendly,
                color: AppConstraint.colorIcon),
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: AppConstraint.colorInput))),
            readOnly: true,
            onTap: () => showCupertinoModalPopup(
                  context: context,
                  builder: (context) => CupertinoActionSheet(
                    actions: [buildPickerForBaby()],
                    cancelButton: CupertinoActionSheetAction(
                      child: const Text('Cancel'),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                )));
  }

  Widget buildPickerForBaby() => SizedBox(
        height: 350,
        child: CupertinoPicker(
            itemExtent: 64,
            onSelectedItemChanged: (value) => setState(() {
                  _babyAmount.text = value.toString();
                }),
            children: List<Widget>.generate(_amountList.length, (int index) {
              return Center(
                  child: Text(
                _amountList[index],
                style: const TextStyle(fontSize: 35),
              ));
            })),
      );

  Widget buildPickerForChildren() => SizedBox(
        height: 350,
        child: CupertinoPicker(
            itemExtent: 64,
            onSelectedItemChanged: (value) => setState(() {
                  _childrenAmount.text = value.toString();
                }),
            children: List<Widget>.generate(_amountList.length, (int index) {
              return Center(
                  child: Text(
                _amountList[index],
                style: const TextStyle(fontSize: 35),
              ));
            })),
      );

  Widget buildPickerForAdult() => SizedBox(
        height: 350,
        child: CupertinoPicker(
            itemExtent: 64,
            onSelectedItemChanged: (value) => setState(() {
                  _adultAmount.text = value.toString();
                }),
            children: List<Widget>.generate(_amountList.length, (int index) {
              return Center(
                  child: Text(
                _amountList[index],
                style: const TextStyle(fontSize: 35),
              ));
            })),
      );

  Expanded _returnDate() {
    return Expanded(
        flex: 1,
        child: TextField(
          controller: _returnInput,
          readOnly: true,
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConstraint.colorInput)),
              labelText: 'Return',
              labelStyle: TextStyle(color: AppConstraint.colorLabel),
              prefixIcon: Icon(Icons.calendar_month),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConstraint.mainColor))),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030));
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                _returnInput.text =
                    formattedDate; //set output date to TextField value.
              });
            } else {}
          },
        ));
  }

  Expanded _departDate() {
    return Expanded(
        flex: 1,
        child: TextField(
          controller: _departInput,
          readOnly: true,
          decoration: const InputDecoration(
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConstraint.colorInput)),
              labelText: 'Depart',
              labelStyle: TextStyle(color: AppConstraint.colorLabel),
              prefixIcon: Icon(Icons.calendar_month),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppConstraint.mainColor))),
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030));
            if (pickedDate != null) {
              String formattedDate =
                  DateFormat('yyyy-MM-dd').format(pickedDate);
              setState(() {
                _departInput.text = formattedDate;
              });
            }
          },
        ));
  }

  Widget _radioButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Radio(
                value: _lstOptionRadio[0],
                groupValue: _selectedRadio,
                activeColor: AppConstraint.mainColor,
                onChanged: (value) {
                  setState(() {
                    _selectedRadio = value.toString();
                  });
                },
              ),
              Text(
                _lstOptionRadio[0],
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Radio(
                value: _lstOptionRadio[1],
                groupValue: _selectedRadio,
                activeColor: AppConstraint.mainColor,
                onChanged: (value) {
                  setState(() {
                    _selectedRadio = value.toString();
                  });
                },
              ),
              Text(
                _lstOptionRadio[1],
                style:
                    const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ],
    );
  }

  DropdownSearch<SeatClassModel> _dropDownSeatClass() {
    return DropdownSearch<SeatClassModel>(
      itemAsString: (SeatClassModel u) => '${u.sTcName!}',
      selectedItem: _seatSelected,
      popupProps: const PopupProps.modalBottomSheet(
        showSelectedItems: false,
      ),
      items: lstClass,
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.colorInput)),
            labelText: 'Seat class',
            labelStyle: TextStyle(color: AppConstraint.colorLabel),
            prefixIcon: Icon(Icons.flight_class),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.mainColor))),
      ),
      onChanged: (value) => {
        setState(() {
          _seatClass = value!.iTcId;
        })
      },
    );
  }

  DropdownSearch<AirportModel> _dropDownSearchFrom() {
    return DropdownSearch<AirportModel>(
      itemAsString: (AirportModel u) => '${u.sApFullName!} - ${u.sCtName}',
      selectedItem: _airportFrom,
      popupProps: const PopupProps.modalBottomSheet(
        searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
                labelStyle: TextStyle(color: AppConstraint.colorLabel),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.colorInput)),
                labelText: 'Country / City or Aitport code',
                prefixIcon: Icon(Icons.flight),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.mainColor)))),
        showSearchBox: true,
        showSelectedItems: false,
      ),
      items: lstAir,
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.colorInput)),
            labelText: 'From',
            labelStyle: TextStyle(color: AppConstraint.colorLabel),
            prefixIcon: Icon(Icons.flight_takeoff),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.mainColor))),
      ),
      onChanged: (value) => {
        setState(() {
          airFromSelected = value!.iApId;
          _airportFrom = value;
        })
      },
    );
  }

  DropdownSearch<AirportModel> _dropDownSearchTo() {
    return DropdownSearch<AirportModel>(
      itemAsString: (AirportModel u) => '${u.sApFullName!} - ${u.sCtName}',
      selectedItem: _airportTo,
      popupProps: const PopupProps.modalBottomSheet(
        searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
                labelStyle: TextStyle(color: AppConstraint.colorLabel),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.colorInput)),
                labelText: 'Country / City or Aitport code',
                prefixIcon: Icon(Icons.flight),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.mainColor)))),
        showSearchBox: true,
        showSelectedItems: false,
      ),
      items: lstAir,
      dropdownDecoratorProps: const DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.colorInput)),
            labelText: 'To',
            labelStyle: TextStyle(color: AppConstraint.colorLabel),
            prefixIcon: Icon(Icons.flight_land),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppConstraint.mainColor))),
      ),
      onChanged: (value) => {
        setState(() {
          airToSelected = value!.iApId;
          _airportTo = value;
          print(airToSelected);
        })
      },
    );
  }
}
