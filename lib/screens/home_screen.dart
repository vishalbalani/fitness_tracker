import 'package:fitness_tracker/constants/colors.dart';
import 'package:fitness_tracker/constants/size.dart';
import 'package:fitness_tracker/services/fitness_data_service.dart';
import 'package:fitness_tracker/widgets/app_style.dart';
import 'package:fitness_tracker/widgets/custom_button.dart';
import 'package:fitness_tracker/widgets/custom_text.dart';
import 'package:fitness_tracker/widgets/graph_data_tile.dart';
import 'package:fitness_tracker/widgets/graph_widget.dart';
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
              const RadialBarGraphWidget(),
              SizedBox(height: getHeight(context, 5)),
              Card(
                  color: Colors.black.withOpacity(0.9),
                  elevation: 5,
                  margin:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: getHeight(context, 2)),
                    child: Column(
                      children: [
                        TextWidget(
                            text: "Today's Progress",
                            style: appstyle(
                                getHeight(context, 3), FontWeight.bold,
                                color: kOffWhite)),
                        SizedBox(height: getHeight(context, 2)),
                        GraphDataWidget(
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
                      ],
                    ),
                  )),
              SizedBox(height: getHeight(context, 6)),
              CustomButton(
                onTap: () {
                  ref.read(fitnessDataServiceProvider);
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
