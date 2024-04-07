import 'package:flutter/material.dart';

double getWidth(BuildContext context, double percentage) {
  return MediaQuery.sizeOf(context).width * percentage / 100;
}

double getHeight(BuildContext context, double percentage) {
  return MediaQuery.of(context).size.height * percentage / 100;
}
