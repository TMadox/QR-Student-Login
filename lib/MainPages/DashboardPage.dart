import 'package:exam_qrcode/Logic/GeneralStateManagement.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:exam_qrcode/DashBoardTabPages/StudentsTab.dart';
import 'package:exam_qrcode/DashBoardTabPages/CoursesTab.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DashboardPage extends HookWidget {
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = useProvider(generalmanagment);
    return WillPopScope(
      onWillPop: () async {
        state.setsearchedcourse("");
        return true;
      },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                actions: [
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        state.setsearchwidth();
                      })
                ],
                centerTitle: true,
                title: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Text("Dashboard"),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      width: state.searchactive ? width * 0.8 : 0,
                      child: TextField(
                        controller: _textEditingController,
                        onChanged: (value) {
                          state.setsearchedcourse(value);
                        },
                        cursorColor: indigodye,
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: indigodye)),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    )
                  ],
                ),
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
      ),
    );
  }
}
