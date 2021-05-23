import 'package:exam_qrcode/Logic/GeneralStateManagement.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:flutter/material.dart';
import 'package:exam_qrcode/Widgets/ItemsTable.dart';
import 'package:get/get.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// ignore: must_be_immutable
class UserHistoryPage extends HookWidget {
  var _arguments = Get.arguments;
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final state = useProvider(generalmanagment);
    return WillPopScope(
      onWillPop: () async {
        state.setsearchedcourse("");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  state.setsearchwidth();
                })
          ],
          backgroundColor: redpurple,
          title: Stack(
            alignment: AlignmentDirectional.center,
            children: [
              Text("User History"),
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
          centerTitle: true,
        ),
        body: ItemsTable(
          id: _arguments[0],
          tabletype: _arguments[1],
        ),
      ),
    );
  }
}
