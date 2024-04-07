import 'package:fitness_tracker/services/auth/login.dart';
import 'package:fitness_tracker/utils/permission_handel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    requestPermissionForBackgroundTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<bool> isUserLoggedIn =
        ref.watch(loginServiceProvider(context));

    return isUserLoggedIn.when(data: (data) {
      if (!data) {
        return Scaffold(
            body: Center(
          child: FloatingActionButton(
              onPressed: () {
                ref.read(loginServiceProvider(context));
              },
              child: const Text('Login')),
        ));
      }

      return const SizedBox();
    }, error: (stack, error) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error),
              const SizedBox(height: 20),
              Text('Error: $error'),
            ],
          ),
        ),
      );
    }, loading: () {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 20),
              Text('Loading...'),
            ],
          ),
        ),
      );
    });
  }
}
