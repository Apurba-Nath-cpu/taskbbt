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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBGOQI8yg9R8cJS-F8lAk0H8p5oHLmFTtk',
    appId: '1:555371606847:web:aa46cabaf5ba0663d8d98a',
    messagingSenderId: '555371606847',
    projectId: 'mytaskbbt',
    authDomain: 'mytaskbbt.firebaseapp.com',
    storageBucket: 'mytaskbbt.firebasestorage.app',
    measurementId: 'G-R0GYEG69YJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC8dSB8Fw8esNHXbf9MfZNZOxrDDrSVl6k',
    appId: '1:555371606847:android:2155dbb489ee10add8d98a',
    messagingSenderId: '555371606847',
    projectId: 'mytaskbbt',
    storageBucket: 'mytaskbbt.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD_aXcns-Qj3Mx1Sw-oAYCUHo1tABJBrhw',
    appId: '1:555371606847:ios:cc2419ebd0914d2ad8d98a',
    messagingSenderId: '555371606847',
    projectId: 'mytaskbbt',
    storageBucket: 'mytaskbbt.firebasestorage.app',
    iosBundleId: 'com.example.mytask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD_aXcns-Qj3Mx1Sw-oAYCUHo1tABJBrhw',
    appId: '1:555371606847:ios:cc2419ebd0914d2ad8d98a',
    messagingSenderId: '555371606847',
    projectId: 'mytaskbbt',
    storageBucket: 'mytaskbbt.firebasestorage.app',
    iosBundleId: 'com.example.mytask',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBGOQI8yg9R8cJS-F8lAk0H8p5oHLmFTtk',
    appId: '1:555371606847:web:e66fbbfb3718c995d8d98a',
    messagingSenderId: '555371606847',
    projectId: 'mytaskbbt',
    authDomain: 'mytaskbbt.firebaseapp.com',
    storageBucket: 'mytaskbbt.firebasestorage.app',
    measurementId: 'G-43WNS9WF2X',
  );
}
