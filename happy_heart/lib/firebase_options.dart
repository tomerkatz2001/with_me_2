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
    apiKey: 'AIzaSyCgZWlBJim6zE5YQ00r8wguuWOHJM8JHC4',
    appId: '1:362178897948:web:7a96c888ed14faa6d197d9',
    messagingSenderId: '362178897948',
    projectId: 'happy-heart-8b942',
    authDomain: 'happy-heart-8b942.firebaseapp.com',
    storageBucket: 'happy-heart-8b942.appspot.com',
    measurementId: 'G-QKYV3TH18F',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTdMB62TJ6N6UyXWrR4PkHjG7k4jiceOM',
    appId: '1:362178897948:android:dbb0ffdff8b5fd3dd197d9',
    messagingSenderId: '362178897948',
    projectId: 'happy-heart-8b942',
    storageBucket: 'happy-heart-8b942.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCg7-5gnWo68L74ApNxGRBxySIyubVkYXU',
    appId: '1:362178897948:ios:b0ed56160f1732cbd197d9',
    messagingSenderId: '362178897948',
    projectId: 'happy-heart-8b942',
    storageBucket: 'happy-heart-8b942.appspot.com',
    iosClientId: '362178897948-t414g9462567r9sbjn2a6ia6en1v8ooc.apps.googleusercontent.com',
    iosBundleId: 'com.technion.happyHeart',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCg7-5gnWo68L74ApNxGRBxySIyubVkYXU',
    appId: '1:362178897948:ios:b0ed56160f1732cbd197d9',
    messagingSenderId: '362178897948',
    projectId: 'happy-heart-8b942',
    storageBucket: 'happy-heart-8b942.appspot.com',
    iosClientId: '362178897948-t414g9462567r9sbjn2a6ia6en1v8ooc.apps.googleusercontent.com',
    iosBundleId: 'com.technion.happyHeart',
  );
}