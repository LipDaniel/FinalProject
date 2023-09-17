import 'package:flutter/material.dart';
import 'package:projectsem4/View/home/widgets/header_widget.dart';
import 'package:projectsem4/constraint.dart';
import 'package:dropdown_search/dropdown_search.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

List<String> lstOptionRadio = ['One way', 'Round trip'];

class _HomeScreenState extends State<HomeScreen> {
  final List<DateTime?> date = [
    DateTime(2021, 8, 10),
  ];
  List<String> airportLs = ['Brazil', 'Motecalo', 'Monaco', 'Maldives'];
  double calculateFormHeight(screen, header, bottom) {
    return (screen - header - bottom) - 10;
  }

  String selectedRadio = lstOptionRadio[0];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [const HeaderHomeWidget(), _searchForm(context)],
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              __radioButton(),

              Expanded(
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
                        icon: const Icon(Icons.swap_vert), onPressed: () => {}),
                  ),
                ],
              )),
              const Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstraint.colorInput)),
                          hintText: 'Depart',
                          prefixIcon: Icon(Icons.calendar_month),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppConstraint.mainColor))))),
              const Expanded(
                  child: TextField(
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppConstraint.colorInput)),
                          hintText: 'Return',
                          prefixIcon: Icon(Icons.calendar_month),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: AppConstraint.mainColor))))),

              ElevatedButton(
                onPressed: () {},
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(AppConstraint.mainColor)),
                child: const Text('Find',
                    style: TextStyle(color: AppConstraint.colorSlogan)),
              ),
              // CalendarDatePicker2(
              //   config: CalendarDatePicker2Config(),
              //   value: _date,
              //   onValueChanged: (dates) => _date = dates,
              // )
              // Expanded(child: Bottom),
            ],
          ),
        ),
      ),
    );
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
