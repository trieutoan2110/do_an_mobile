import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget(
      {super.key, required this.hintText, required this.icon, required this.editingController});

  final String hintText;
  final Icon icon;
  final TextEditingController editingController;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: icon,
      ),
    );
  }
}
