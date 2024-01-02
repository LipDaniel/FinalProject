// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, unused_local_variable, prefer_const_constructors, must_be_immutable

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
        backgroundColor: AppConstraint.mainColor,
        elevation: 0,
        title: Text(
          'Tickets'.toUpperCase(),
          style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontFamily: AppConstraint.fontFamilyBold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text('Upcoming flighs',
                  style: TextStyle(
                      fontFamily: AppConstraint.fontFamilyRegular,
                      fontSize: 16,
                      fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              ...widget.ticketList
                  .where((item) => item.lTickets!.isNotEmpty)
                  .map((item) {
                return _ticketItem(item);
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

  Container _ticketItem(TicketsModel data) {
    List<DataRow> dataRows = [];
    if (data.lTickets!.isNotEmpty) {
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
    }
    String priced = NumberFormat.currency(
      symbol: '', // Currency symbol (optional)
      decimalDigits: 0, // Number of decimal digits (optional)
    ).format(data.iBilPayment);

    DateFormat dateFormat = DateFormat("HH:mm a");
    String timeFrom = dateFormat
        .format(DateTime.parse(data.bBilFlight!.sFlTakeOff as String));
    String timeTo = dateFormat
        .format(DateTime.parse(data.bBilFlight!.sFlArrival as String));
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
                    Text(data.bBilFlight!.sCarName!,
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(DateFormat.yMMMMEEEEd().format(
                        DateTime.parse(data.bBilFlight!.sFlTakeOff as String)))
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
                    Text(
                        '${data.bBilFlight!.sFlFromName}, ${data.bBilFlight!.sCtFromName}'),
                    Text('${data.bBilFlight!.sFlFromAbbreviation}',
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
                    Text(
                        '${data.bBilFlight!.sFlToName}, ${data.bBilFlight!.sCtToName}'),
                    Text('${data.bBilFlight!.sFlToAbbreviation}',
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
                _flightInfo('Flight', data.bBilFlight!.sPlCode.toString()),
                _flightInfo('Gate', getFirstTicketSeat(data)),
                _flightInfo('Amount', data.lTickets!.length.toString()),
                _flightInfo('Class', data.bBilFlight!.sTcName.toString()),
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
                    columnSpacing: 30,
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
    DateTime dob = DateTime.parse(dateOfBirthString.replaceAll('-', ''));
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
}
