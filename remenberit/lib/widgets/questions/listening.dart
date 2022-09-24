// in this question the user will see the definition and should write the world
// because there can be more than word with the same def the user will be given
// the first and the last letter of the word

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../../constants/constants.dart';
import '../../models/word_model.dart';

class Listening extends StatefulWidget {
  final CardModel card;
  final void Function(CardModel, int) onReviseFinished;
  const Listening(
      {Key? key, required this.card, required this.onReviseFinished})
      : super(key: key);

  @override
  State<Listening> createState() => _ListeningState();
}

class _ListeningState extends State<Listening> {
  TextEditingController defController = TextEditingController();
  TextEditingController spellController = TextEditingController();
  bool? isCorrectSpell;
  bool? isCorrectDef;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          icon: const Icon(
            Icons.volume_up,
            size: kDefaultIconSize,
          ),
          onPressed: () async {
            FlutterTts().setLanguage(widget.card.front.substring(0, 2));
            FlutterTts().speak(widget.card.front.substring(3));
          },
        ),
        // text field for writing what he hear
        TextField(
          controller: spellController,
          textDirection: widget.card.front.substring(0, 2) == "ar"
              ? TextDirection.rtl
              : TextDirection.ltr,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        isCorrectSpell != null
            ? isCorrectSpell!
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
                        widget.card.front.substring(3),
                        style: kDefaultTextStyle,
                      )
                    ],
                  )
            : Container(),
        FittedBox(
          child: Text(
            "${widget.card.back.substring(0, 4)}${'*' * (widget.card.back.length - 5)}${widget.card.back[widget.card.back.length - 1]}",
            style: kDefaultTextStyle,
          ),
        ),
        TextField(
          controller: defController,
          textDirection: widget.card.back.substring(0, 2) == "ar"
              ? TextDirection.rtl
              : TextDirection.ltr,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
          ),
        ),
        isCorrectDef != null
            ? isCorrectDef!
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
                onPressed: isCorrectDef != null ? _revised : null,
                child: const Text("next")),
          ],
        )
      ],
    );
  }

  void _revised() {
    int easeDegree = (isCorrectDef! ? 2 : 0) + (isCorrectSpell! ? 3 : 0);
    widget.onReviseFinished(widget.card, easeDegree);
  }

  void _checkAnswer() {
    isCorrectDef = defController.text.toLowerCase() ==
        widget.card.back.substring(3).toLowerCase();
    isCorrectSpell = spellController.text.toLowerCase() ==
        widget.card.front.substring(3).toLowerCase();
    setState(() {});
  }
}
