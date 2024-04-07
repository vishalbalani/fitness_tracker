import 'package:fitness_tracker/services/background_manager_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

class BackgroundHandlerWidget extends StatelessWidget {
  const BackgroundHandlerWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return WithForegroundTask(
        child: WillStartForegroundTask(
            onWillStart: () async {
              return true;
            },
            androidNotificationOptions: AndroidNotificationOptions(
              channelId: 'foreground_service',
              channelName: 'Foreground Service Notification',
              channelDescription:
                  'This notification appears when the foreground service is running.',
              channelImportance: NotificationChannelImportance.HIGH,
              priority: NotificationPriority.HIGH,
              isSticky: true,
              iconData: const NotificationIconData(
                resType: ResourceType.mipmap,
                resPrefix: ResourcePrefix.ic,
                name: 'launcher',
              ),
            ),
            iosNotificationOptions: const IOSNotificationOptions(
              showNotification: true,
              playSound: true,
            ),
            foregroundTaskOptions: const ForegroundTaskOptions(
              interval: 10000,
              isOnceEvent: false,
              allowWakeLock: false,
              allowWifiLock: false,
            ),
            notificationTitle: 'Fitness Tracker is running',
            notificationText: 'Tap to return to the app',
            callback: backgroundCallback,
            child: child));
  }
}
