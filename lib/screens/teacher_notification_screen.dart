import 'package:flutter/material.dart';

class TeacherNotificationsScreen extends StatelessWidget {
  const TeacherNotificationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = ['Theres nothing to show here yet'];

    return Center(
      child: Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: ListView.builder(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(notifications[index]),
              onTap: () {
                // Dilerseniz bildirim detayı ekranına gidebilirsiniz
              },
            );
          },
        ),
      ),
    );
  }
}
