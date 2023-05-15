import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:to_gather_together/login_page.dart';
import 'package:to_gather_together/http/tgt_login.dart';
import 'package:to_gather_together/main_page.dart';

// 어플 시작 시 첫 로딩 화면(인트로 화면)
// 로고, 어플 이름
// 필요한 정보를 로드할 수 있음

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  static final storage = FlutterSecureStorage();
  String accessToken = '';
  String refreshToken = '';
  bool isLogin = false;
  bool isLoginError = false;
  final String imageLogo = 'assets/images/togather_logo.png';

  @override
  void initState() {
    super.initState();
    // 비동기(async-await)로 flutter secure storage 정보를 불러오는 작업 수행
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _tgtLogin();
    });

    // 2초 후 화면이동
    Timer(Duration(seconds: 2), () {
      if (isLoginError) {
        exit(0);
      }
      if (isLogin) {
        // 로그인에 성공하게되면 메인화면
        Navigator.push(context, MaterialPageRoute(builder: ((context) => MainPage())));
        print("메인화면입니다!");
      } else {
        // 토큰이 비어있거나 로그인 실패 시 소셜 로그인 화면
        Navigator.push(
            context, MaterialPageRoute(builder: ((context) => LoginPage())));
      }
    });
  }

  _tgtLogin() async {
    // 투개더 액세스, 리프레시 토큰을 SecureStorage에서 불러옴
    accessToken = (await storage.read(key: 'access'))!;
    refreshToken = (await storage.read(key: 'refresh'))!;
    // print("access token from storage : $accessToken");
    // print(accessToken.runtimeType);
    // print("refresh token from storage : $refreshToken");
    // print(refreshToken.runtimeType);

    // 내부 저장소에 access token이 없는 경우 -> 새로운 사용자
    if (accessToken.isEmpty) {
      // 로그인 페이지로 이동
      print("로그인 토큰이 존재하지 않습니다. 잠시 후 로그인 페이지로 이동합니다.");
      setState(() {
        isLogin = false;
      });
    }
    // 내부 저장소에 access token이 있는 경우 -> 기존 사용자
    else {
      // 토큰으로 로그인
      if (await loginWithToken(accessToken)) {
        // 로그인 성공하면 메인페이지로 이동
        print("로그인 토큰으로 로그인에 성공하였습니다. 잠시 후 메인페이지로 이동합니다.");
        setState(() {
          isLogin = true;
        });
      } else {
        // 액세스 토큰 만료, 리프레시 토큰으로 새로운 토큰 받기
        print("액세스 토큰이 만료되어 리프레시 토큰으로 새로운 액세스 토큰 발급");
        accessToken = await getAccessToken(refreshToken);

        if (accessToken.isNotEmpty) {
          await storage.write(key: 'access', value: accessToken);
          if (await loginWithToken(accessToken)) {
            print("로그인 토큰으로 로그인에 성공하였습니다. 잠시 후 메인페이지로 이동합니다.");
            setState(() {
              isLogin = true;
            });
          }
        } else {
          print("투개더 로그인에 실패하였습니다. 소셜 로그인을 진행합니다.");
          // print("로그인에 실패하였습니다. 네트워크 문제일 가능성이 높습니다.\n앱이 종료됩니다. 잠시 후 다시 시도해주세요.");
          // setState(() {
          //   isLoginError = true;
          // });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            SizedBox(
              width: 150,
              child: Image.asset(
                imageLogo,
                fit: BoxFit.fitWidth,
              ),
            ),
            Text('내 아이와 함께, 투개더!')
          ]),
        ),
      ),
    );
  }
}
