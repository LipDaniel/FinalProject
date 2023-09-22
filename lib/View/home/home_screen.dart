import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectsem4/view/home/widgets/header_widget.dart';
import 'package:projectsem4/constraint.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  double calculateFormHeight(screen, header, bottom) {
    return (screen - header - bottom) - 10;
  }

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
      body: SingleChildScrollView(
        child: SizedBox(
          child: Stack(
            clipBehavior: Clip.none,
            children: [Container(), const HeaderHomeWidget(), _searchForm(context)],
          ),
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
