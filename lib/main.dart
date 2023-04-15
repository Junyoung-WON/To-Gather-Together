import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:mgmg_front/social_login/kakao_login.dart';

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
      title: '몽글몽글',
      home: const MyHomePage(title: '카카오 로그인 테스트'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // void _getUserInfo() async {
  //   try {
  //     User user = await UserApi.instance.me();
  //     print('사용자 정보 요청 성공'
  //         '\n회원번호: ${user.id}'
  //         '\n닉네임: ${user.kakaoAccount?.profile?.nickname}'
  //         '\n이메일: ${user.kakaoAccount?.email}');
  //   } catch (error) {
  //     print('사용자 정보 요청 실패 $error');
  //   }
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 60),
            Text(
              "반갑습니다, 보호자님!",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              "몽글몽글을 이용하시려면 로그인이 필요합니다.\n아래에서 로그인 수단을 선택해주세요.",
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 60),
            Column(
              children: [
                // 카카오톡 로그인 버튼
                // 디자인 변경 필요 : kakao developer 문서 참조
                ElevatedButton.icon(
                  onPressed: () async {
                    // 카카오 로그인 동작 : 카카오 로그인 완료 후 받은 accessToken을 서비스 서버로 전달
                    signInWithKakao();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFAE100)),
                  icon: Icon(Icons.message),
                  label: Text("카카오톡으로 시작하기"),
                ),

                // 네이버 로그인 버튼
                ElevatedButton.icon(
                  onPressed: () async {
                    // 네이버 로그인 동작 : 네이버 로그인 완료 후 받은 accessToken을 서비스 서버로 전달
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF06BD34)),
                  icon: Icon(Icons.add),
                  label: Text("네이버로 시작하기"),
                ),

                ElevatedButton.icon(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5)),
                  ),
                  icon: Icon(Icons.g_translate),
                  label: Text("Google로 시작하기"),
                ),
                Divider(),
                TextButton(
                  onPressed: () {},
                  child: Text("이메일로 회원가입"),
                ),
              ],
            ),
            SizedBox(height: 60),
            Column(
              children: [
                Text(
                  "이메일 아이디가 있으신가요?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text("이메일로 로그인"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
