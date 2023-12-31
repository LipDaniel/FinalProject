// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:projectsem4/View/confirm/widgets/info_widget.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TicketsScreen extends StatefulWidget {
  const TicketsScreen({super.key});

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
              Container(
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('VIETNAM ARILINES',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('Friday, 16th September, 2023')
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
                          const Column(
                            children: [
                              Text('Ha Noi, Viet Nam'),
                              Text('SGN',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Text('1:00 PM'),
                            ],
                          ),
                          Image.asset(
                            'assets/image/arrow.png',
                            height: 40,
                          ),
                          const Column(
                            children: [
                              Text('Pattaya, Thailand'),
                              Text('BER',
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                              Text('1:00 PM'),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Text('Flight',
                                  style: TextStyle(
                                      color: AppConstraint.colorLabel)),
                              Text('A173',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppConstraint.mainColor)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Gate',
                                  style: TextStyle(
                                      color: AppConstraint.colorLabel)),
                              Text('22',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppConstraint.mainColor)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Amount',
                                  style: TextStyle(
                                      color: AppConstraint.colorLabel)),
                              Text('2',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppConstraint.mainColor)),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Class',
                                  style: TextStyle(
                                      color: AppConstraint.colorLabel)),
                              Text('First Class',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: AppConstraint.mainColor)),
                            ],
                          ),
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
                          dividerColor:
                              Colors.transparent, // Hides the default divider
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
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Age',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Baggage',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                DataColumn(
                                  label: Expanded(
                                    child: Text(
                                      'Seat',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                              rows: const [
                                DataRow(
                                  cells: [
                                    DataCell(Text('Sarah')),
                                    DataCell(Text('19')),
                                    DataCell(Text('20 kg')),
                                    DataCell(Text('C1')),
                                  ],
                                ),
                                DataRow(
                                  cells: [
                                    DataCell(Text('Sarah')),
                                    DataCell(Text('19')),
                                    DataCell(Text('20 kg')),
                                    DataCell(Text('C2')),
                                  ],
                                ),
                              ]),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 8),
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
                            const Text('5.700.000 VND',
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
              ),
              const SizedBox(
                height: 120,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
