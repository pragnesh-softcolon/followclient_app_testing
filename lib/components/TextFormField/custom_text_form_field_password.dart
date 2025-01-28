import 'package:flutter/material.dart';

class CustomTextFormFieldPassword extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool obscureText;
  final void Function()? suffixIconTap;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const CustomTextFormFieldPassword({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.validator,
    required this.obscureText,
    required this.suffixIconTap,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<CustomTextFormFieldPassword> createState() =>
      _CustomTextFormFieldPasswordState();
}

class _CustomTextFormFieldPasswordState
    extends State<CustomTextFormFieldPassword> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
        suffixIcon: InkWell(
          onTap: widget.suffixIconTap,
          child: Icon(
            widget.obscureText ? Icons.visibility_off : Icons.visibility,
          ),
        ),
      ),
      cursorColor: brightness == Brightness.light ? Colors.black : Colors.white,
      obscureText: widget.obscureText,
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }
}
