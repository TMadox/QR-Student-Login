import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:exam_qrcode/Logic/GeneralStateManagement.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'ColorsNConstants.dart';

// ignore: must_be_immutable
class ItemsTable extends HookWidget {
  String id;
  String tabletype;
  ItemsTable({@required this.id, @required this.tabletype});
  @override
  Widget build(BuildContext context) {
    final state = useProvider(generalmanagment);
    return StreamBuilder<QuerySnapshot>(
      stream: state.searchedcourse.isNotEmpty
          ? FirebaseFirestore.instance
              .collection(tabletype == userscollection
                  ? userscollection
                  : coursescollection)
              .doc(id)
              .collection("History")
              .where(tabletype == userscollection ? coursename : studentid,
                  isEqualTo: state.searchedcourse)
              .snapshots()
          : FirebaseFirestore.instance
              .collection(tabletype == userscollection
                  ? userscollection
                  : coursescollection)
              .doc(id)
              .collection("History")
              .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              showBottomBorder: true,
              showCheckboxColumn: true,
              sortAscending: true,
              columns: snapshot.data.docs
                  .elementAt(0)
                  .data()
                  .keys
                  .map((e) => DataColumn(label: Text(e)))
                  .toList(),
              rows:
                  snapshot.data.docs.map<DataRow>((DocumentSnapshot document) {
                return DataRow(
                    color: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.selected))
                        return redpurple.withOpacity(0.2);
                      return null;
                    }),
                    cells: document.data().keys.map((e) {
                      if (document.data()[e] is Timestamp) {
                        return DataCell(
                            Text(document.data()[e].toDate().toString()));
                      }
                      return DataCell(Text(document.data()[e].toString()));
                    }).toList());
              }).toList(),
            ),
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
    );
  }
}
