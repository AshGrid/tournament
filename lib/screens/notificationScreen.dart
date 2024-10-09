import 'package:flutter/material.dart';
import '../components/NotificatinItem.dart';
import '../models/Notif.dart'; // Import the Notif model
 // Import the new NotificationItem widget

class NotificationScreen extends StatelessWidget {
  final List<Notif> notifications;

  const NotificationScreen({
    Key? key,
    required this.notifications,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildNotificationList(context),
        ],
      ),
    );
  }



  Widget _buildNotificationList(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
          child: NotificationItem(notification: notifications[index]), // Use the NotificationItem widget
        );
      },
    );
  }
}
