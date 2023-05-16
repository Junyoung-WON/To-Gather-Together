import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

enum LoginPlatform {
  kakao,
  naver,
  // apple,
  // google,
  // facebook,
  none, // logout
}

// 카카오 소셜 로그인 : 로그인 성공 시 카카오톡의 인증 토큰을 발급받음
Future<dynamic> signInWithKakao() async {
  try {
    bool installed = await isKakaoTalkInstalled();
    OAuthToken token = installed
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();
    print('token : $token');
    final url = Uri.parse('http://211.57.200.6:5000/user/kakao_oauth');
    var response = await http.post(
      url,
      headers: {HttpHeaders.authorizationHeader: token.accessToken},
    );
    print('response status code: ${response.statusCode}');
    print(response.body);
    var responseList = jsonDecode(response.body);
    return responseList;
  } catch (error) {
    print('카카오톡 로그인 실패');
    print(error.toString());
    return null;
  }
}

// 네이버 소셜 로그인
void signInWithNaver() async {
  final NaverLoginResult result = await FlutterNaverLogin.logIn();
  NaverAccessToken token = await FlutterNaverLogin.currentAccessToken;

  if (result.status == NaverLoginStatus.loggedIn) {
    print('accessToken = ${token.accessToken}');
    print('expireTime = ${token.expiresAt}');
    print('refreshToken = ${token.refreshToken}');
    print('tokenType = ${token.tokenType}');
    print('\nid = ${result.account.id}');
    print('email = ${result.account.email}');
    print('name = ${result.account.name}');
  }
}
