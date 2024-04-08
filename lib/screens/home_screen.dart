import 'package:fitness_tracker/constants/colors.dart';
import 'package:fitness_tracker/constants/icons.dart';
import 'package:fitness_tracker/constants/size.dart';
import 'package:fitness_tracker/services/auth/logout.dart';
import 'package:fitness_tracker/services/fitness_data_service.dart';
import 'package:fitness_tracker/widgets/custom_button.dart';
import 'package:fitness_tracker/widgets/progress_data_tile.dart';
import 'package:fitness_tracker/widgets/progress_indicator_widget.dart';
import 'package:fitness_tracker/widgets/radialbar_graph_widget.dart';
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
    requestPermissionForBackgroundTask();
    ref.read(periodicFitnessDataServiceProvider);

    super.initState();
    notificationInitialization();
  }

  @override
  Widget build(BuildContext context) {
    final fitnessData = ref.watch(fitnessDataProvider);
    bool fitnessDataNullCheck = fitnessData == null;

    return BackgroundHandlerWidget(
      child: Scaffold(
        backgroundColor: kBackground,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(width: getWidth(context, 2)),
                        CustomButton(
                            onTap: () =>
                                ref.read(fitnessDataServiceProvider(true)),
                            width: getWidth(context, 25),
                            height: getHeight(context, 5),
                            color: kLightBlue,
                            text: "Login"),
                        SizedBox(width: getWidth(context, 2)),
                        CustomButton(
                            onTap: () => ref.read(logoutServiceProvider),
                            width: getWidth(context, 25),
                            height: getHeight(context, 5),
                            color: kLightBlue,
                            text: "Logout"),
                      ],
                    ),
                    IconButton(
                      icon: const Padding(
                        padding: EdgeInsets.all(12.0),
                        child: Icon(
                          kRefresh,
                          color: kOffWhite,
                        ),
                      ),
                      onPressed: () {
                        ref.read(fitnessDataServiceProvider(true));
                      },
                    ),
                  ],
                ),
                RadialBarGraphWidget(
                  totalSteps: fitnessDataNullCheck ? 0 : fitnessData.totalSteps,
                  totalKms:
                      fitnessDataNullCheck ? 0 : fitnessData.totalDistance,
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
                SizedBox(height: getHeight(context, 2)),
                ProgressIndicatorWidget(
                  totalSteps: fitnessDataNullCheck ? 0 : fitnessData.totalSteps,
                  totalKms:
                      fitnessDataNullCheck ? 0 : fitnessData.totalDistance,
                  totalCalories:
                      fitnessDataNullCheck ? 0 : fitnessData.totalCalories,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
