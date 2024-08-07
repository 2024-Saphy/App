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
    apiKey: 'AIzaSyC81kj_fvrRAdqwnLjvuX_1eSxq__uG5Rc',
    appId: '1:754445879555:web:cc2e656898a440c704c136',
    messagingSenderId: '754445879555',
    projectId: 'saphy-27f69',
    authDomain: 'saphy-27f69.firebaseapp.com',
    storageBucket: 'saphy-27f69.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDvgHWxTCbZ8jlDktwOtfAnacs5JN2ZI9o',
    appId: '1:754445879555:android:a8dc2d555589872e04c136',
    messagingSenderId: '754445879555',
    projectId: 'saphy-27f69',
    storageBucket: 'saphy-27f69.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCtHWeObFJDgM4Why074HeusteeltZxCbw',
    appId: '1:754445879555:ios:8ad3553c76c38b9104c136',
    messagingSenderId: '754445879555',
    projectId: 'saphy-27f69',
    storageBucket: 'saphy-27f69.appspot.com',
    androidClientId: '754445879555-2cf68o04seos49f93a81tnu8mr49ev7k.apps.googleusercontent.com',
    iosClientId: '754445879555-r1fu6an4tqau05de9hc6vffif00r950b.apps.googleusercontent.com',
    iosBundleId: 'com.example.saphy',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCtHWeObFJDgM4Why074HeusteeltZxCbw',
    appId: '1:754445879555:ios:8ad3553c76c38b9104c136',
    messagingSenderId: '754445879555',
    projectId: 'saphy-27f69',
    storageBucket: 'saphy-27f69.appspot.com',
    androidClientId: '754445879555-2cf68o04seos49f93a81tnu8mr49ev7k.apps.googleusercontent.com',
    iosClientId: '754445879555-r1fu6an4tqau05de9hc6vffif00r950b.apps.googleusercontent.com',
    iosBundleId: 'com.example.saphy',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC81kj_fvrRAdqwnLjvuX_1eSxq__uG5Rc',
    appId: '1:754445879555:web:c72a3706a7218a5b04c136',
    messagingSenderId: '754445879555',
    projectId: 'saphy-27f69',
    authDomain: 'saphy-27f69.firebaseapp.com',
    storageBucket: 'saphy-27f69.appspot.com',
  );
}