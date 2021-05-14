import 'package:exam_qrcode/Logic/FireBaseManagment.dart';
import 'package:exam_qrcode/Logic/GeneralStateManagement.dart';
import 'package:exam_qrcode/MainPages/HomePage.dart';
import 'package:exam_qrcode/Widgets/ColorsNConstants.dart';
import 'package:exam_qrcode/Widgets/MainButtons.dart';
import 'package:exam_qrcode/Widgets/TextFields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

// ignore: must_be_immutable
class LoginPage extends HookWidget {
  GlobalKey<FormState> _gkey = GlobalKey<FormState>();
  var _id;
  var _password;
  @override
  Widget build(BuildContext context) {
    final state = useProvider(generalmanagment);
    return Scaffold(
        backgroundColor: indigodye,
        body: ModalProgressHUD(
          progressIndicator: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(skyblue),
          ),
          inAsyncCall: state.isloading,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: width * 0.9,
                  child: Form(
                    key: _gkey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        CustomTextField(
                          icon: Icons.perm_identity,
                          hinttext: "Enter your ID",
                          onsubmit: (value) {
                            _id = value;
                          },
                          color: skyblue,
                        ),
                        CustomTextField(
                          icon: Icons.vpn_key,
                          hinttext: "Enter your Password",
                          onsubmit: (value) {
                            _password = value;
                          },
                          color: skyblue,
                        ),
                      ],
                    ),
                  ),
                ),
                FirstButtons(
                  onpressed: () {
                    validation(state);
                  },
                  label: "Login",
                  icon: Icons.login,
                  color: skyblue,
                  labelcolor: indigodye,
                  iconcolor: indigodye,
                ),
              ],
            ),
          ),
        ));
  }

  void validation(state) async {
    if (_gkey.currentState.validate()) {
      _gkey.currentState.save();
      try {
        state.setloadingstate();
        await studentlogin(_id, _password);
        state.setloadingstate();
        Get.off(() => HomePage());
      } catch (e) {
        Get.snackbar("Error", e.message);
        state.setloadingstate();
      }
    }
  }
}
