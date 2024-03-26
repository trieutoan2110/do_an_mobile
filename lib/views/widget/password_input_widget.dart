import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PasswordInputWidget extends StatelessWidget {
  const PasswordInputWidget({
    super.key,
    required this.type,
    required this.isObscure,
    required this.editingController,
    required this.btn1,
    required this.btn2
  });
  final String type;
  final bool isObscure;
  final TextEditingController editingController;
  final Widget btn1;
  final Widget btn2;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: editingController,
      obscureText: isObscure,
      decoration: InputDecoration(
          hintText: type,
          prefixIcon: const Icon(Icons.lock_outline),
          suffixIcon: isObscure?
          btn1 : btn2
      ),
    );
  }
}
