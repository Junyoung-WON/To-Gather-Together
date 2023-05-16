import 'dart:async';
import 'dart:convert';
// import 'dart:io';
import 'package:http/http.dart' as http;

Future<dynamic> getWeatherReq() async {
  String serviceKey =
      'YA+ukx3XZMaIWy4wjnEJIdCj94eQtJdQIjz4SO95oT1ScO8eyBJVQIxvZZvBf07rQPMIsVeT1knarShG9t0pTA==';
  var uri = Uri.http(
      'apis.data.go.kr', '1360000/VilageFcstInfoService_2.0/getVilageFcst', {
    // 서비스키
    'serviceKey': serviceKey,
    // 페이지번호
    'pageNo': '1',
    // 한 페이지 결과 수
    'numOfRows': '120',
    // 데이터 타입(XML / JSON)
    'dataType': 'JSON',
    // 발표 일자
    'base_date': '20230323',
    // 발표 시각
    'base_time': '1700',
    // 예보지점 x좌표
    'nx': '92',
    // 예보지점 y좌표
    'ny': '90'
  });
  print(uri);
  var response = await http.get(uri);
  if (response.statusCode == 200) {
    print('status code : 200');
    print('response.body : ');
    print(response.body);
    return response.body;
  }
  return null;
}

Future<dynamic> getAnimalInfoReq(
    String regNo, String ownerName, String ownerBirth) async {
  String serviceKey =
      'YA+ukx3XZMaIWy4wjnEJIdCj94eQtJdQIjz4SO95oT1ScO8eyBJVQIxvZZvBf07rQPMIsVeT1knarShG9t0pTA==';
  var uri = Uri.http('apis.data.go.kr', '1543061/animalInfoSrvc/animalInfo', {
    // 서비스키
    'serviceKey': serviceKey,
    // 동물 등록 번호
    'dog_reg_no': regNo,
    // 또는 RFID 코드
    // 'rfid_cd': '',
    // 소유자 이름
    'owner_nm': ownerName.isEmpty ? null : ownerName,
    // 또는 소유자 생년월일
    'owner_birth': ownerBirth.isEmpty ? null : ownerBirth,
    // 응답형태 (XML / JSON)
    '_type': 'json'
  });
  // print(uri);

  var response = await http.get(uri);
  // 동물 등록 조회 성공 시
  print('status code : ${response.statusCode}');
  if (response.statusCode == 200) {
    print('response.body : ${response.body}');
    var body = json.decode(response.body);
    print('response[\'body\'] : ${body['response']['body']}');
    return body['response']['body'];
  }

  return null;
}
