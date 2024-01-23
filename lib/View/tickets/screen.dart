// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, unused_local_variable, prefer_const_constructors, must_be_immutable, unused_element, dead_code

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:projectsem4/model/ticket_model.dart';
import 'package:projectsem4/ulits/constraint.dart';

class TicketsScreen extends StatefulWidget {
  TicketsScreen({super.key, required this.ticketList});
  List<TicketsModel> ticketList;

  @override
  State<TicketsScreen> createState() => _TicketsScreenState();
}

class _TicketsScreenState extends State<TicketsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: AppConstraint.mainColor,
        elevation: 0,
        title: Text(
          'Tickets'.toUpperCase(),
          style: const TextStyle(
              fontSize: 16, fontFamily: AppConstraint.fontFamilyBold),
        ),
      ),
      body: widget.ticketList.isEmpty
          ? _buildEmptyState()
          : SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text('Upcoming flighs',
                        style: TextStyle(
                            fontFamily: AppConstraint.fontFamilyRegular,
                            fontSize: 16,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 10),
                    ...widget.ticketList
                        .where((item) => item.lTickets!.isNotEmpty)
                        .expand<Widget>((item) {
                      if (item.lTickets!.length > 1) {
                        if (item.lTickets![0].sTkFlightId ==
                            item.lTickets![item.lTickets!.length - 1]
                                .sTkFlightId) {
                          return [_ticketItem(item, isRoundtrip: false)];
                        } else {
                          return [
                            _ticketItem(item,
                                isRoundtrip: true, departOrReturn: 'depart'),
                            _ticketItem(item,
                                isRoundtrip: true, departOrReturn: 'return')
                          ];
                        }
                      }
                      return [_ticketItem(item, isRoundtrip: false)];
                    }).toList(),
                    const SizedBox(
                      height: 120,
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Container _ticketItem(TicketsModel data,
      {bool? isRoundtrip, String? departOrReturn}) {
    List<DataRow> dataRows = [];

    if (data.lTickets!.isNotEmpty) {
      if (isRoundtrip == false) {
        dataRows = data.lTickets!.map((item) {
          return DataRow(cells: [
            DataCell(Text(item.sTkFullName.toString())),
            DataCell(Text(item.nTkDob == null
                ? '18'
                : calculateAge(item.nTkDob).toString())),
            DataCell(Text((item.iTkChecked! + item.iTkCabin!).toString())),
            DataCell(Text(item.sTkSeat.toString())),
          ]);
        }).toList();
      } else {
        int halfLength = data.lTickets!.length ~/ 2;
        var halfList = departOrReturn == 'depart'
            ? data.lTickets!.sublist(0, halfLength)
            : data.lTickets!.sublist(halfLength);
        dataRows = halfList.map((item) {
          return DataRow(cells: [
            DataCell(Text(item.sTkFullName.toString())),
            DataCell(Text(item.nTkDob == null
                ? '18'
                : calculateAge(item.nTkDob).toString())),
            DataCell(Text((item.iTkChecked! + item.iTkCabin!).toString())),
            DataCell(Text(item.sTkSeat.toString())),
          ]);
        }).toList();
      }
    }

    double totalPrice = 0;
    if (isRoundtrip == true) {
      int halfLength = data.lTickets!.length ~/ 2;
      if (data.lTickets!.length == 2) {
        if (departOrReturn == 'depart') {
          totalPrice = data.lTickets![0].sTkPayment!;
        } else {
          totalPrice = data.lTickets![1].sTkPayment!;
        }
      } else {
        if (departOrReturn == 'depart') {
          var halfList = data.lTickets!.sublist(0, halfLength);
          totalPrice = halfList.fold(
            0,
            (previousValue, element) =>
                previousValue + (element.sTkPayment as double),
          );
        } else {
          var halfList = data.lTickets!.sublist(halfLength);
          totalPrice = halfList.fold(
            0,
            (previousValue, element) =>
                previousValue + (element.sTkPayment as double),
          );
        }
      }
    } else {
      totalPrice = data.iBilPayment!;
    }

    String priced = NumberFormat.currency(
      symbol: '', // Currency symbol (optional)
      decimalDigits: 0, // Number of decimal digits (optional)
    ).format(totalPrice);

    DateFormat dateFormat = DateFormat("HH:mm a");

    String timeFrom = dateFormat.format(DateTime.parse(isRoundtrip == true
        ? departOrReturn == 'depart'
            ? data.lTickets![0].bBilFlight!.sFlTakeOff as String
            : data.lTickets![data.lTickets!.length - 1].bBilFlight!.sFlTakeOff
                as String
        : data.lTickets![0].bBilFlight!.sFlTakeOff as String));

    String timeTo = dateFormat.format(DateTime.parse(isRoundtrip == true
        ? departOrReturn == 'depart'
            ? data.lTickets![0].bBilFlight!.sFlArrival as String
            : data.lTickets![data.lTickets!.length - 1].bBilFlight!.sFlArrival
                as String
        : data.lTickets![0].bBilFlight!.sFlArrival as String));

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 1)
          ],
          borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        isRoundtrip == true
                            ? departOrReturn == 'depart'
                                ? data.lTickets![0].bBilFlight!.sCarName
                                    as String
                                : data.lTickets![data.lTickets!.length - 1]
                                    .bBilFlight!.sCarName as String
                            : data.lTickets![0].bBilFlight!.sCarName as String,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(DateFormat.yMMMMEEEEd().format(DateTime.parse(
                        isRoundtrip == true
                            ? departOrReturn == 'depart'
                                ? data.lTickets![0].bBilFlight!.sFlTakeOff
                                    as String
                                : data.lTickets![data.lTickets!.length - 1]
                                    .bBilFlight!.sFlTakeOff as String
                            : data.lTickets![0].bBilFlight!.sFlTakeOff
                                as String)))
                  ],
                ),
                Image.asset(
                  'assets/image/logo-airline.png',
                  height: 40,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(isRoundtrip == true
                        ? departOrReturn == 'depart'
                            ? '${data.lTickets![0].bBilFlight!.sFlFromName}, ${data.lTickets![0].bBilFlight!.sCtFromName}'
                            : '${data.lTickets![data.lTickets!.length - 1].bBilFlight!.sFlFromName}, ${data.lTickets![data.lTickets!.length - 1].bBilFlight!.sCtFromName}'
                        : '${data.lTickets![0].bBilFlight!.sFlFromName}, ${data.lTickets![0].bBilFlight!.sCtFromName}'),
                    Text(
                        isRoundtrip == true
                            ? departOrReturn == 'depart'
                                ? '${data.lTickets![0].bBilFlight!.sFlFromAbbreviation}'
                                : '${data.lTickets![data.lTickets!.length - 1].bBilFlight!.sFlFromAbbreviation}'
                            : '${data.lTickets![0].bBilFlight!.sFlFromAbbreviation}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Text(timeFrom),
                  ],
                ),
                Image.asset(
                  'assets/image/arrow.png',
                  height: 40,
                ),
                Column(
                  children: [
                    Text(isRoundtrip == true
                        ? departOrReturn == 'depart'
                            ? '${data.lTickets![0].bBilFlight!.sFlToName}, ${data.lTickets![0].bBilFlight!.sCtToName}'
                            : '${data.lTickets![data.lTickets!.length - 1].bBilFlight!.sFlToName}, ${data.lTickets![data.lTickets!.length - 1].bBilFlight!.sCtToName}'
                        : '${data.lTickets![0].bBilFlight!.sFlToName}, ${data.lTickets![0].bBilFlight!.sCtToName}'),
                    Text(
                        isRoundtrip == true
                            ? departOrReturn == 'depart'
                                ? '${data.lTickets![0].bBilFlight!.sFlToAbbreviation}'
                                : '${data.lTickets![data.lTickets!.length - 1].bBilFlight!.sFlToAbbreviation}'
                            : '${data.lTickets![0].bBilFlight!.sFlToAbbreviation}',
                        style: const TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
                    Text(timeTo),
                  ],
                )
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _flightInfo(
                    'Flight',
                    isRoundtrip == true
                        ? departOrReturn == 'depart'
                            ? '${data.lTickets![0].bBilFlight!.sPlCode}'
                            : '${data.lTickets![data.lTickets!.length - 1].bBilFlight!.sPlCode}'
                        : '${data.lTickets![0].bBilFlight!.sPlCode}'),
                _flightInfo(
                    'Gate',
                    isRoundtrip == true
                        ? departOrReturn == 'depart'
                            ? '${data.lTickets![0].iTkGate}'
                            : '${data.lTickets![data.lTickets!.length - 1].iTkGate}'
                        : '${data.lTickets![0].iTkGate}'),
                _flightInfo(
                    'Amount',
                    isRoundtrip == true
                        ? '${data.lTickets!.length ~/ 2}'
                        : data.lTickets!.length.toString()),
                _flightInfo(
                    'Class',
                    isRoundtrip == true
                        ? departOrReturn == 'depart'
                            ? '${data.lTickets![0].sTcName}'
                            : '${data.lTickets![data.lTickets!.length - 1].sTcName}'
                        : '${data.lTickets![0].sTcName}'),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Color.fromARGB(255, 227, 227, 227),
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent, // Hides the default divider
              ),
              child: Container(
                width: double.infinity,
                child: DataTable(
                    // ignore: deprecated_member_use
                    dataRowHeight: 30.0,
                    headingRowHeight: 30.0,
                    dividerThickness: 0.0,
                    columnSpacing: 20,
                    columns: const [
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Name',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Age',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Baggage',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                      DataColumn(
                        label: Expanded(
                          child: Text(
                            'Seat',
                            style: TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ),
                      ),
                    ],
                    rows: dataRows),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
              decoration: BoxDecoration(
                  color: AppConstraint.mainColor,
                  borderRadius: BorderRadius.circular(40)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/image/visa.png',
                    height: 30,
                  ),
                  Text('$priced VND',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getFirstTicketSeat(TicketsModel data) {
    if (data.lTickets != null && data.lTickets!.isNotEmpty) {
      return data.lTickets![0].sTkSeat.toString();
    } else {
      return 'A3';
    }
  }

  int calculateAge(String dateOfBirthString) {
    DateFormat format = DateFormat('dd-MM-yyyy');
    DateTime dob = format.parse(dateOfBirthString);
    // Get the current date
    DateTime now = DateTime.now();
    // Calculate the difference between the current date and the date of birth
    int age = now.year - dob.year;

    // Adjust the age if the birthday hasn't occurred yet this year
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }

    return age;
  }

  Column _flightInfo(String title, String value) {
    return Column(
      children: [
        Text(title, style: TextStyle(color: AppConstraint.colorLabel)),
        Text(value,
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppConstraint.mainColor)),
      ],
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.airplane_ticket,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Empty ticket',
            style: TextStyle(
              fontFamily: AppConstraint.fontFamilyRegular,
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
