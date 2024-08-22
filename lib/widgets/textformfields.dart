import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final bool? readonly;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final IconData? prefixIconData;
  final IconButton? suffixIconData;
  const TextFormFields({
    super.key,
    required this.controller,
    this.hintText,
    this.readonly = false,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.validator, this.prefixIconData, this.suffixIconData,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        readOnly: readonly!,
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.black,
          fontFamily: 'Poppins',
          fontSize: 15,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.shade700,
          ),
          prefixIcon: Icon(prefixIconData,color: const Color(0XFFB81736),),
          suffixIcon: suffixIconData,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black), // Custom border color
            borderRadius: BorderRadius.circular(10), // Custom border radius
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.orange),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
