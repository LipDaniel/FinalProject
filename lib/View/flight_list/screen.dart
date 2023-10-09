// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/flight_model.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/View/choose_seat/choose_seat_screen.dart';

class FlightListScreen extends StatefulWidget {
  const FlightListScreen({super.key, required this.data, required this.model});
  final List<FlightModel> data;
  final BusinessModel model;
  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  final List<String> _amountList = ['0', '1', '2', '3', '4'];
  final List<String> _lstOptionRadio = ['One way', 'Round trip'];
  final List<String> _airportLs = ['Brazil', 'Motecalo', 'Monaco', 'Maldives'];
  final List<String> _seatClassList = [
    'Economy',
    'Special economy',
    'Business',
    'First class'
  ];
  final TextEditingController _adultAmount = TextEditingController();
  final TextEditingController _childrenAmount = TextEditingController();
  final TextEditingController _babyAmount = TextEditingController();
  final TextEditingController _departInput = TextEditingController();
  final TextEditingController _returnInput = TextEditingController();
  String? _airportFrom;
  String? _airportTo;
  String? _selectedRadio;

  void swapAirPort() {
    setState(() {
      String? tmp = _airportFrom;
      _airportFrom = _airportTo;
      _airportTo = tmp;
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedRadio = _lstOptionRadio[0];
    _adultAmount.text = "0";
    _childrenAmount.text = "0";
    _babyAmount.text = "0";
    _babyAmount.text = "0";
    _departInput.text = "";
    _returnInput.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        // leading: const Icon(Icons.arrow_back),
        leadingWidth: 15,
        automaticallyImplyLeading: true,
        backgroundColor: AppConstraint.mainColor,
        title: _flightinfo(context),
      ),
      body: ListView.builder(
        itemCount: widget.data.length,
        itemBuilder: (context, index) {
          final item = widget.data[index];
          String price = NumberFormat.currency(
            symbol: '', // Currency symbol (optional)
            decimalDigits: 0, // Number of decimal digits (optional)
          ).format(item.iSellPrice);
          DateFormat dateFormat = DateFormat("HH:mm");
          String timeFrom =
              dateFormat.format(DateTime.parse(item.sFlTakeOff as String));
          String timeTo =
              dateFormat.format(DateTime.parse(item.sFlArrival as String));
          return _flightItem(
              timeFrom,
              timeTo,
              item.sFlFromAbbreviation,
              item.sFlToAbbreviation,
              "Economy Class",
              '$price đ',
              item.sCarName,
              "4h20p");
        },
      ),
    );
  }

  Container _searchForm(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.65,
      decoration: const BoxDecoration(
          color: Colors.white,
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
                onPressed: () {},
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
    );
  }

  Container _flightItem(
      timeFrom, timeTo, from, to, seatClass, price, airlines, flightTime) {
    return Container(
        decoration: BoxDecoration(
            color: AppConstraint.colorSlogan,
            border: Border.all(color: AppConstraint.colorBox, width: 0.5)),
        height: 120,
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            Route route = MaterialPageRoute(
                builder: (context) => const ChooseSeetScreen());
            Navigator.push(context, route);
          },
          child: Column(
            children: [
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.asset('assets/image/logo-airline.png', width: 35),
                  const SizedBox(width: 10),
                  Column(children: [
                    Text(
                      timeFrom,
                      style: const TextStyle(
                          fontFamily: AppConstraint.fontFamilyBold,
                          fontSize: 20,
                          letterSpacing: 2),
                    ),
                    Text(
                      from,
                      style: const TextStyle(fontSize: 17, letterSpacing: 2),
                    )
                  ]),
                  const SizedBox(width: 10),
                  Column(
                    children: [
                      Image.asset('assets/image/arrow.png',
                          width: 60, height: 25, fit: BoxFit.fill),
                      Text(flightTime,
                          style: const TextStyle(
                              color: AppConstraint.colorLabel, fontSize: 11))
                    ],
                  ),
                  const SizedBox(width: 10),
                  Column(children: [
                    Text(
                      timeTo,
                      style: const TextStyle(
                          fontFamily: AppConstraint.fontFamilyBold,
                          fontSize: 20,
                          letterSpacing: 2),
                    ),
                    Text(
                      to,
                      style: const TextStyle(fontSize: 17, letterSpacing: 2),
                    )
                  ]),
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      Text(seatClass,
                          style:
                              const TextStyle(color: AppConstraint.colorLabel)),
                      Text(price,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 217, 111, 104),
                              fontFamily: AppConstraint.fontFamilyBold,
                              fontSize: 18))
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Text("Operated by $airlines",
                  style: const TextStyle(color: AppConstraint.colorLabel))
            ],
          ),
        ));
  }

  InkWell _flightinfo(BuildContext context) {
    return InkWell(
      onTap: () => {
        showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                  insetAnimationDuration: const Duration(milliseconds: 300),
                  insetAnimationCurve: Curves.easeInCirc,
                  backgroundColor: Colors.transparent,
                  child: _searchForm(context));
              //
            })
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                widget.model.airport_from_code.toString(),
                style: const TextStyle(
                    fontFamily: AppConstraint.fontFamilyBold, fontSize: 27),
              ),
              Text(
                widget.model.country_from_name.toString(),
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
          const SizedBox(width: 5),
          const Icon(Icons.arrow_right_alt),
          const SizedBox(width: 5),
          Column(
            children: [
              Text(widget.model.airport_to_code.toString(),
                  style: const TextStyle(
                      fontFamily: AppConstraint.fontFamilyBold, fontSize: 27)),
              Text(widget.model.country_to_name.toString(),
                  style: const TextStyle(fontSize: 15))
            ],
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              Text(
                  DateFormat.yMMMEd().format(
                      DateTime.parse(widget.model.depart_date as String)),
                  style: const TextStyle(
                      fontFamily: AppConstraint.fontFamilyBold, fontSize: 20)),
              Text(
                  widget.model.adult_amount.toString() +
                      ' Adult, ' +
                      widget.model.children_amount.toString() +
                      " Children, " +
                      widget.model.baby_amount.toString() +
                      ' Baby',
                  style: const TextStyle(fontSize: 12))
            ],
          )
        ],
      ),
    );
  }

  Expanded _amountAdultField(BuildContext context) {
    return Expanded(
        child: CupertinoTextField(
            controller: _adultAmount,
            suffix: const Text('Adult',
                style: TextStyle(color: AppConstraint.colorIcon, fontSize: 12)),
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
                style: TextStyle(color: AppConstraint.colorIcon, fontSize: 12)),
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
                style: TextStyle(color: AppConstraint.colorIcon, fontSize: 12)),
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
                  DateFormat('dd-MM-yyyy').format(pickedDate);
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
                  DateFormat('dd-MM-yyyy').format(pickedDate);
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

  DropdownSearch<String> _dropDownSeatClass() {
    return DropdownSearch<String>(
      popupProps: const PopupProps.modalBottomSheet(
        showSelectedItems: true,
      ),
      items: _seatClassList,
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
      onChanged: print,
    );
  }

  DropdownSearch<String> _dropDownSearchFrom() {
    return DropdownSearch<String>(
      selectedItem: _airportFrom,
      popupProps: const PopupProps.modalBottomSheet(
        searchFieldProps: TextFieldProps(
            autofocus: true,
            decoration: InputDecoration(
                labelStyle: TextStyle(color: AppConstraint.colorLabel),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.colorInput)),
                labelText: 'Country / City or Aitport code',
                prefixIcon: Icon(Icons.flight),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.mainColor)))),
        showSearchBox: true,
        showSelectedItems: true,
      ),
      items: _airportLs,
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
          _airportFrom = value;
        })
      },
    );
  }

  DropdownSearch<String> _dropDownSearchTo() {
    return DropdownSearch<String>(
      selectedItem: _airportTo,
      popupProps: const PopupProps.modalBottomSheet(
        searchFieldProps: TextFieldProps(
            autofocus: true,
            decoration: InputDecoration(
                labelStyle: TextStyle(color: AppConstraint.colorLabel),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.colorInput)),
                labelText: 'Country / City or Aitport code',
                prefixIcon: Icon(Icons.flight),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.mainColor)))),
        showSearchBox: true,
        showSelectedItems: true,
      ),
      items: _airportLs,
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
          _airportTo = value;
        })
      },
    );
  }
}
