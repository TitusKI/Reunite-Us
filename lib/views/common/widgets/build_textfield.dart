import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  final String? Function(String?)? onChanged;
  final Color textColor;
  final Color iconColor;
  final List<TextInputFormatter>? inputFormatters;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.prefixIcon,
    this.onTap,
    this.validator,
    this.focusNode,
    this.errorMsg,
    this.onChanged,
    this.textColor = Colors.black,
    this.iconColor = const Color.fromARGB(255, 209, 160, 228),
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      validator: validator,
      style: TextStyle(color: textColor),
      focusNode: focusNode,
      onChanged: onChanged,
      decoration: InputDecoration(
        suffixIcon: suffixIcon != null
            ? IconTheme(
                data: IconThemeData(color: iconColor), child: suffixIcon!)
            : null,
        prefixIcon: prefixIcon != null
            ? IconTheme(
                data: IconThemeData(
                    color: Theme.of(context)
                        .colorScheme
                        .primary), // Set icon color here
                child: prefixIcon!,
              )
            : null,
        iconColor: Theme.of(context).colorScheme.primary,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        fillColor: Colors.grey.shade300,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Color.fromARGB(115, 88, 85, 85),
        ),
        errorText: errorMsg,
      ),
    );
  }
}
