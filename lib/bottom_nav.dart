import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  const Bottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        height: 80, // 바텀바의 높이를 70으로 변경
        child: TabBar(
          labelColor: Colors.black,
          unselectedLabelColor: Colors.blue,
          indicatorColor: Colors.transparent,
          tabs: const <Widget>[
            Tab(
              icon: Icon(
                Icons.forum,
                size: 18,
              ),
              child: Text(
                '커뮤니티',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.shopping_basket,
                size: 18,
              ),
              child: Text(
                '장터',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.pets,
                size: 18,
              ),
              child: Text(
                '산책',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.info_outline,
                size: 18,
              ),
              child: Text(
                '마이페이지',
                style: TextStyle(fontSize: 9),
              ),
            ),
            Tab(
              icon: Icon(
                Icons.calendar_month_sharp,
                size: 18,
              ),
              child: Text(
                '달력',
                style: TextStyle(fontSize: 9),
              ),
            )
          ],
        ),
      ),
    );
  }
}