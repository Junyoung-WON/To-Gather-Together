import 'package:flutter/material.dart';

class TermsAgreementPage extends StatefulWidget {
  const TermsAgreementPage({super.key});

  @override
  State<TermsAgreementPage> createState() => _TermsAgreementPageState();
}

class _TermsAgreementPageState extends State<TermsAgreementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: const [
          Text(
            "서비스 이용에 대한 동의",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700
            ),
            ),
          Text(
            "원활한 서비스 이용을 위해서\n이용 약관에 대한 동의가 필요합니다.",
            ),
          
        ],
      ),
    );
  }
}