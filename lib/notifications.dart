import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Medication Reminder',
      'body': 'It\'s time to take your M1 tablet.',
      'time': '5 mins ago',
      'isNew': 'true',
    },
    {
      'title': 'System Update',
      'body': 'Medack has been updated to version 1.0.1.',
      'time': '2 hours ago',
      'isNew': 'false',
    },
    {
      'title': 'New Tip',
      'body': 'Remember to stay hydrated while taking your meds.',
      'time': 'Yesterday',
      'isNew': 'false',
    },
  ];

  final Color darkGreen = Color(0xFF1B5E20);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (context, index) => Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          final bool isNew = notification['isNew'] == 'true';

          return ListTile(
            leading: CircleAvatar(
              backgroundColor: isNew ? darkGreen : Colors.grey[300],
              child: Icon(
                Icons.notifications,
                color: isNew ? Colors.white : Colors.grey[600],
              ),
            ),
            title: Text(
              notification['title']!,
              style: TextStyle(
                fontWeight: isNew ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(notification['body']!),
                SizedBox(height: 4),
                Text(
                  notification['time']!,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            trailing: isNew
                ? Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
            onTap: () {
              // Handle notification tap
            },
          );
        },
      ),
    );
  }
}
