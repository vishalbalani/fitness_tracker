import 'package:fitness_tracker/constants/colors.dart';
import 'package:fitness_tracker/constants/size.dart';
import 'package:fitness_tracker/services/fitness_data_service.dart';
import 'package:fitness_tracker/utils/snake_bar.dart';
import 'package:fitness_tracker/widgets/app_style.dart';
import 'package:fitness_tracker/widgets/custom_button.dart';
import 'package:fitness_tracker/widgets/custom_text.dart';
import 'package:fitness_tracker/widgets/progress_data_tile.dart';
import 'package:fitness_tracker/widgets/graph_widget.dart';
import 'package:fitness_tracker/widgets/target_remaining_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:fitness_tracker/providers/fitness_data_provider.dart';
import 'package:fitness_tracker/utils/permission_handle.dart';
import 'package:fitness_tracker/widgets/background_handler_widget.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    ref.read(fitnessDataServiceProvider);
    super.initState();
    notificationInitialization();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(periodicFitnessDataServiceProvider);
    final fitnessData = ref.watch(fitnessDataProvider);
    bool fitnessDataNullCheck = fitnessData == null;

    return BackgroundHandlerWidget(
      child: Scaffold(
        backgroundColor: kBackground,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RadialBarGraphWidget(
                totalSteps: fitnessDataNullCheck ? 0 : fitnessData.totalSteps,
                totalKms: fitnessDataNullCheck ? 0 : fitnessData.totalDistance,
                totalCalories:
                    fitnessDataNullCheck ? 0 : fitnessData.totalCalories,
              ),
              SizedBox(height: getHeight(context, 4)),
              ProgressDataTile(
                totalSteps: fitnessDataNullCheck
                    ? '0'
                    : fitnessData.totalSteps.toString(),
                totalKms: fitnessDataNullCheck
                    ? '0'
                    : fitnessData.totalDistance.toStringAsFixed(2),
                totalCalories: fitnessDataNullCheck
                    ? '0'
                    : fitnessData.totalCalories.toStringAsFixed(2),
              ),
              SizedBox(height: getHeight(context, 1)),
              TargetRemainingTile(
                totalSteps: fitnessDataNullCheck ? 0 : fitnessData.totalSteps,
                totalKms: fitnessDataNullCheck ? 0 : fitnessData.totalDistance,
                totalCalories:
                    fitnessDataNullCheck ? 0 : fitnessData.totalCalories,
              ),
              SizedBox(height: getHeight(context, 2)),
              CustomButton(
                onTap: () {
                  ref.read(fitnessDataServiceProvider);
                  showSnackBar(context, "Stats Refreshed Successfully!");
                },
                width: getWidth(context, 50),
                height: getHeight(context, 7),
                color: kLightBlue,
                text: 'Refresh Stats',
              )
            ],
          ),
        ),
      ),
    );
  }
}
