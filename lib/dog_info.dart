import 'package:flutter/material.dart';
import 'package:to_gather_together/http/http.dart';

class GetDogInfoPage extends StatelessWidget {
  const GetDogInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        // 상단 제목 및 설명
        SizedBox(
          child: Column(
            children: const [
              Text(
                '반려견을 검색합니다!',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              Text('현재 기르고 있는 반려견의 정보를\n동물 등록번호로 조회합니다.')
            ],
          ),
        ),

        // 입력 필드
        Form(
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  label: Text('동물등록번호'),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('소유자 이름'),
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  label: Text('소유자 생년월일'),
                ),
              ),
            ],
          ),
        ),

        // 버튼?
        ElevatedButton(
          onPressed: () {
            // 제출 및 동물 등록 조회
            getAnimalInfoReq('동물 등록 번호','소유자 이름');
          },
          child: Text('조회'),
        ),

        // 하단 추가 설명 : 조회하는 이유 등
      ]),
    );
  }
}
