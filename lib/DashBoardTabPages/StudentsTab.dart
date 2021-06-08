import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_qrcode/MainPages/StudentProfile.dart';
import 'package:flutter/material.dart';
import 'package:exam_qrcode/Logic/FireBaseManagment.dart';
import 'package:exam_qrcode/Logic/GeneralStateManagement.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:exam_qrcode/MainPages/UserHistoryPage.dart';

class StudentsTab extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final state = useProvider(generalmanagment);
    return Container(
        child: StreamBuilder<QuerySnapshot>(
      stream: state.searchedcourse.isNotEmpty
          ? FirebaseFirestore.instance
              .collection(userscollection)
              .where(studentid, isEqualTo: state.searchedcourse)
              .snapshots()
          : FirebaseFirestore.instance.collection(userscollection).snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          return ListView(
            children: snapshot.data.docs
                .map((e) => Card(
                      child: ListTile(
                        selected: state.selecteditems.contains(e.id),
                        selectedTileColor: skyblue,
                        onTap: () {
                          Get.to(() => StudentProfile(), arguments: e.id);
                        },
                        onLongPress: () {
                          state.selecteditems.contains(e.id)
                              ? state.removefromselecteditems(e.id)
                              : state.addtoselecteditems(e.id);
                        },
                        leading: Text(
                          e.data()[studentname],
                          style: TextStyle(color: indigodye),
                        ),
                        trailing: Text(
                          e.data()[studentid],
                          style: TextStyle(color: indigodye),
                        ),
                      ),
                    ))
                .toList(),
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text("Error"),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    ));
  }
}
//  {
//               return ListView(
//                 children: data.docs
//                     .map((e) => Card(
//                           child: ListTile(
//                             selected: state.selecteditems.contains(e.id),
//                             selectedTileColor: skyblue,
//                             onTap: () {
//                               Get.to(() => StudentProfile(), arguments: e.id);
//                             },
//                             onLongPress: () {
//                               state.selecteditems.contains(e.id)
//                                   ? state.removefromselecteditems(e.id)
//                                   : state.addtoselecteditems(e.id);
//                             },
//                             leading: Text(
//                               e.data()[studentname],
//                               style: TextStyle(color: indigodye),
//                             ),
//                             trailing: Text(
//                               e.data()[studentid],
//                               style: TextStyle(color: indigodye),
//                             ),
//                           ),
//                         ))
//                     .toList(),
//               );
//             },