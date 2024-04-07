import 'dart:developer';

import 'package:fitness_tracker/model/fitness_data_model.dart';
import 'package:fitness_tracker/providers/fitness_data_provider.dart';
import 'package:fitness_tracker/services/notification_service.dart';
import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'fitness_data_service.g.dart';

@riverpod
Stream<void> periodicFitnessDataService(
    PeriodicFitnessDataServiceRef ref) async* {
  final periodicStream =
      Stream.periodic(const Duration(milliseconds: 10000), (index) => index);

  await for (var _ in periodicStream) {
    ref.read(fitnessDataServiceProvider);
  }
}

@riverpod
Future<FitnessDataModel?> fitnessDataService(FitnessDataServiceRef ref) async {
  final Health health = Health();

  try {
    // Request authorization
    bool requested = await health.requestAuthorization([
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_DELTA,
      HealthDataType.ACTIVE_ENERGY_BURNED
    ]);

    if (!requested) {
      log("Authorization request was not successful");
      return null;
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
    final notificationService = NotificationServices();

    notificationService.showNotification(
      title:
          "Amazing progress! You've just reached another milestone on your fitness journey, surpassing $totalSteps steps. Keep stepping towards your goals",
      body: 'Total Distance: ${totalDistance.toStringAsFixed(2)} km'
          'Total Calories Burned: ${totalCalories.toStringAsFixed(2)} Calories',
    );

    log("Total Steps: $totalSteps");
    ref.read(fitnessDataProvider.notifier).updateState(FitnessDataModel(
          totalSteps: totalSteps,
          totalDistance: totalDistance,
          totalCalories: totalCalories,
        ));
    return FitnessDataModel(
      totalSteps: totalSteps,
      totalDistance: totalDistance,
      totalCalories: totalCalories,
    );
  } catch (e) {
    log("Error fetching fitness data: $e");
    return null;
  }
}
