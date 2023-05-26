import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'package:fitrah/pages/Welcome/welcome_page.dart';
import 'package:fitrah/repository/auth_repository.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
        .then((value) => Get.put(AuthRepository()));
  });
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: ((context) => const MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      useInheritedMediaQuery: true, //DevicePreview purpose
      builder: DevicePreview.appBuilder, //DevicePreview purpose
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}
