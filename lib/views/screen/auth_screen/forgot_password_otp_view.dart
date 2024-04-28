import 'dart:convert';

import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/models/auth_model.dart';
import 'package:do_an_mobile/views/screen/auth_screen/login_view.dart';
import 'package:do_an_mobile/views/widget/auth_btn_widget.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../data_sources/constants.dart';
import '../../../data_sources/repositories/auth_repository.dart';

class ForgotOtpView extends StatefulWidget {
  const ForgotOtpView({super.key, required this.email});
  final String email;
  @override
  State<ForgotOtpView> createState() => _ForgotOtpViewState();
}

class _ForgotOtpViewState extends State<ForgotOtpView> {
  TextEditingController codeController = TextEditingController();
  late bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        centerTitle: true,
        title: const Text(StringConstant.verification_title),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: Center (
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                length: 6,
                controller: codeController,
                onChanged: (value) {

                },
                keyboardType: TextInputType.phone
              ),
              const SizedBox(height: 50),
              Container(
                margin: const EdgeInsets.only(top: 20),
                child: ButtonAuthWidget(
                    onTap: _sendOtp,
                    text: StringConstant.send_otp_button_title,
                    checkFullInfo: _checkInfo(), isLoading: _isLoading,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _checkInfo() {
    return true;
  }

  void _sendOtp() {
    String otp = codeController.text;
    setState(() {
      _isLoading = true;
    });
    Future.delayed(const Duration(seconds: 30)).then((_){
      AuthRepositoryImpl.shared.forgotOtp(widget.email, otp).then((value){
        AuthModel auth = AuthModel.fromJson(jsonDecode(value));
        if (auth.code == 200) {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const loginView())
          );
        } else {
          AppShowToast.showToast(auth.message);
        }
        setState(() {
          _isLoading = false;
        });
      });
    });
  }
}
