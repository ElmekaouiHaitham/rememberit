// in this question the user will see the definition and should write the world
// because there can be more than word with the same def the user will be given
// the first and the last letter of the word

import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../../models/word_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        FittedBox(
            child: Text(
          "${widget.card.front}?",
          style: kDefaultTextStyle,
        )),
        FittedBox(
          child: Text(
            "${widget.card.back.substring(0, 4)}${'*' * (widget.card.back.length - 5)}${widget.card.back[widget.card.back.length - 1]}",
            style: kDefaultTextStyle,
          ),
        ),
        TextField(
          controller: textController,
          textDirection: widget.card.back.substring(0, 2) == "ar"
              ? TextDirection.rtl
              : TextDirection.ltr,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
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
                        widget.card.back.substring(3),
                        style: kDefaultTextStyle,
                      )
                    ],
                  )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(onPressed: _checkAnswer, child: const Text("check")),
            ElevatedButton(
                onPressed: isCorrect != null ? _revised : null,
                child: const Text("next")),
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
    isCorrect = textController.text.toLowerCase() ==
        widget.card.back.substring(3).toLowerCase();
    setState(() {});
  }
}
