import 'dart:convert';

import 'package:do_an_mobile/core/app_assets.dart';
import 'package:do_an_mobile/core/app_showtoast.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/models/auth_model.dart';
import 'package:do_an_mobile/views/screen/auth_screen/login_view.dart';
import 'package:do_an_mobile/views/widget/auth_btn_widget.dart';
import 'package:do_an_mobile/views/widget/email_input_widget.dart';
import 'package:do_an_mobile/views/widget/password_input_widget.dart';
import 'package:flutter/material.dart';

import '../../../data_sources/repositories/auth_repository.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late TextEditingController fullNameController = TextEditingController();
  late TextEditingController emailController = TextEditingController();
  late TextEditingController passwordController = TextEditingController();
  late TextEditingController retypePasswordController = TextEditingController();
  late bool isObscure = true;
  late bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      _checkInfo();
    });
    fullNameController.addListener(() {
      _checkInfo();
    });
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
        title: const Text(StringConstant.register_title),
        centerTitle: true,
      ),
      body: Container(
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
            EmailInputWidget(
                hintText: StringConstant.fullname_hintText_title,
                editingController: fullNameController,
                icon: const Icon(Icons.person)
            ),
            EmailInputWidget(
                hintText: StringConstant.email_hintText_title,
                editingController: emailController,
                icon: const Icon(Icons.person_2_outlined)
            ),
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
                margin: const EdgeInsets.only(top: 20),
                child: ButtonAuthWidget(
                    onTap: _registerAct,
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
    if (emailController.text.isEmpty || passwordController.text.isEmpty || fullNameController.text.isEmpty || retypePasswordController.text.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void _registerAct() {
    String password = passwordController.text;
    String rpassword = retypePasswordController.text;
    String email = emailController.text;
    String fullname = fullNameController.text;
    if (password == rpassword) {
      setState(() {
        _isLoading = true;
      });
      Future.delayed(const Duration(seconds: 0)).then((_) {
        AuthRepositoryImpl.shared.register(fullname, email, password)
            .then((value) {
           AuthModel auth = AuthModel.fromJson(jsonDecode(value));
           if (auth.code == 200) {
             Navigator.push(context,
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
    } else {
      AppShowToast.showToast(StringConstant.register_incorrect);
    }
  }
}
