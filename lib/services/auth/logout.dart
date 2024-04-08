import 'package:fitness_tracker/providers/fitness_data_provider.dart';
import 'package:fitness_tracker/utils/toast.dart';
import 'package:health/health.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logout.g.dart';

@riverpod
Future<bool> logoutService(LogoutServiceRef ref) async {
  final Health health = Health();

  try {
    await health.revokePermissions();

    ref.read(fitnessDataProvider.notifier).valueReset();

    showToast("Logout successful");

    return true;
  } catch (e) {
    throw Exception(e);
  }
  finally {
    }
}
