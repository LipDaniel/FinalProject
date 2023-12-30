import 'package:flutter/material.dart';
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
          automaticallyImplyLeading: false,
          title: const Text('Tickets',
              style: TextStyle(fontFamily: AppConstraint.fontFamilyBold)),
          backgroundColor: AppConstraint.mainColor,
        ),
        body: ListView(
          children: [
            _slideItem(),
            _slideItem(),
            _slideItem(),
            _slideItem(),
          ],
        ));
  }

  Slidable _slideItem() {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (a) {},
            backgroundColor: const Color.fromARGB(255, 74, 113, 220),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
          SlidableAction(
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (a) {},
            backgroundColor: const Color.fromARGB(255, 239, 10, 10),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: _notiItem(),
    );
  }

  InkWell _notiItem() {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: AppConstraint.colorSlogan,
            border: Border.all(color: AppConstraint.colorBox, width: 0.5)),
        height: 110,
        padding: const EdgeInsets.all(15.0),
        child: const Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.airplane_ticket_outlined,
                size: 35, color: AppConstraint.mainColor),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi Mr.Daniel, your trip is on 2 days count down. Please don't forget this attention. Wish you a safe journey !",
                    style: TextStyle(
                        fontFamily: AppConstraint.fontFamilyRegular,
                        color: Color.fromARGB(255, 74, 74, 74)),
                  ),
                  Text('3 hours ago',
                      style: TextStyle(color: AppConstraint.colorLabel))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
