import 'dart:developer';
import 'dart:isolate';

import 'package:fitness_tracker/services/fitness_data_service.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@pragma('vm:entry-point')
void backgroundCallback() {
  FlutterForegroundTask.setTaskHandler(BackgroundTaskHandler());
}

class BackgroundTaskHandler extends TaskHandler {
  SendPort? _sendPort;

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;

    final providerContainer = ProviderContainer();
    providerContainer.read(fitnessDataServiceProvider);
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {

    final providerContainer = ProviderContainer();
    providerContainer.read(fitnessDataServiceProvider);
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = null;
  }

  @override
  void onNotificationButtonPressed(String id) {
    log('onNotificationButtonPressed >> $id');
  }

  @override
  void onNotificationPressed() {
    FlutterForegroundTask.launchApp();
    _sendPort?.send('onNotificationPressed');
  }
}
