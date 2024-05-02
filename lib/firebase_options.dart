// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:firebase_web/configure/constants/enviorment.dart';
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: Environment.firebasekeyWeb,
    appId: '1:1050588380052:web:6e9b2627cac1a14883ed81',
    messagingSenderId: '1050588380052',
    projectId: 'hiitgym-2ae99',
    authDomain: 'hiitgym-2ae99.firebaseapp.com',
    databaseURL: 'https://hiitgym-2ae99-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hiitgym-2ae99.appspot.com',
    measurementId: 'G-383TTBZ8T5',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: Environment.firebasekeyAndroid,
    appId: '1:1050588380052:android:783ce4ac43aac8fb83ed81',
    messagingSenderId: '1050588380052',
    projectId: 'hiitgym-2ae99',
    databaseURL: 'https://hiitgym-2ae99-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'hiitgym-2ae99.appspot.com',
  );

}