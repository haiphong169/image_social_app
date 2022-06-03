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
    apiKey: 'AIzaSyAX2_5ntf_-lnXF8GWV9hdospE5oxINOyc',
    appId: '1:382878297759:web:80988e935a26d4e5f6fcaa',
    messagingSenderId: '382878297759',
    projectId: 'flutter-practice-app-9b111',
    authDomain: 'flutter-practice-app-9b111.firebaseapp.com',
    storageBucket: 'flutter-practice-app-9b111.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD86b17wEfF3SD-5HGb1NQc14-0SHFSypU',
    appId: '1:382878297759:android:f4cc717f6d986bfdf6fcaa',
    messagingSenderId: '382878297759',
    projectId: 'flutter-practice-app-9b111',
    storageBucket: 'flutter-practice-app-9b111.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDzXHYb1Pa4NShPaCJ62lhlNNMvnTIVqos',
    appId: '1:382878297759:ios:a161e33367e6a02df6fcaa',
    messagingSenderId: '382878297759',
    projectId: 'flutter-practice-app-9b111',
    storageBucket: 'flutter-practice-app-9b111.appspot.com',
    iosClientId:
        '382878297759-cgelq9k04akl2ohs7cgrb73e18kgns21.apps.googleusercontent.com',
    iosBundleId: 'com.example.practiceApp',
  );
}
