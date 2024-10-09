// notification_item.dart
import 'package:flutter/material.dart';
import '../models/Notif.dart'; // Import the Notif model
import '../components/colors.dart'; // Import colors used in the widget

class NotificationItem extends StatelessWidget {
  final Notif notification;

  const NotificationItem({
    Key? key,
    required this.notification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height * 0.14,
      padding: const EdgeInsets.all(10), // Added padding for better spacing
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.0),
        border: Border.all(color: Colors.white),
      ),
      child: _buildNotifItem(context, notification),
    );
  }

  Widget _buildNotifItem(BuildContext context, Notif notif) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center, // Center align the row
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.18,
          height: MediaQuery.of(context).size.height * 0.08,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: AppColors.matchItemComponentTeamLogoBorder, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              notif.image,
              fit: BoxFit.fill,
              width: 50,
              height: 50,
            ),
          ),
        ),
        SizedBox(width: 15), // Spacing between the image and title
        Expanded( // Make this section flexible
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to start
            mainAxisAlignment: MainAxisAlignment.center, // Center align text vertically
            children: [
              Text(
                notif.title, // Title from the Notif model
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black, // Adjust the color as needed
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 5), // Spacing between title and description
              Text(
                notif.description, // Description from the Notif model
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black, // Adjust the color as needed
                ),
                textAlign: TextAlign.left,
                maxLines: 2, // Reasonable max lines for description
                overflow: TextOverflow.ellipsis, // Show ellipsis for overflow
              ),
            ],
          ),
        ),
      ],
    );
  }

}
