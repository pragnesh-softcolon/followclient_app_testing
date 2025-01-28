import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    required this.validator,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    final brightness = MediaQuery.of(context).platformBrightness;
    return TextFormField(
      decoration: InputDecoration(
        hintText: widget.hintText,
      ),
      cursorColor: brightness == Brightness.light ? Colors.black : Colors.white,
      onChanged: widget.onChanged,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
    );
  }
}
