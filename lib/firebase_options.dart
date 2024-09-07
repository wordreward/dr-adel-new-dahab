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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDE6sncdkCPc10y039O0Y-qKjSTtQ1Z0FE',
    appId: '1:449446941376:android:022ed82c51424609409325',
    messagingSenderId: '449446941376',
    projectId: 'dr-adel-wr',
    storageBucket: 'dr-adel-wr.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAe5pJUnOv4doQBGqoEiHrA8bZFy23G5iU',
    appId: '1:449446941376:ios:185abe712dc22990409325',
    messagingSenderId: '449446941376',
    projectId: 'dr-adel-wr',
    storageBucket: 'dr-adel-wr.appspot.com',
    androidClientId: '449446941376-0asjvia8jboct5g9iaifq4i2ocr38hmn.apps.googleusercontent.com',
    iosClientId: '449446941376-s0of1ak6voo13qulamirleg1p4k4h4mv.apps.googleusercontent.com',
    iosBundleId: 'net.wordreward.dahabdentist',
  );
}