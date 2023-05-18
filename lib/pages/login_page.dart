// 로그인 페이지 위젯 화면
// 카카오 로그인, 네이버 로그인

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:to_gather_together/pages/main_page.dart';
import '../http/social_login.dart';
import '../http/tgt_login.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "반갑습니다, 보호자님!",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  Text(
                    "몽글몽글을 이용하시려면 로그인이 필요합니다.\n아래에서 로그인 수단을 선택해주세요.",
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // 카카오톡 로그인 버튼
                  // 디자인 변경 필요 : kakao developer 문서 참조
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            // 카카오톡으로 로그인하여 인증
                            var response = await signInWithKakao();
                            String accessToken = response['access_token'];
                            String refreshToken = response['refresh_token'];
                            int kakaoId = response['kakao_id'];
                            print("access token : $accessToken");
                            print("kakao id : $kakaoId");
                            await storage.write(
                                key: 'access', value: accessToken);
                            await storage.write(
                                key: 'refresh', value: refreshToken);
                            if (await loginWithToken(accessToken)) {
                              // print("메인 페이지입니다!");
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: ((context) => MainPage()))
                                );
                            }
                          },
                          child: Image.asset(
                            'assets/images/kakao_login_large_wide.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: ElevatedButton.icon(
                  //         onPressed: () async {
                  //           // 카카오 로그인 동작 : 카카오 로그인 완료 후 받은 accessToken을 서비스 서버로 전달
                  //           signInWithKakao();
                  //         },
                  //         style: ElevatedButton.styleFrom(
                  //             backgroundColor: Color(0xFFFEE500),
                  //             shape: RoundedRectangleBorder(
                  //               side: BorderSide.none,
                  //               borderRadius: BorderRadius.circular(12)
                  //             )
                  //           ),
                  //         icon: Icon(Icons.message),
                  //         label: Text(
                  //           "카카오 로그인",
                  //           style: TextStyle(
                  //             color: Color.fromRGBO(0, 0, 0, 0.85),
                  //           ),),
                  //       ),
                  //     ),
                  //   ],
                  // ),

                  // 네이버 로그인 버튼
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            // 네이버 로그인 동작 : 네이버 로그인 완료 후 받은 accessToken을 서비스 서버로 전달
                            signInWithNaver();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF06BD34)),
                          icon: Icon(Icons.add),
                          label: Text("네이버 로그인"),
                        ),
                      ),
                    ],
                  ),
                  // 구글 로그인 버튼
                  // ElevatedButton.icon(
                  //   onPressed: () {},
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.white,
                  //     foregroundColor: Colors.black,
                  //     shape: RoundedRectangleBorder(
                  //         side: BorderSide(color: Colors.grey),
                  //         borderRadius: BorderRadius.circular(5)),
                  //   ),
                  //   icon: Icon(Icons.g_translate),
                  //   label: Text("Google로 시작하기"),
                  // ),
                  Divider(
                    thickness: 1.5,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text("이메일로 회원가입"),
                  ),
                ],
              ),
            ),
            SizedBox(height: 60),
            Column(
              children: [
                Text(
                  "이메일 아이디가 있으신가요?",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                TextButton(
                  onPressed: () async {
                    await FlutterNaverLogin.logOutAndDeleteToken();
                  },
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
