import 'package:do_an_mobile/core/app_assets.dart';
import 'package:do_an_mobile/core/app_colors.dart';
import 'package:do_an_mobile/data_sources/constants.dart';
import 'package:do_an_mobile/views/screen/main_screen/main_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckOutComplete extends StatefulWidget {
  const CheckOutComplete({super.key});

  @override
  State<CheckOutComplete> createState() => _CheckOutCompleteState();
}

class _CheckOutCompleteState extends State<CheckOutComplete> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        automaticallyImplyLeading: false,
      ),
      body: Column (
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 80),
          Center(child: Image.asset(AppAsset.checkout_success_image, width: 100, height: 100)),
          const SizedBox(height: 20),
          const Text(StringConstant.order_success,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              color: Colors.black54
            ),
          ),
          const SizedBox(height: 40,),
          InkWell(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: AppColor.ColorMain,
                child: const Text('Go Home',
                  style: TextStyle (
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500
                  ),
                )),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MainView()));
            },
          )
        ],
      )
    );
  }
}
