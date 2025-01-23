import 'package:flutter/material.dart';
import 'package:mool/data/notifications.dart';
import 'package:mool/widgets/reuse/custom_scaffold_header.dart';
import 'package:mool/models/notification.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  void _removeExpense(OneNotification notification) {
    final notificationIndex = dummyNotifications.indexOf(notification);
    setState(() {
      dummyNotifications.remove(notification);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(seconds: 3),
        content: Text("Notification deleted"),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              dummyNotifications.insert(notificationIndex, notification);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget fallback = Center(
      child: Text(
        "Notifications are empty",
        style: TextStyle(fontSize: 14),
      ),
    );
    return CustomScaffoldHeader(
      title: "Notifications",
      bodyContent: dummyNotifications.isEmpty ? fallback : _notificationsList(),
    );
  }

  Widget _notificationsList() {
    return ListView.separated(
      separatorBuilder: (context, index) => const Divider(
        color: Colors.grey,
        thickness: 1,
        height: 1,
      ),
      itemCount: dummyNotifications.length,
      itemBuilder: (context, index) {
        final notification = dummyNotifications[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Dismissible(
            background: Container(
              color: Theme.of(context).colorScheme.error.withAlpha(80),
            ),
            key: ValueKey(notification),
            onDismissed: (direction) {
              _removeExpense(notification);
            },
            child: Card(
              color: Colors.transparent,
              elevation: 0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(notification.imageUrl),
                    radius: 24,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.message,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF1A1A1A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notification.timeAgo,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
