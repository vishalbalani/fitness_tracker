import 'dart:io';

import 'package:fitness_tracker/services/notification_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

Future<void> requestPermissionForBackgroundTask() async {
  if (!Platform.isAndroid) {
    return;
  }
  if (!await FlutterForegroundTask.canDrawOverlays) {
    await FlutterForegroundTask.openSystemAlertWindowSettings();
  }

  if (!await FlutterForegroundTask.isIgnoringBatteryOptimizations) {
    await FlutterForegroundTask.requestIgnoreBatteryOptimization();
  }

  final NotificationPermission notificationPermissionStatus =
      await FlutterForegroundTask.checkNotificationPermission();
  if (notificationPermissionStatus != NotificationPermission.granted) {
    await FlutterForegroundTask.requestNotificationPermission();
  }

}

Future<void> notificationInitialization() async {
  final notificationService = NotificationServices();
  await notificationService.requestNotificationPermission();
  await notificationService.initLocalNotifications();

  await FlutterForegroundTask.requestNotificationPermission();
}
