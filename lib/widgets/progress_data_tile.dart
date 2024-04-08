import 'package:fitness_tracker/constants/colors.dart';
import 'package:fitness_tracker/constants/size.dart';
import 'package:fitness_tracker/widgets/app_style.dart';
import 'package:fitness_tracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProgressDataTile extends StatelessWidget {
  const ProgressDataTile(
      {super.key,
      required this.totalSteps,
      required this.totalKms,
      required this.totalCalories});

  final String totalSteps;
  final String totalKms;
  final String totalCalories;

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
              text: "Today's Progress",
              style: appstyle(getHeight(context, 2.8), FontWeight.bold,
                  color: kOffWhite),
            ),
            SizedBox(height: getHeight(context, 2)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dataTile(context, totalCalories.toString(), "Kcal"),
                dataTile(context, totalSteps.toString(), "Steps", size: 3),
                dataTile(context, totalKms.toString(), "Kms"),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget dataTile(BuildContext context, String data, String unit,
      {double size = 2}) {
    return Column(
      children: [
        TextWidget(
            text: data,
            style: appstyle(getHeight(context, size), FontWeight.w600,
                color: kLightBlue)),
        SizedBox(width: getWidth(context, 1.5)),
        TextWidget(
            text: unit,
            style: appstyle(getHeight(context, 1.8), FontWeight.w600,
                color: kOffWhite)),
      ],
    );
  }
}
