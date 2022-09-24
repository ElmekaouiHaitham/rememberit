import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  final TextEditingController controller;
  final Color color;
  final double height;
  final bool readOnly;
  final TextAlign textAlignment;

  const InputForm({
    Key? key,
    required this.controller,
    required this.color,
    required this.height,
    required this.readOnly,
    this.textAlignment = TextAlign.start,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Card(
        elevation: 30,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        surfaceTintColor: color,
        margin: const EdgeInsets.all(15),
        color: color,
        child: TextField(
          textAlign: textAlignment,
          cursorColor: Colors.white,
          controller: controller,
          readOnly: readOnly,
          keyboardType: TextInputType.multiline,
          maxLines: null,
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(25),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
