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
        return macos;
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
    apiKey: 'AIzaSyAQ8iZ9v_JF8oq7TzXINO85QbEYdlMzsPY',
    appId: '1:275026980124:web:6d1986280122e8a508ded9',
    messagingSenderId: '275026980124',
    projectId: 'posilife-c415e',
    authDomain: 'posilife-c415e.firebaseapp.com',
    storageBucket: 'posilife-c415e.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCelLSIAu9UOzUsa6PU3ugZ7ET69MAtRmg',
    appId: '1:275026980124:android:68e6d0a88602114e08ded9',
    messagingSenderId: '275026980124',
    projectId: 'posilife-c415e',
    storageBucket: 'posilife-c415e.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCUKt27OPcuVlVqOgRHPU-xYgIQDi-cjl0',
    appId: '1:275026980124:ios:79f71c6939bd622e08ded9',
    messagingSenderId: '275026980124',
    projectId: 'posilife-c415e',
    storageBucket: 'posilife-c415e.appspot.com',
    iosBundleId: 'com.example.complete',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCUKt27OPcuVlVqOgRHPU-xYgIQDi-cjl0',
    appId: '1:275026980124:ios:e01cb5afe96fd49a08ded9',
    messagingSenderId: '275026980124',
    projectId: 'posilife-c415e',
    storageBucket: 'posilife-c415e.appspot.com',
    iosBundleId: 'com.example.complete.RunnerTests',
  );
}
