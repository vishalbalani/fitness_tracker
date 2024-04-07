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
    notificationInitialization();
    requestPermissionForBackgroundTask();
  }

  @override
  Widget build(BuildContext context) {
    final fitnessData = ref.watch(fitnessDataProvider);
    return BackgroundHandlerWidget(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Foreground Task'),
          centerTitle: true,
        ),
        body: (fitnessData == null)
            ? const CircularProgressIndicator()
            : RichText(
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
      ),
    );
  }
}
