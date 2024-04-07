// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDUi0gTwMWhQtfPPksfkY7afzgNV8DBRyU',
    appId: '1:405347612503:web:af79fd90f822ea46377012',
    messagingSenderId: '405347612503',
    projectId: 'fitness-tracker-2862c',
    authDomain: 'fitness-tracker-2862c.firebaseapp.com',
    storageBucket: 'fitness-tracker-2862c.appspot.com',
    measurementId: 'G-X24GRTXPTC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC4pcnEelcXC61oQaOes54bJUVacEB1fpQ',
    appId: '1:405347612503:android:3a52f8a37f7a5bcd377012',
    messagingSenderId: '405347612503',
    projectId: 'fitness-tracker-2862c',
    storageBucket: 'fitness-tracker-2862c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB52fk3zZ4aMk_H0ZZ2VxCu39mrYyg77Jg',
    appId: '1:405347612503:ios:ee500320b59b7106377012',
    messagingSenderId: '405347612503',
    projectId: 'fitness-tracker-2862c',
    storageBucket: 'fitness-tracker-2862c.appspot.com',
    androidClientId: '405347612503-h2d30551kb00kahre6accedr4mp1u0ht.apps.googleusercontent.com',
    iosClientId: '405347612503-8p9vhmmm0cg3gqcvm0sp2ifekvi7i8q7.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitnessTracker',
  );
}
