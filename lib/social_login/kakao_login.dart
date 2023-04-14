import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void signInWithKakao() async {
  try {
    bool installed = await isKakaoTalkInstalled();
    OAuthToken token = installed
        ? await UserApi.instance.loginWithKakaoTalk()
        : await UserApi.instance.loginWithKakaoAccount();
    print('token : $token');
    final url = Uri.parse('http://211.57.200.6:5000/oauth');
    var response = await http.get(
      url,
      headers: {HttpHeaders.authorizationHeader: token.accessToken},
    );
    print('response status code: ${response.statusCode}');
    print(response.body);
  } catch (error) {
    print(error.toString());
    print('카카오톡 로그인 실패');
  }
}
