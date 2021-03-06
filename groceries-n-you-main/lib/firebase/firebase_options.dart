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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC7hwck9DzNANHHLs8VidxXQjwYjzzPWTo',
    appId: '1:1017044186661:web:fd52aa34b5f1ee234eb1cc',
    messagingSenderId: '1017044186661',
    projectId: 'groceries-n-you',
    authDomain: 'groceries-n-you.firebaseapp.com',
    storageBucket: 'groceries-n-you.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD4dPjCsxMC42XgF3H1ORCNSIQi2fibKJM',
    appId: '1:1017044186661:android:fec0db661f5b902e4eb1cc',
    messagingSenderId: '1017044186661',
    projectId: 'groceries-n-you',
    storageBucket: 'groceries-n-you.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDpRyKuASQNJRANzmWTDYgqz87hnibIccM',
    appId: '1:1017044186661:ios:ed60ae01451d8d894eb1cc',
    messagingSenderId: '1017044186661',
    projectId: 'groceries-n-you',
    storageBucket: 'groceries-n-you.appspot.com',
    iosClientId: '1017044186661-1t4hi8l0hel1bmrrj0vnj2s4cm41vfr3.apps.googleusercontent.com',
    iosBundleId: 'com.example.shopApp',
  );
}
