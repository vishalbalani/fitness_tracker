import 'package:fitness_tracker/constants/colors.dart';
import 'package:fitness_tracker/constants/size.dart';
import 'package:fitness_tracker/widgets/app_style.dart';
import 'package:fitness_tracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  const ProgressIndicatorWidget(
      {super.key,
      required this.totalSteps,
      required this.totalKms,
      required this.totalCalories});
  final int totalSteps;
  final double totalKms;
  final double totalCalories;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: kCharcoal,
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: getHeight(context, 2)),
        child: Column(
          children: [
            TextWidget(
              text: "Goal Progress",
              style: appstyle(getHeight(context, 2.8), FontWeight.bold,
                  color: kOffWhite),
            ),
            SizedBox(height: getHeight(context, 2)),
            progressIndicator(
              '10000 Steps',
              totalSteps / 10000,
              kLightBlue,
              context,
            ),
            SizedBox(height: getHeight(context, 1)),
            progressIndicator(
              '10 Kms',
              totalKms / 10,
              kLightPurple,
              context,
            ),
            SizedBox(height: getHeight(context, 1)),
            progressIndicator(
              '1000 kCal',
              totalCalories / 1000,
              kLightRed,
              context,
            ),
          ],
        ),
      ),
    );
  }

  Widget progressIndicator(
      String target, double percent, Color color, BuildContext context,
      {isFirst = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
      child: Column(
        children: [
          Row(
            children: [
              const Spacer(),
              Text("${(percent * 100).toStringAsFixed(2)}%",
                  style: appstyle(getHeight(context, 1.6), FontWeight.w600,
                      color: Color(0xff51bf76))),
            ],
          ),
          SizedBox(height: getHeight(context, 0.5)),
          Row(
            children: [
              SizedBox(
                  width: getWidth(context, 21),
                  child: TextWidget(
                      text: target,
                      style: appstyle(12, FontWeight.w600, color: kOffWhite))),
              Expanded(child: linearGraph(percent, color, context)),
            ],
          ),
        ],
      ),
    );
  }

  Widget linearGraph(double percent, Color color, BuildContext context) {
    return LinearPercentIndicator(
      lineHeight: getHeight(context, 1),
      percent: percent,
      animationDuration: 1000,
      barRadius: const Radius.circular(10),
      animation: true,
      animateFromLastPercent: true,
      curve: Curves.easeIn,
      progressColor: color,
    );
  }
}
