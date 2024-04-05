import 'dart:convert';

import 'package:do_an_mobile/core/app_assets.dart';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/models/auth_model.dart';
import 'package:do_an_mobile/views/screen/auth_screen/forgot_password_view.dart';
import 'package:do_an_mobile/views/screen/auth_screen/register_view.dart';
import 'package:do_an_mobile/views/widget/auth_btn_widget.dart';
import 'package:do_an_mobile/views/widget/email_input_widget.dart';
import 'package:do_an_mobile/views/widget/password_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../data_sources/repositories/auth_repository.dart';

class loginView extends StatefulWidget {
  const loginView({super.key});

  @override
  State<loginView> createState() => _loginViewState();
}

class _loginViewState extends State<loginView> {
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late bool isObscure = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.addListener(() {
      _checkFullInfo();
    });
    passwordController.addListener(() {
      _checkFullInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: const Text(StringConstant.log_in_title),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
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
              EmailInputWidget(
                  hintText: StringConstant.email_hintText_title,
                  editingController: emailController,
                  icon: const Icon(Icons.person_2_outlined)
              ),
              PasswordInputWidget(
                type: StringConstant.password_hintText_title,
                isObscure: isObscure,
                editingController: passwordController,
                btn1: buttonIsObscure(const Icon(Icons.remove_red_eye)),
                btn2: buttonIsObscure(const Icon(Icons.remove_red_eye_outlined)),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    _forgotAct();
                  }, child: const Text(StringConstant.forgot_password_button_title),
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 5),
                  child: ButtonAuthWidget(
                      onTap: _loginAct,
                      text: StringConstant.sign_in_button_title,
                      checkFullInfo: _checkFullInfo())),
              Container(
                margin: const EdgeInsets.only(right: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Do not have an account?'),
                    TextButton(
                      onPressed: () {
                        _registerAct();
                      },
                      child: const Text(StringConstant.register_button_title),
                    )
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget buttonIsObscure(Icon icon) {
    return IconButton(
        onPressed: () {
          setState(() {
            if (isObscure == true) {
              isObscure = false;
            } else {
              isObscure = true;
            }
          });
        }, icon: icon
    );
  }

  bool _checkFullInfo() {
    setState(() {});
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }
  
  void _loginAct() async {
    String email = emailController.text;
    String password = passwordController.text;
    setState(() {

    });
    Future.delayed(const Duration(seconds: 0)).then((_) {
      AuthRepositoryImpl.shared.login(email, password).then((value) async {
        AuthModel user = AuthModel.fromJson(jsonDecode(value));
        if (user.code == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(StringConstant.key_token, user.token!);
          print(prefs.getString('token'));
        } else {
          AppShowToast.showToast(StringConstant.login_incorrect);
        }
      });
    });
  }
  
  void _forgotAct() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ForgotPasswordView())
    );
  }

  void _registerAct() {
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterView())
    );
  }
}
