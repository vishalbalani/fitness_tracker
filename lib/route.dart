import 'package:fitness_tracker/screens/home_screen.dart';
import 'package:fitness_tracker/screens/splash_screen.dart';
import 'package:flutter/material.dart';

final Map<String, WidgetBuilder> routes = {
  '/splash': (context) => const SplashScreen(),
  '/home': (context) => const HomeScreen(),
};
