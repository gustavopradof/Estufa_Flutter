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
    apiKey: 'AIzaSyByOIIOdRWof-63B01D12AOHH0QEfytqnw',
    appId: '1:566367883511:web:b53e58d80007c7bcb243f2',
    messagingSenderId: '566367883511',
    projectId: 'estufa-27517',
    authDomain: 'estufa-27517.firebaseapp.com',
    databaseURL: 'https://estufa-27517-default-rtdb.firebaseio.com',
    storageBucket: 'estufa-27517.appspot.com',
    measurementId: 'G-8HL600F3NB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyACY50gLAiszbZ0tE4Sbgoewao2CHTHdGg',
    appId: '1:566367883511:android:bfa4db9224313becb243f2',
    messagingSenderId: '566367883511',
    projectId: 'estufa-27517',
    databaseURL: 'https://estufa-27517-default-rtdb.firebaseio.com',
    storageBucket: 'estufa-27517.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAL-cPYMFzmZa8ZmKmll9yL-J5DRsYUB_8',
    appId: '1:566367883511:ios:35f697e74a44dc55b243f2',
    messagingSenderId: '566367883511',
    projectId: 'estufa-27517',
    databaseURL: 'https://estufa-27517-default-rtdb.firebaseio.com',
    storageBucket: 'estufa-27517.appspot.com',
    iosClientId: '566367883511-4el5j88s9dtuqqmsd399uh3gvf2peuv8.apps.googleusercontent.com',
    iosBundleId: 'com.example.tccEstufa',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAL-cPYMFzmZa8ZmKmll9yL-J5DRsYUB_8',
    appId: '1:566367883511:ios:35f697e74a44dc55b243f2',
    messagingSenderId: '566367883511',
    projectId: 'estufa-27517',
    databaseURL: 'https://estufa-27517-default-rtdb.firebaseio.com',
    storageBucket: 'estufa-27517.appspot.com',
    iosClientId: '566367883511-4el5j88s9dtuqqmsd399uh3gvf2peuv8.apps.googleusercontent.com',
    iosBundleId: 'com.example.tccEstufa',
  );
}
