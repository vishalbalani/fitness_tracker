import 'package:fitness_tracker/providers/fitness_data_provider.dart';
import 'package:fitness_tracker/services/fitness_data_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fitnessData = ref.watch(fitnessDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Fitness Tracker')),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          (fitnessData == null)
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
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () => ref.read(fitnessDataServiceProvider),
            child: const Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}
