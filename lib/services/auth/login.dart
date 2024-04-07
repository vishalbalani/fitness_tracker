import 'package:flutter/widgets.dart';
import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login.g.dart';

@riverpod
Future<bool> loginService(LoginServiceRef ref, BuildContext context) async {
  final Health health = Health();

  try {
    // Request authorization
    bool requested = await health.requestAuthorization([
      HealthDataType.STEPS,
      HealthDataType.DISTANCE_DELTA,
      HealthDataType.ACTIVE_ENERGY_BURNED
    ]);

    if (!requested) {
      return false;
    }
    if (context.mounted) Navigator.pushReplacementNamed(context, '/home');
    return true;
  } catch (e) {
    throw Exception(e);
  }
}
