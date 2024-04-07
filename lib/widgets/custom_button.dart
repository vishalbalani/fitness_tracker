import 'package:fitness_tracker/constants/size.dart';
import 'package:fitness_tracker/widgets/app_style.dart';
import 'package:fitness_tracker/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.onTap,
    required this.width,
    required this.height,
    this.color2,
    required this.color,
    required this.text,
    this.isLoading = false, // New isLoading parameter with default value false
  });

  final void Function()? onTap;
  final double width;
  final double height;
  final Color? color2;
  final Color color;
  final String text;
  final bool isLoading; // New isLoading parameter

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color2,
          borderRadius: const BorderRadius.all(
            Radius.circular(12),
          ),
          border: Border.all(
            width: 1,
            color: color,
          ),
        ),
        child: Center(
          child: isLoading // Check if isLoading is true
              ? CircularProgressIndicator(
                  // Display CircularProgressIndicator if true
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                )
              : TextWidget(
                  text: text,
                  style: appstyle(
                    getHeight(context, 2),
                    FontWeight.bold,
                    color: color,
                  ),
                ),
        ),
      ),
    );
  }
}