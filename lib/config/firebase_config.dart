// Firebase Configuration Template
// Follow the Firebase setup guide to get your credentials

import 'package:firebase_core/firebase_core.dart';

class FirebaseConfig {
  // TODO: Replace with your Firebase project credentials
  static const String projectId = 'nexus-training-tracker';

  static Future<void> initialize() async {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'YOUR_API_KEY',
        appId: 'YOUR_APP_ID',
        messagingSenderId: 'YOUR_SENDER_ID',
        projectId: projectId,
        authDomain: 'nexus-training-tracker.firebaseapp.com',
        storageBucket: 'nexus-training-tracker.appspot.com',
        iosBundleId: 'com.nexus.training.tracker',
      ),
    );
  }
}

// Setup Instructions:
// 1. Create a Firebase project at https://console.firebase.google.com
// 2. Create iOS and Android apps within the project
// 3. Download google-services.json (Android) and GoogleService-Info.plist (iOS)
// 4. Place them in the appropriate directories:
//    - Android: android/app/
//    - iOS: ios/Runner/
// 5. Enable Authentication, Firestore, and Storage in Firebase Console
// 6. Update the credentials above with your actual values
// 7. Run: flutterfire configure (requires flutterfire CLI)
