// ignore_for_file: must_be_immutable, void_checks

import 'package:projectsem4/model/notification_model.dart';
import 'package:flutter/material.dart';
import 'package:projectsem4/repository/noti_repo.dart';
import 'package:projectsem4/ulits/constraint.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({super.key, required this.notiList});
  List<NotificationModel>? notiList;
  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  String formatTimeDifference(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);

    // Calculate the difference between the current time and the given timestamp
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays > 0) {
      return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
    } else {
      return 'Just now';
    }
  }

  void handleDeleteNoti(int id) async {
    Map<String, dynamic> body = {"_noti_id": id, "_noti_status": 0};
    var response = await NotificationRepository.deleteNotification(body);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Notification',
              style: TextStyle(
                  fontFamily: AppConstraint.fontFamilyBold,
                  color: Colors.white)),
          backgroundColor: AppConstraint.mainColor,
        ),
        body: widget.notiList!.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                itemCount: widget.notiList!.length,
                itemBuilder: (BuildContext context, int index) {
                  return _slideItem(widget.notiList![index], index);
                },
              ));
  }

  Widget _slideItem(NotificationModel notification, int index) {
    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
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
            onPressed: (a) {
              setState(() {
                handleDeleteNoti(notification.iNotiId!);
                widget.notiList!.removeAt(index);
              });
            },
            backgroundColor: const Color.fromARGB(255, 239, 10, 10),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: _notiItem(notification),
    );
  }

  InkWell _notiItem(NotificationModel notification) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            color: AppConstraint.colorSlogan,
            border: Border.all(color: AppConstraint.colorBox, width: 0.5)),
        height: 115,
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.airplane_ticket_outlined,
                size: 35, color: AppConstraint.mainColor),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.sNotiDescription!,
                    style: const TextStyle(
                        fontFamily: AppConstraint.fontFamilyRegular,
                        color: Color.fromARGB(255, 74, 74, 74),
                        fontSize: 15),
                  ),
                  const SizedBox(height: 7),
                  Text(formatTimeDifference(notification.iNotiCreatedDate!),
                      style: const TextStyle(color: AppConstraint.colorLabel))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_off,
            size: 80,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'Empty notifications',
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
