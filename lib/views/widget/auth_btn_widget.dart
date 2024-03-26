import 'package:do_an_mobile/core/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonAuthWidget extends StatelessWidget {
  const ButtonAuthWidget({
    super.key,
    required this.onTap,
    required this.text,
    required this.checkFullInfo
  });

  final VoidCallback onTap;
  final String text;
  final bool checkFullInfo;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: checkFullInfo ? onTap : null,
      style: ElevatedButton.styleFrom(
          backgroundColor: checkFullInfo ? AppColor.ColorMain : Colors.grey,
          foregroundColor: Colors.white,
          fixedSize: const Size(500, 45)),
      child: Text(
        text,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18
        ),
      ),
    );
  }
}
