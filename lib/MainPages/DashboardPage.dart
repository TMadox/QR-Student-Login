import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:exam_qrcode/DashBoardTabPages/StudentsTab.dart';
import 'package:exam_qrcode/DashBoardTabPages/CoursesTab.dart';

class DashboardPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
              actions: [IconButton(icon: Icon(Icons.search), onPressed: () {})],
              centerTitle: true,
              title: Stack(
                children: [
                  Text("Dashboard"),
                ],
              ),
              leading:
                  IconButton(icon: Icon(Icons.select_all), onPressed: () {}),
              backgroundColor: redpurple,
              bottom: TabBar(indicatorColor: Colors.white, tabs: [
                Tab(
                  text: "Students",
                  icon: Icon(Icons.person),
                ),
                Tab(
                  text: "Courses",
                  icon: Icon(Icons.book),
                )
              ])),
          backgroundColor: indigodye,
          body: TabBarView(children: [StudentsTab(), CoursesTab()])),
    );
  }
}
