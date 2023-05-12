import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

/*
  반환할 Map의 구성
  {
    'login success' : (int)success code,    // 200(성공), 401(액세스 토큰 만료),
    'accessToken' : (String)access token,   // 리프레시 토큰으로 재발급받은 액세스 토큰
  }
 */
// 이렇게 할까 아니면
/*
  액세스 토큰 로그인 메소드 따로,
  액세스 토큰 만료 시 리프레시 토큰을 통한 액세스 토큰 재발급 매소드 따로 구현할까
 */
// 우선 따로 구현해보자

Future<bool> loginWithToken(String tgtAccessToken) async {
  tgtAccessToken = "Bearer $tgtAccessToken";
  try {
    print("투개더 토큰으로 투개더 서버 로그인 (테스트)");
    final url = Uri.parse('http://211.57.200.6:5000/user/verify');
    var response = await http.post(
      url,
      headers: {HttpHeaders.authorizationHeader: tgtAccessToken},
    );
    print('response status code: ${response.statusCode}');
    // 액세스 토큰으로 로그인 성공
    if (response.statusCode == 200) {
      print("투개더 로그인 성공");
      print(response.body);
      return true;
    }
    print("투개더 로그인 실패");
    print(response.body);
    return false;
  } catch (error) {
    print('투개더 로그인 실패');
    print(error.toString());
    return false;
  }
}

Future<String> getAccessToken(String tgtRefreshToken) async {
  tgtRefreshToken = "Bearer $tgtRefreshToken";
  String newAccessToken = "";
  try {
    final url = Uri.parse('http://211.57.200.6:5000/user/refresh');
    print("액세스 토큰 만료, 리프레시 토큰으로 토큰 재발급");
    var response = await http.post(
      url,
      headers: {HttpHeaders.authorizationHeader: tgtRefreshToken},
    );
    print('response status code: ${response.statusCode}');
      var responseBody = jsonDecode(response.body);
      print(response.body);
    // 리프레시 토큰으로 로그인 성공
    if (response.statusCode == 200) {
      print("액세스 토큰 재발급 성공");
      newAccessToken = responseBody['access_token'];
    }
    else if(response.statusCode == 401){
      print("리프레시 토큰 만료, 액세스 토큰 재발급 실패");
    }
    return newAccessToken;
  } catch (error) {
    print("액세스 토큰 재발급 실패");
    print(error.toString());
    return "";
  }
}
