import 'dart:convert';

import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/managers/repositories/auth_repository.dart';
import 'package:do_an_mobile/models/auth_model.dart';
import 'package:do_an_mobile/views/screen/auth_screen/forgot_password_otp_view.dart';
import 'package:do_an_mobile/views/widget/auth_btn_widget.dart';
import 'package:do_an_mobile/views/widget/email_input_widget.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late TextEditingController emailController = TextEditingController();
  late bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      _checkInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Forgot Password'),
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    EmailInputWidget(
                        hintText: 'Email',
                        editingController: emailController,
                        icon: const Icon(Icons.person_2_outlined)),
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: ButtonAuthWidget(
                          onTap: _authEmail,
                          text: 'Next',
                          checkFullInfo: _checkInfo()),
                    ),
                  ],
                ),
              )
    );
  }

  bool _checkInfo() {
    setState(() {});
    if (emailController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void _authEmail() {
    String email = emailController.text;
    Future.delayed(const Duration(seconds: 0)).then((_) {
      setState(() {
        _isLoading = true;
      });
      AuthRepositoryImpl.shared.forgotEmail(email).then((value){
        AuthModel authModel = AuthModel.fromJson(jsonDecode(value));
        if (authModel.code == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ForgotOtpView(email: email))
          );
        } else {
          AppShowToast.showToast(authModel.message);
        }
        setState(() {
          _isLoading = false;
        });
      });
    });
  }
}
