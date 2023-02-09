import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.disable, this.onPressed});

  final bool disable;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disable ? null : onPressed,
      style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      child: const Text(
        "next",
        style: TextStyle(
            fontFamily: "Poppins", fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
