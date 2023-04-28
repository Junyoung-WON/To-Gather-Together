import 'package:flutter/material.dart';
import 'dart:async';

// 어플 시작 시 첫 로딩 화면(인트로 화면)
// 로고, 어플 이름
// 필요한 정보를 로드함

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  // 개발중
  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(Duration(seconds: 2), () => {
  //     // 2초 내 화면이동
  //     moveScreen()
  //   });
  // }

  // void moveScreen() async {
  //   await checkLogin().then((isLogin) {
  //   if (isLogin) {
  //     Navigator.of(context).pushReplacementNamed(
  //         MaterialPageRoute(builder: (context) => MainPage()));
  //   } else {
  //     Navigator.of(context).pushReplacementNamed(
  //         MaterialPageRoute(builder: (context) => LoginPage()));
  //   }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: const [Text('내 아이와 함께, 투개더!')]),
      ),
    );
  }
}
