import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:king/screens/auth/sign_up.dart';

import 'firebase_options.dart';

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,

    initialRoute: 'signUp',

    routes: {
      'signUp' : (context) => SignUpScreen(),
    },
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  if (WebRTC.platformIsDesktop) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  } else if (WebRTC.platformIsAndroid) {
    //startForegroundService();
  }

}
