import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android;
    }
    throw UnsupportedError(
      'DefaultFirebaseOptions are only configured for Android platform.',
    );
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTA8WgfGhOwk_TEJw20bnPC97WgXuJoZk',
    appId: '1:704079006542:android:c6c8311a56784abd476c1f',
    messagingSenderId: '704079006542',
    projectId: 'heart-disease-prediction-66f81',
    storageBucket: 'heart-disease-prediction-66f81.appspot.com',
    androidClientId: '704079006542-mv60hoa3drp8nfafisjf6sskdpkobj84.apps.googleusercontent.com',
  );
}
