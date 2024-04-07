import 'package:fitness_tracker/services/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
