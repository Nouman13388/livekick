import 'package:flutter/material.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Sample notification data
  final List<Map<String, dynamic>> _notifications = [
    {
      'title': 'New Match Scheduled',
      'subtitle': 'Your favorite team has a new match scheduled for tomorrow.',
      'timestamp': '2024-05-20 10:30 AM',
    },
    {
      'title': 'Update Available',
      'subtitle': 'A new update is available for the LiveKick app.',
      'timestamp': '2024-05-19 09:00 AM',
    },
    {
      'title': 'Reminder',
      'subtitle': 'Don\'t forget to watch the live stream tonight.',
      'timestamp': '2024-05-18 08:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: _notifications.length,
        itemBuilder: (context, index) {
          final notification = _notifications[index];
          return ListTile(
            title: Text(notification['title']),
            subtitle: Text(notification['subtitle']),
            trailing: Text(notification['timestamp']),
            onTap: () {
              // Handle notification tap
            },
          );
        },
      ),
    );
  }
}
