import 'package:flutter/material.dart';
import 'package:to_gather_together/widgets/bottom_nav.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  late TabController controller;
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "test",
        home: DefaultTabController(
            length: 5,
            child: Scaffold(
              body: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: <Widget>[
                    Container(),
                    Container(),
                    Container(),
                    Container(),
                    Container()
                  ]),
              bottomNavigationBar: Bottom(),
            )));
  }
}
