import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../auth_screen/login_view.dart';
import '../auth_screen/register_view.dart';

class InfomationView extends StatefulWidget {
  const InfomationView({super.key});

  @override
  State<InfomationView> createState() => _InfomationViewState();
}

class _InfomationViewState extends State<InfomationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        backgroundColor: AppColor.ColorMain,
        leading: Container(
          child: IconButton (
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const loginView())
              );
            },icon: const Icon(
              Icons.account_circle,
              size: 40, color:
              Colors.white
            ),
          ),
        ),
        actions: [
          Container(
            width: 100,
            height: 35,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(0),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const loginView())
                );
              },child: const Text(
                StringConstant.sign_in_button_title,
                style: TextStyle(
                    color: AppColor.ColorMain,
                  fontSize: 14
                )),
            ),
          ),
          Container(
            width: 100,
            height: 35,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              //color: Colors.white,
              border: Border.all(color: Colors.white, width: 1),
              borderRadius: BorderRadius.circular(0),
            ),
            child: TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterView())
                );
              },child: const Text(
                StringConstant.sign_up_button_title,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
