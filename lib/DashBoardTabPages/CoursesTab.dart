import 'package:flutter/material.dart';
import 'package:exam_qrcode/Logic/FireBaseManagment.dart';
import 'package:exam_qrcode/Logic/GeneralStateManagement.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:exam_qrcode/MainPages/UserHistoryPage.dart';

class CoursesTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final stream = useProvider(firebasecoursestream);
    final state = useProvider(generalmanagment);
    return Container(
        child: stream.when(
            data: (data) {
              return ListView(
                children: data.docs
                    .map((e) => Card(
                          child: ListTile(
                            selected: state.selecteditems.contains(e.id),
                            selectedTileColor: skyblue,
                            onTap: () {
                              Get.to(() => UserHistoryPage(), arguments: [e.id,coursescollection]);
                            },
                            onLongPress: () {
                              state.selecteditems.contains(e.id)
                                  ? state.removefromselecteditems(e.id)
                                  : state.addtoselecteditems(e.id);
                            },
                            leading: Text(
                              e.data()["Name"],
                              style: TextStyle(color: indigodye),
                            ),
                            trailing: Text(
                              e.data()["Department"],
                              style: TextStyle(color: indigodye),
                            ),
                          ),
                        ))
                    .toList(),
              );
            },
            loading: () => CircularProgressIndicator(),
            error: (error, s) => Text(s.toString())));
  }
}
