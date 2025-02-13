// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
    apiKey: 'AIzaSyCyrHtLrQffElLD_oJMw0RXASjtwImMVCo',
    appId: '1:593224572773:web:b1daca19847c9617cb0b8c',
    messagingSenderId: '593224572773',
    projectId: 'b1-4de11',
    authDomain: 'b1-4de11.firebaseapp.com',
    storageBucket: 'b1-4de11.firebasestorage.app',
    measurementId: 'G-RF4CTSCE8M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCJAEPNe9uMss8rpavRY6T2wrBD0rE43es',
    appId: '1:593224572773:android:5e97f07f055a4842cb0b8c',
    messagingSenderId: '593224572773',
    projectId: 'b1-4de11',
    storageBucket: 'b1-4de11.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDTj-e-PMsslJTlqXauDcnChlJWGi-dtgk',
    appId: '1:593224572773:ios:9dbe4db35976cdf1cb0b8c',
    messagingSenderId: '593224572773',
    projectId: 'b1-4de11',
    storageBucket: 'b1-4de11.firebasestorage.app',
    iosBundleId: 'com.example.firebaseCrud',
  );
}
