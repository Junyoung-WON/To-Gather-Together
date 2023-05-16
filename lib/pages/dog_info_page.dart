import 'package:flutter/material.dart';
import 'package:to_gather_together/http/http.dart';
import 'package:to_gather_together/widgets/custom_text_form_field.dart';

class GetDogInfoPage extends StatefulWidget {
  const GetDogInfoPage({super.key});

  @override
  State<GetDogInfoPage> createState() => _GetDogInfoPageState();
}

class _GetDogInfoPageState extends State<GetDogInfoPage> {
  final _formKey = GlobalKey<FormState>();
  late FocusNode _nameFocusNode;
  late FocusNode _birthFocusNode;
  String _regNo = '';
  String _ownerName = '';
  String _ownerBirth = '';

  @override
  void initState() {
    _nameFocusNode = FocusNode();
    _birthFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameFocusNode.dispose();
    _birthFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20.0),
          child: Column(children: [
            // 상단 제목 및 설명
            Container(
              padding: EdgeInsets.symmetric(vertical: 20),
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Expanded(
                        child: Text(
                          '반려견을 검색합니다!',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 24),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: const [
                      Expanded(
                        child: Text('현재 기르고 있는 반려견의 정보를\n동물 등록번호로 조회합니다.'),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // 입력 필드
            Container(
              margin: EdgeInsets.symmetric(vertical: 20),
              height: 320,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // 동물등록번호
                    CustomTextFormField(
                      label: '동물등록번호',
                      hintText: '15자리 숫자',
                      onSaved: (newValue) {
                        setState(() {
                          _regNo = newValue as String;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '동물등록번호를 입력하세요.';
                        }
                        if (!RegExp(r'^\d{15}$').hasMatch(value)) {
                          return '동물등록번호는 15자리의 숫자입니다.';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    // 소유자 이름
                    CustomTextFormField(
                      label: '소유자 이름',
                      hintText: '',
                      onSaved: (newValue) {
                        setState(() {
                          _ownerName = newValue as String;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '소유자의 이름을 입력하세요.';
                        }
                        if (value.length < 2) {
                          return '이름을 2글자 이상 입력하세요.';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.next,
                      focusNode: _nameFocusNode,
                      onFieldSubmitted: (_) =>
                          FocusScope.of(context).requestFocus(_birthFocusNode),
                    ),
                    // 소유자 생년월일
                    CustomTextFormField(
                      label: '소유자 생년월일',
                      hintText: '주민등록번호 앞 6자리',
                      onSaved: (newValue) {
                        setState(() {
                          _ownerBirth = newValue as String;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '소유자의 생년월일을 입력하세요.';
                        }
                        if (!RegExp(r'^\d{6}$').hasMatch(value)) {
                          return '6자리의 숫자(주민번호 앞 6자리)로 입력해주세요.';
                        }
                        return null;
                      },
                      textInputAction: TextInputAction.none,
                      focusNode: _birthFocusNode,
                    ),
                  ],
                ),
              ),
            ),

            // 버튼?
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  // 제출 및 동물 등록 조회
                  print(
                      '_regNo: $_regNo, _ownerName: $_ownerName, _ownerBirth: $_ownerBirth');
                  getAnimalInfoReq(_regNo, _ownerName, _ownerBirth);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('올바른 형식을 작성해주세요.'),
                    duration: Duration(seconds: 4),
                  ));
                }
              },
              child: Text('조회'),
            ),

            // 하단 추가 설명 : 조회하는 이유 등
            //
          ]),
        ),
      ),
    );
  }
}
