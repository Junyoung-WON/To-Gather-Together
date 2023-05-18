import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:to_gather_together/pages/dog_info_page.dart';
import 'package:to_gather_together/pages/splsh_screen.dart';

void main() {
  KakaoSdk.init(
    nativeAppKey: '46e40015e8e72eda888968a754148647',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '투개더',
      // home: GetDogInfoPage(),
      home: SplashScreen(),
    );
  }
}
