import 'package:fitness_tracker/services/fitness_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitness_tracker/providers/fitness_data_provider.dart';
import 'package:fitness_tracker/utils/permission_handel.dart';
import 'package:fitness_tracker/widgets/background_handler_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();

    requestPermissionForBackgroundTask();
    notificationInitialization();
    healthPermission();
  }

  @override
  Widget build(BuildContext context) {
    final fitnessData = ref.watch(fitnessDataProvider);
    // ref.read(periodicFitnessDataServiceProvider);

    return BackgroundHandlerWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Fitness Tracker'),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
                onPressed: () {
                  ref.read(fitnessDataServiceProvider);
                },
                child: const Icon(Icons.refresh)),
            if (fitnessData != null)
              RichText(
                text: TextSpan(
                  style: const TextStyle(color: Colors.black),
                  children: [
                    const TextSpan(
                      text: 'Total Steps: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text: '${fitnessData.totalSteps}\n',
                    ),
                    const TextSpan(
                      text: 'Total Distance: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '${fitnessData.totalDistance.toStringAsFixed(2)} km\n',
                    ),
                    const TextSpan(
                      text: 'Total Calories Burned: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextSpan(
                      text:
                          '${fitnessData.totalCalories.toStringAsFixed(2)} Calories',
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
