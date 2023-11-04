// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:projectsem4/model/business_model.dart';
import 'package:projectsem4/model/airport_model.dart';
import 'package:projectsem4/model/flightinfo_model.dart';
import 'package:projectsem4/model/seat_model.dart';
import 'package:projectsem4/model/seatclass_model.dart';
import 'package:projectsem4/model/flight_model.dart';
import 'package:projectsem4/repository/flight_repo.dart';
import 'package:projectsem4/services/api_service.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/View/choose_seat/choose_seat_screen.dart';

class FlightListScreen extends StatefulWidget {
  FlightListScreen(
      {super.key,
      required this.data,
      required this.model,
      required this.airportLst,
      required this.seatLst});
  List<FlightModel> data = [];
  List<AirportModel> airportLst = [];
  List<SeatClassModel> seatLst = [];
  BusinessModel model = BusinessModel();
  @override
  State<FlightListScreen> createState() => _FlightListScreenState();
}

class _FlightListScreenState extends State<FlightListScreen> {
  final List<String> _amountList = ['0', '1', '2', '3', '4'];
  final TextEditingController _adultAmount = TextEditingController();
  final TextEditingController _childrenAmount = TextEditingController();
  final TextEditingController _babyAmount = TextEditingController();
  final TextEditingController _departInput = TextEditingController();
  int? _airFromSelected;
  int? _airToSelected;
  int? _seatClass;
  AirportModel? _airportFrom;
  AirportModel? _airportTo;
  List<AirportModel> lstAir = [];
  List<SeatClassModel> lstClass = [];
  String? tmpApCountryFrom;
  String? tmpApCodeFrom;
  String? tmpApCountryTo;
  String? tmpApCodeTo;
  String? tmpSeat;

  void handleSearchFlight() async {
    if (int.parse(_adultAmount.text) == 0) {
      AppConstraint.errorToast("At least 1 adult");
      return;
    }
    int amountPassenger = int.parse(_babyAmount.text) +
        int.parse(_adultAmount.text) +
        int.parse(_childrenAmount.text);

    await EasyLoading.show();
    final Map<String, dynamic> body = {
      "_fl_from_id": _airFromSelected,
      "_fl_to_id": _airToSelected,
      "_fl_take_off": _departInput.text,
      "_fl_return_date": null,
      "_tc_id": _seatClass,
      "_pas_quantity": amountPassenger
    };
    // return;
    var response = await FlightRepository.getFlight(body);
    if (response.length != 0) {
      // CREATE MODEL
      BusinessModel newModel = BusinessModel();
      newModel.airport_from_id = _airFromSelected;
      newModel.airport_to_id = _airToSelected;
      newModel.adult_amount = int.parse(_adultAmount.text);
      newModel.children_amount = int.parse(_childrenAmount.text);
      newModel.baby_amount = int.parse(_babyAmount.text);
      newModel.depart_date = _departInput.text;
      newModel.seatclass_id = _seatClass;
      newModel.country_to_name = tmpApCountryTo ?? widget.model.country_to_name;
      newModel.airport_to_code = tmpApCodeTo ?? widget.model.airport_to_code;
      newModel.country_from_name =
          tmpApCountryFrom ?? widget.model.country_from_name;
      newModel.airport_from_code =
          tmpApCodeFrom ?? widget.model.airport_from_code;
      newModel.seatclass = tmpSeat ?? widget.model.seatclass;

      EasyLoading.dismiss();

      setState(() {
        widget.data = response;
        widget.model = newModel;
        widget.airportLst = lstAir;
        widget.seatLst = lstClass;
      });
      Navigator.of(context, rootNavigator: true).pop('dialog');
    } else {
      AppConstraint.errorToast("No data founds");
      EasyLoading.dismiss();
    }
  }

  void swapAirPort() {
    setState(() {
      AirportModel? tmp = _airportFrom;
      _airportFrom = _airportTo;
      _airportTo = tmp;
    });
  }

  void handleChooseSeat(
      int id, String timeFrom, String timeTo, String airLine) async {
    EasyLoading.show();
    Map<String, dynamic> request = {
      '_fl_id': id,
      '_tc_id': widget.model.seatclass_id
    };
    FlightInfoModel response = await FlightRepository.getSeatList(request);
    if (response != null) {
      widget.model.fl_id = id;
      widget.model.plane_code = response.sPlCode;
      widget.model.plane_name = response.sPtName;
      widget.model.time_from = timeFrom;
      widget.model.time_to = timeTo;
      widget.model.airline = airLine;
      Route route = MaterialPageRoute(
          builder: (context) => ChooseSeetScreen(
              model: widget.model, data: response.lFlSeats as List<SeatModel>));
      Navigator.push(context, route);
      EasyLoading.dismiss();
    } else {
      AppConstraint.errorToast("Something wrong in server");
      EasyLoading.dismiss();
    }
  }

  @override
  void initState() {
    super.initState();
    lstAir = widget.airportLst;
    lstClass = widget.seatLst;

    _airFromSelected = lstAir
        .firstWhere((element) => element.iApId == widget.model.airport_from_id)
        .iApId;
    _airToSelected = lstAir
        .firstWhere((element) => element.iApId == widget.model.airport_to_id)
        .iApId;
    _seatClass = lstClass
        .firstWhere((element) => element.iTcId == widget.model.seatclass_id)
        .iTcId;

    _adultAmount.text = widget.model.adult_amount.toString();
    _childrenAmount.text = widget.model.children_amount.toString();
    _babyAmount.text = widget.model.baby_amount.toString();
    _departInput.text = widget.model.depart_date.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        leading: const Icon(Icons.arrow_back),
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
              item.iFlId,
              timeFrom,
              timeTo,
              item.sFlFromAbbreviation,
              item.sFlToAbbreviation,
              widget.model.seatclass.toString(),
              '$price đ',
              item.sCarName,
              "4h20p");
        },
      ),
    );
  }

  Container _searchForm(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.55,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Column(
          children: [
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
    );
  }

  Container _flightItem(
      id, timeFrom, timeTo, from, to, seatClass, price, airlines, flightTime) {
    return Container(
        decoration: BoxDecoration(
            color: AppConstraint.colorSlogan,
            border: Border.all(color: AppConstraint.colorBox, width: 0.5)),
        height: 120,
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () => handleChooseSeat(id, timeFrom, timeTo, airlines),
          child: Column(
            children: [
              Expanded(
                child: Row(
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
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        Text(seatClass,
                            style: const TextStyle(
                                color: AppConstraint.colorLabel, fontSize: 12)),
                        Text(price,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 217, 111, 104),
                                fontFamily: AppConstraint.fontFamilyBold,
                                fontSize: 18))
                      ],
                    ),
                  ],
                ),
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
                initialDate:
                    DateTime.parse(widget.model.depart_date.toString()),
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      colorScheme: const ColorScheme.light(
                          primary: AppConstraint.mainColor),
                    ),
                    child: child!,
                  );
                });
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

  DropdownSearch<SeatClassModel> _dropDownSeatClass() {
    return DropdownSearch<SeatClassModel>(
      itemAsString: (SeatClassModel u) => u.sTcName!,
      selectedItem: lstClass
          .firstWhere((item) => item.iTcId == widget.model.seatclass_id),
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
          tmpSeat = value.sTcName != 'First Class' &&
                  value.sTcName != 'Special Economy'
              ? "${value.sTcName} Class"
              : value.sTcName;
        })
      },
    );
  }

  DropdownSearch<AirportModel> _dropDownSearchFrom() {
    return DropdownSearch<AirportModel>(
      itemAsString: (AirportModel u) => '${u.sApFullName!} - ${u.sCtName}',
      selectedItem: lstAir
          .firstWhere((item) => item.iApId == widget.model.airport_from_id),
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
          _airportFrom = value;
          _airFromSelected = value!.iApId;
          tmpApCountryFrom = value.sCtName;
          tmpApCodeFrom = value.sApAbbreviation;
        })
      },
    );
  }

  DropdownSearch<AirportModel> _dropDownSearchTo() {
    return DropdownSearch<AirportModel>(
      itemAsString: (AirportModel u) => '${u.sApFullName!} - ${u.sCtName}',
      selectedItem:
          lstAir.firstWhere((item) => item.iApId == widget.model.airport_to_id),
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
          _airportTo = value;
          _airToSelected = value!.iApId;
          tmpApCountryTo = value.sCtName;
          tmpApCodeTo = value.sApAbbreviation;
        })
      },
    );
  }
}
