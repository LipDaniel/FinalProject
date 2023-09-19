import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projectsem4/View/home/widgets/header_widget.dart';
import 'package:projectsem4/constraint.dart';
import 'package:dropdown_search/dropdown_search.dart';

const List<String> _amountList = <String>['0', '1', '2', '3', '4'];
const List<String> _seatClassList = <String>['Economy', 'Special economy', 'Business','First class'];

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> lstOptionRadio = ['One way', 'Round trip'];

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _adultAmount = TextEditingController();
  final TextEditingController _childrenAmount = TextEditingController();
  final TextEditingController _babyAmount = TextEditingController();

  List<String> airportLs = ['Brazil', 'Motecalo', 'Monaco', 'Maldives'];

  double calculateFormHeight(screen, header, bottom) {
    return (screen - header - bottom) - 10;
  }

  @override
  void initState() {
    super.initState();
    _adultAmount.text = "0";
    _childrenAmount.text = "0";
    _babyAmount.text = "0";
  }

  String selectedRadio = lstOptionRadio[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [Container(), const HeaderHomeWidget(), _searchForm(context)],
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              __radioButton(),
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
                            onPressed: () => {}),
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
    return const Expanded(
        flex: 1,
        child: TextField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.colorInput)),
                labelText: 'Return',
                labelStyle: TextStyle(color: AppConstraint.colorLabel),
                prefixIcon: Icon(Icons.calendar_month),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.mainColor)))));
  }

  Expanded _departDate() {
    return const Expanded(
        flex: 1,
        child: TextField(
            decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.colorInput)),
                labelText: 'Depart',
                labelStyle: TextStyle(color: AppConstraint.colorLabel),
                prefixIcon: Icon(Icons.calendar_month),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: AppConstraint.mainColor)))));
  }

  Widget __radioButton() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 2,
          child: Row(
            children: [
              Radio(
                value: lstOptionRadio[0],
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value.toString();
                  });
                },
              ),
              Text(
                lstOptionRadio[0],
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
                value: lstOptionRadio[1],
                groupValue: selectedRadio,
                onChanged: (value) {
                  setState(() {
                    selectedRadio = value.toString();
                  });
                },
              ),
              Text(
                lstOptionRadio[1],
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
      items: airportLs,
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
      onChanged: print,
    );
  }

  DropdownSearch<String> _dropDownSearchTo() {
    return DropdownSearch<String>(
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
      items: airportLs,
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
      onChanged: print,
    );
  }
}
