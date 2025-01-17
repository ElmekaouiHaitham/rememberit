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
    apiKey: 'AIzaSyBQNjZ_KrZ_o2LslH_zQz1pi0641wkq9m8',
    appId: '1:67414969333:web:3f9c35a81b586bf85baebc',
    messagingSenderId: '67414969333',
    projectId: 'rememberit-haitham',
    authDomain: 'rememberit-haitham.firebaseapp.com',
    storageBucket: 'rememberit-haitham.appspot.com',
    measurementId: 'G-5FWB0HJGFL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBUaBDHHMW2sxybUOKH4xFlwLCS81EHCwY',
    appId: '1:67414969333:android:7ad5583cc250ef495baebc',
    messagingSenderId: '67414969333',
    projectId: 'rememberit-haitham',
    storageBucket: 'rememberit-haitham.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCNrRRG-WudKFrHMrauEOXYx6G5mht5kD0',
    appId: '1:67414969333:ios:8dd27efe96350de05baebc',
    messagingSenderId: '67414969333',
    projectId: 'rememberit-haitham',
    storageBucket: 'rememberit-haitham.appspot.com',
    iosClientId: '67414969333-jnop31ecuuvc3d57psldvgec2gpscilm.apps.googleusercontent.com',
    iosBundleId: 'remenberit.haitham.com.remenberit',
  );
}
