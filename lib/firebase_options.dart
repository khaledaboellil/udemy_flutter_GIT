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
    apiKey: 'AIzaSyA2Ab4Q1jnHFklSh4JZQYnGa4a0DQorG_Y',
    appId: '1:252225173692:android:ff824b5a353e0f259778b9',
    messagingSenderId: '252225173692',
    projectId: 'social-app-a5614',
    storageBucket: 'social-app-a5614.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD4bqIKAf-zKb90dpH0q6Kzf1uknGkz0l0',
    appId: '1:252225173692:ios:b9ae0cf8225092589778b9',
    messagingSenderId: '252225173692',
    projectId: 'social-app-a5614',
    storageBucket: 'social-app-a5614.appspot.com',
    androidClientId: '252225173692-sgvqo2d74km32fj9kdtuqr6tcskepp79.apps.googleusercontent.com',
    iosClientId: '252225173692-gfd1iek30j5t9p7la14iiqpjlo31l2uh.apps.googleusercontent.com',
    iosBundleId: 'com.example.todoApp',
  );
}
