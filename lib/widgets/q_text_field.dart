import 'package:flutter/material.dart';
import 'package:remenberit/constants/colors.dart';

class QuestionTextField extends StatelessWidget {
  const QuestionTextField({
    super.key,
    this.width,
    required this.textController,
    required this.textHint,
    required this.textDirection, this.readOnly = false,
  });

  final bool readOnly;
  final double? width;
  final TextEditingController textController;
  final String textHint;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: TextField(
        readOnly: readOnly,
        autofocus: true,
        controller: textController,
        textDirection: textDirection,
        decoration: InputDecoration(
          hintText: textHint,
          hintStyle: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 16.0,
            color: Colors.white,
          ),
          filled: true,
          fillColor: AppColors.mainColor,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
