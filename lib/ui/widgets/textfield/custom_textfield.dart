import 'package:flutter/material.dart';

class QCustomeTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? id;
  final String label;
  final String? value;
  final String? hint;
  final String? helper;
  final String? Function(String?)? validator;
  final bool obscure;
  final bool enabled;
  final int? maxLength;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final Function(String) onChanged;
  final Function(String)? onSubmitted;

  const QCustomeTextField({
    Key? key,
    required this.controller,
    required this.label,
    this.id,
    this.value,
    this.validator,
    this.hint,
    this.helper,
    this.maxLength,
    required this.onChanged,
    this.onSubmitted,
    this.obscure = false,
    this.enabled = true,
    this.prefixIcon,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 12.0,
      ),
      child: TextFormField(
        enabled: enabled,
        controller: controller,
        validator: validator,
        maxLength: maxLength,
        obscureText: obscure,
        decoration: InputDecoration(
          labelText: label,
          prefix: prefixIcon != null ? Icon(prefixIcon) : null,
          suffix: suffixIcon != null ? Icon(suffixIcon) : null,
          helperText: helper,
          hintText: hint,
        ),
        onChanged: (value) {
          onChanged(value);
        },
        onFieldSubmitted: (value) {
          if (onSubmitted != null) onSubmitted!(value);
        },
      ),
    );
  }
}
