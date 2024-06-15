import 'dart:convert';

import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/repositories/auth_repository.dart';
import 'package:do_an_mobile/models/auth_model.dart';
import 'package:do_an_mobile/views/screen/auth_screen/login_view.dart';
import 'package:flutter/material.dart';

import '../../../core/app_assets.dart';
import '../../../data_sources/constants.dart';
import '../../widget/auth_btn_widget.dart';
import '../../widget/password_input_widget.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key, required this.email});
  final String email;
  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {

  late TextEditingController passwordController = TextEditingController();
  late TextEditingController retypePasswordController = TextEditingController();
  late bool isObscure = true;
  late bool _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordController.addListener(() {
      _checkInfo();
    });
    retypePasswordController.addListener(() {
      _checkInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Password'),
      ),
      body: Container (
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column (
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.asset(AppAsset.logo),
              ),
            ),
            const SizedBox(height: 40,),
            PasswordInputWidget(type: StringConstant.password_hintText_title,
                isObscure: isObscure,
                editingController: passwordController,
                btn1: buttonIsObscure(const Icon(Icons.remove_red_eye)),
                btn2: buttonIsObscure(const Icon(Icons.remove_red_eye_outlined))
            ),
            PasswordInputWidget(type: StringConstant.retype_password_hintText_title,
                isObscure: isObscure,
                editingController: retypePasswordController,
                btn1: buttonIsObscure(const Icon(Icons.remove_red_eye)),
                btn2: buttonIsObscure(const Icon(Icons.remove_red_eye_outlined))
            ),
            Container(
                margin: const EdgeInsets.only(top: 40),
                child: ButtonAuthWidget(
                  onTap: _resetPassword,
                  text: StringConstant.sign_up_button_title,
                  checkFullInfo: _checkInfo(), isLoading: _isLoading,
                )
            ),
          ],
        ),
      ),
    );
  }

  Widget buttonIsObscure(Icon icon) {
    return IconButton(
        onPressed: () {
          setState(() {});
          isObscure = !isObscure;
        },
        icon: icon
    );
  }

  bool _checkInfo() {
    setState(() {});
    if (passwordController.text.isEmpty || retypePasswordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void _resetPassword() {
    String password = passwordController.text;
    String rpassword = retypePasswordController.text;
    if (password == rpassword) {
      setState(() {
        _isLoading = true;
      });
      AuthRepositoryImpl.shared.resetPassword(widget.email, password).then((value) {
        AuthModel authModel = AuthModel.fromJson(jsonDecode(value));
        AppShowToast.showToast(authModel.message);
        Navigator.push(context, MaterialPageRoute(builder: (context) => const loginView(),));
        setState(() {
          _isLoading = false;
        });
      },);
    }
  }
}
