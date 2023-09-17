import 'package:flutter/material.dart';
import 'package:projectsem4/constraint.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:calendar_date_picker2/calendar_date_picker2.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedRadio = 1;
  List<DateTime?> _date = [
    DateTime(2021, 8, 10),
  ];
  List<String> airportLs = ['Brazil', 'Motecalo', 'Monaco', 'Maldives'];
  double calculateFormHeight(screen, header, bottom) {
    return (screen - header - bottom) - 10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height:
                MediaQuery.sizeOf(context).height - kBottomNavigationBarHeight,
          ),
          _header(context),
          _searchForm(context)
        ],
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
            color: Color.fromARGB(255, 255, 255, 255),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12, offset: Offset(5, 0), blurRadius: 10)
            ],
            borderRadius: BorderRadius.all(Radius.circular(40))),
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 30, bottom: 30),
          child: Column(
            children: [
              _radioButton(),

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

  Expanded _radioButton() {
    return Expanded(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: RadioListTile<int>(
            activeColor: AppConstraint.mainColor,
            title: const Text(
              "One way",
              style: TextStyle(fontSize: 13.0),
            ),
            value: 2,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
        ),
        Expanded(
          child: RadioListTile<int>(
            activeColor: AppConstraint.mainColor,
            title: const Text(
              "Round trip",
              style: TextStyle(fontSize: 13.0),
            ),
            value: 1,
            groupValue: selectedRadio,
            onChanged: (value) {
              setState(() {
                selectedRadio = value;
              });
            },
          ),
        ),
        // Expanded(child: SizedBox(width: 10))
      ],
    ));
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

  Container _header(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height * 0.33;
    return Container(
      height: height,
      decoration: const BoxDecoration(
          color: AppConstraint.mainColor,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40.0),
              bottomRight: Radius.circular(40.0))),
      padding: const EdgeInsets.all(20.0),
      child: Row(children: [
        const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Start',
                style: TextStyle(
                    fontSize: 80,
                    color: AppConstraint.colorSlogan,
                    fontWeight: FontWeight.bold,
                    textBaseline: TextBaseline.alphabetic,
                    height: 1.2)),
            Text(
              'Your Moment',
              style: TextStyle(
                  fontSize: 30,
                  color: AppConstraint.colorSubSlogan,
                  fontWeight: FontWeight.bold,
                  height: 1.0),
            ),
          ],
        ),
        const SizedBox(width: 10),
        Image.asset(
          'assets/image/flight.png',
          scale: 3.8,
        )
      ]),
    );
  }
}
