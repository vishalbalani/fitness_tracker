import 'dart:developer';

import 'package:fitness_tracker/model/fitness_data_model.dart';
import 'package:fitness_tracker/providers/fitness_data_provider.dart';
import 'package:fitness_tracker/services/notification_service.dart';
import 'package:fitness_tracker/utils/toast.dart';
import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'fitness_data_service.g.dart';

@riverpod
Stream<void> periodicFitnessDataService(
    PeriodicFitnessDataServiceRef ref) async* {
  final periodicStream = Stream.periodic(
      const Duration(seconds: 10), (index) => null); // Emit void

  await for (var _ in periodicStream) {
    ref.read(fitnessDataServiceProvider(false));
  }
}

@riverpod
Future<FitnessDataModel?> fitnessDataService(
    FitnessDataServiceRef ref, bool fromApp) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final Health health = Health();
  final notificationService = NotificationServices();

  try {
    log("hit");
    if (fromApp) {
      bool isSuccess = await health.requestAuthorization([
        HealthDataType.STEPS,
        HealthDataType.DISTANCE_DELTA,
        HealthDataType.ACTIVE_ENERGY_BURNED
      ]);

      if (!isSuccess) {
        showToast("Failed to fetch data");
        return null;
      }
    }
    DateTime endDate = DateTime.now();
    DateTime startDate =
        DateTime(endDate.year, endDate.month, endDate.day, 0, 0, 0);

    // Fetch health data from Google Fit
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      startTime: startDate,
      endTime: endDate,
      types: [
        HealthDataType.STEPS,
        HealthDataType.DISTANCE_DELTA,
        HealthDataType.ACTIVE_ENERGY_BURNED,
      ],
    );

    int totalSteps = 0;
    double totalDistance = 0;
    double totalCalories = 0;

    for (var dataPoint in healthData) {
      String numericValue =
          dataPoint.value.toJson()['numeric_value'].toString();
      if (numericValue == "0" ||
          numericValue == "null" ||
          numericValue.isEmpty) {
        continue;
      }
      switch (dataPoint.type) {
        case HealthDataType.STEPS:
          totalSteps += int.parse(numericValue);
          break;
        case HealthDataType.DISTANCE_DELTA:
          totalDistance += double.parse(numericValue) / 1000;
          break;
        case HealthDataType.ACTIVE_ENERGY_BURNED:
          totalCalories += double.parse(numericValue);
          break;
        default:
          break;
      }
    }

    int previousTotalSteps = prefs.getInt('totalSteps') ?? 0;

    int previous = (previousTotalSteps ~/ 100);
    int current = (totalSteps ~/ 100);

    if ((current - previous) >= 1 && previousTotalSteps != 0) {
      notificationService.showNotification(
        title: "You're on fire! Milestone achieved! 🔥",
        body: '${(totalSteps ~/ 100) * 100} steps and counting!',
      );
    }
    await prefs.setInt('totalSteps', totalSteps);

    ref.read(fitnessDataProvider.notifier).updateState(FitnessDataModel(
          totalSteps: totalSteps,
          totalDistance: totalDistance,
          totalCalories: totalCalories,
        ));
    if (fromApp) {
      showToast("Stats Refreshed Successfully!");
    }
    return FitnessDataModel(
      totalSteps: totalSteps,
      totalDistance: totalDistance,
      totalCalories: totalCalories,
    );
  } catch (e) {
    return null;
  }
}
