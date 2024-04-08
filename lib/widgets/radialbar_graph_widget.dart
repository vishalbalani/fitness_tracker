import 'package:fitness_tracker/constants/colors.dart';
import 'package:fitness_tracker/constants/size.dart';
import 'package:fitness_tracker/model/radial_graph_model.dart';
import 'package:fitness_tracker/widgets/app_style.dart';
import 'package:fitness_tracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class RadialBarGraphWidget extends StatelessWidget {
  const RadialBarGraphWidget(
      {super.key,
      required this.totalSteps,
      required this.totalKms,
      required this.totalCalories});

  final int totalSteps;
  final double totalKms;
  final double totalCalories;

  @override
  Widget build(BuildContext context) {
    return Column(
      
      children: [
        FittedBox(
          child: SizedBox(
            height: getHeight(context, 30),
            child: SfCircularChart(
              series: <RadialBarSeries<RadialBarGraphModel, String>>[
                RadialBarSeries<RadialBarGraphModel, String>(
                  trackColor: kLightGray,
                  trackOpacity: 0.2,
                  gap: "15%",
                  radius: "100%",
                  innerRadius: "50%",
                  maximumValue: 100,
                  dataSource: <RadialBarGraphModel>[
                    RadialBarGraphModel(
                        totalCalories * 100 / 1000, 'Calories', kLightRed),
                    RadialBarGraphModel(
                        totalKms * 100 / 10, 'Total Kms', kLightPurple),
                    RadialBarGraphModel(
                        totalSteps * 100 / 10000, 'Steps', kLightBlue),
                  ],
                  xValueMapper: (RadialBarGraphModel data, _) => data.xData,
                  yValueMapper: (RadialBarGraphModel data, _) => data.yData,
                  pointColorMapper: (RadialBarGraphModel data, _) => data.color,
                  useSeriesColor: true,
                  cornerStyle: CornerStyle.bothCurve,
                ),
              ],
            ),
          ),
        ),
        graphLabel(context),
      ],
    );
  }

  Widget graphLabel(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        dataTile(context, FontAwesomeIcons.gripfire, kLightRed, "Cal"),
        SizedBox(width: getWidth(context, 5)),
        dataTile(context, Icons.directions_walk, kLightPurple, "Km"),
        SizedBox(width: getWidth(context, 5)),
        dataTile(context, FontAwesomeIcons.shoePrints, kLightBlue, "Steps"),
      ],
    );
  }

  Widget dataTile(
      BuildContext context, IconData icon, Color iconColor, String unit) {
    return Row(
      children: [
        FaIcon(icon, color: iconColor),
        SizedBox(width: getWidth(context, 1.8)),
        TextWidget(
            text: unit,
            style: appstyle(getHeight(context, 2.2), FontWeight.bold,
                color: kOffWhite))
      ],
    );
  }
}
