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
    apiKey: 'AIzaSyBtcEeG7pjjyT4NDV9vXVWMWfRx-_U91sU',
    appId: '1:726323920460:web:1d29fba43c53f199e13ee9',
    messagingSenderId: '726323920460',
    projectId: 'memory-game-16a4b',
    authDomain: 'memory-game-16a4b.firebaseapp.com',
    storageBucket: 'memory-game-16a4b.appspot.com',
    measurementId: 'G-DKR479RHL1',
  );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC-UCze4sG-hmoU2801eAIEBUiKoxdpOpc',
    appId: '1:726323920460:android:f6111f6bef86f5bee13ee9',
    messagingSenderId: '726323920460',
    projectId: 'memory-game-16a4b',
    storageBucket: 'memory-game-16a4b.appspot.com',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFPL2WaP-lwzZCIYwmXWrxNFlimrfWj-E',
    appId: '1:726323920460:ios:944f77a4890cd46ae13ee9',
    messagingSenderId: '726323920460',
    projectId: 'memory-game-16a4b',
    storageBucket: 'memory-game-16a4b.appspot.com',
    androidClientId: '726323920460-n6o4fu7u4q6sr4k1nb81bbt3459sq4q7.apps.googleusercontent.com',
    iosClientId: '726323920460-fjb6nko9lv62cvas0c246les74tbpp3h.apps.googleusercontent.com',
    iosBundleId: 'com.example.memGame',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDFPL2WaP-lwzZCIYwmXWrxNFlimrfWj-E',
    appId: '1:726323920460:ios:031c43ba59cd0fb4e13ee9',
    messagingSenderId: '726323920460',
    projectId: 'memory-game-16a4b',
    storageBucket: 'memory-game-16a4b.appspot.com',
    androidClientId: '726323920460-n6o4fu7u4q6sr4k1nb81bbt3459sq4q7.apps.googleusercontent.com',
    iosClientId: '726323920460-j1l5l4a26po6od4bjqpl23c6fs3bvfbf.apps.googleusercontent.com',
    iosBundleId: 'com.example.memGame.RunnerTests',
  );
}