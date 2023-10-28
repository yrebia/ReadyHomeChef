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
    apiKey: 'AIzaSyDFDEpwu9MpdMLoPm27mbFBMeLiMTyKnDI',
    appId: '1:145936397421:web:8c81d1e4029b190ba97b64',
    messagingSenderId: '145936397421',
    projectId: 'ready-home-chef-64da3',
    authDomain: 'ready-home-chef-64da3.firebaseapp.com',
    storageBucket: 'ready-home-chef-64da3.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAUKHfAW7_NmK585EeB7UHmgA0SQT2M4m8',
    appId: '1:145936397421:android:40cb5a94bb5e922ea97b64',
    messagingSenderId: '145936397421',
    projectId: 'ready-home-chef-64da3',
    storageBucket: 'ready-home-chef-64da3.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDrPYJDNU-GFqyEbtKhrCr7Us3KevejR3o',
    appId: '1:145936397421:ios:72f45d574d558188a97b64',
    messagingSenderId: '145936397421',
    projectId: 'ready-home-chef-64da3',
    storageBucket: 'ready-home-chef-64da3.appspot.com',
    iosBundleId: 'com.example.readyHomeChef',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDrPYJDNU-GFqyEbtKhrCr7Us3KevejR3o',
    appId: '1:145936397421:ios:b167d2ab6f596009a97b64',
    messagingSenderId: '145936397421',
    projectId: 'ready-home-chef-64da3',
    storageBucket: 'ready-home-chef-64da3.appspot.com',
    iosBundleId: 'com.example.readyHomeChef.RunnerTests',
  );
}
