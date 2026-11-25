import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      default:
        return web;
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyB136WyFhSFeZnid1ctljHcJAxqvQxUDW0',
    appId: '1:152579458315:web:e5e8e8201f364162214e0e',
    messagingSenderId: '152579458315',
    projectId: 'capstone-32782',
    authDomain: 'capstone-32782.firebaseapp.com',
    storageBucket: 'capstone-32782.firebasestorage.app',
    databaseURL:
        'https://capstone-32782-default-rtdb.asia-southeast1.firebasedatabase.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB136WyFhSFeZnid1ctljHcJAxqvQxUDW0',
    appId: '1:152579458315:web:e5e8e8201f364162214e0e',
    messagingSenderId: '152579458315',
    projectId: 'capstone-32782',
    storageBucket: 'capstone-32782.firebasestorage.app',
    databaseURL:
        'https://capstone-32782-default-rtdb.asia-southeast1.firebasedatabase.app',
  );
}