// in this question the user will see the definition and should write the world
// because there can be more than word with the same def the user will be given
// the first and the last letter of the word

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../models/word_model.dart';
import '../buttons/next_button.dart';
import '../q_text_field.dart';

class Writing extends StatefulWidget {
  final CardModel card;
  final void Function(CardModel, int) onReviseFinished;
  const Writing({Key? key, required this.card, required this.onReviseFinished})
      : super(key: key);

  @override
  State<Writing> createState() => _WritingState();
}

class _WritingState extends State<Writing> {
  TextEditingController textController = TextEditingController();
  bool? isCorrect;

  late String front;
  late String back;

  @override
  void initState() {
    super.initState(); // to swap font and back randomly
    List<String> cardElements = [
      widget.card.back.trimRight(),
      widget.card.front.trimRight(),
    ];
    int i = Random().nextInt(1);
    front = cardElements[i];
    back = cardElements[1 - i];
  }

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FittedBox(
            child: Text(
          "$front?",
          style: kDefaultTextStyle,
        )),
        FittedBox(
          child: Text(
            "${back.substring(0, 4)}${'*' * (back.length - 5)}${back[back.length - 1]}",
            style: kDefaultTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: QuestionTextField(
            textDirection: back.substring(0, 2) == "ar"
                ? TextDirection.rtl
                : TextDirection.ltr,
            width: width * 0.6,
            textController: textController,
            textHint: "Enter translation",
          ),
        ),
        isCorrect != null
            ? isCorrect!
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: kDefaultIconSize,
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.close,
                        color: Colors.red,
                        size: kDefaultIconSize,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        back.substring(3),
                        style: kDefaultTextStyle,
                      )
                    ],
                  )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                // onPressed: isCorrect == null ? _checkAnswer : null,
                onPressed: _checkAnswer,
                child: const Text("check")),
            NextButton(
              disable: isCorrect == null,
              onPressed: _revised,
            )
          ],
        )
      ],
    );
  }

  void _revised() {
    int easeDegree = isCorrect! ? 5 : 0;
    widget.onReviseFinished(widget.card, easeDegree);
  }

  void _checkAnswer() {
    isCorrect =
        textController.text.toLowerCase() == back.substring(3).toLowerCase();
    setState(() {});
  }
}
