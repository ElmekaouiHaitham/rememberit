import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../models/word_model.dart';
import '../buttons/next_button.dart';
import '../q_text_field.dart';

class PhraseOrdering extends StatefulWidget {
  final CardModel card;
  final void Function(CardModel, int) onReviseFinished;
  const PhraseOrdering(
      {Key? key, required this.card, required this.onReviseFinished})
      : super(key: key);

  @override
  State<PhraseOrdering> createState() => _PhraseOrderingState();
}

class _PhraseOrderingState extends State<PhraseOrdering>
    with TickerProviderStateMixin {
  bool? isCorrect;

  late String front;
  late String back;
  late AnimationController _iconAnimationController;
  late Animation<double> _iconAnimation;
  late List<String> phraseWords;
  late List<String> unorderedPhraseWords1;
  late List<String> unorderedPhraseWords;
  List<String> orderedAnswer = [];
  @override
  @override
  void initState() {
    super.initState(); // to swap font and back randomly
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconAnimation =
        Tween<double>(begin: 0, end: 1).animate(_iconAnimationController);
    List<String> cardElements = [
      widget.card.back.trimRight(),
      widget.card.front.trimRight(),
    ];
    int i = Random().nextInt(1);
    front = cardElements[i];
    back = cardElements[1 - i];
    phraseWords = back.substring(3, back.length - 1).split(' ');
    unorderedPhraseWords1 = List.from(phraseWords)..shuffle(Random());
    unorderedPhraseWords = List.from(unorderedPhraseWords1);
  }

  @override
  Widget build(BuildContext context) {
    double width = Get.width;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const SizedBox(height: 15),
        FittedBox(
            child: Text(
          "$front?",
          style: kDefaultTextStyle,
        )),
        // Expanded(
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            for (String word in unorderedPhraseWords) _buildWordCard(word),
          ],
        ),
        // ),
        FittedBox(
          child: Row(
            children: [
              QuestionTextField(
                readOnly: true,
                textDirection: back.substring(0, 2) == "ar"
                    ? TextDirection.rtl
                    : TextDirection.ltr,
                width: width * 0.7,
                textController:
                    TextEditingController(text: orderedAnswer.join(' ')),
                textHint: "Order the words",
              ),
              // FittedBox(
              //   child: Container(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Text(
              //       orderedAnswer.join(' '),
              //       style: const TextStyle(fontSize: 24.0),
              //     ),
              //   ),
              // ),
              orderedAnswer.isNotEmpty
                  ? IconButton(
                      onPressed: () => setState(() {
                            orderedAnswer.clear();
                            unorderedPhraseWords =
                                List.from(unorderedPhraseWords1);
                          }),
                      icon: const Icon(Icons.close))
                  : Container()
            ],
          ),
        ),
        isCorrect != null
            ? isCorrect!
                ? const Icon(
                    Icons.check,
                    color: Colors.green,
                    size: kDefaultIconSize,
                  )
                : FittedBox(
                    child: Row(
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
                    ),
                  )
            : Container(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                onPressed: isCorrect == null ? _checkAnswer : null,
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

  Widget _buildWordCard(String word) {
    return GestureDetector(
      onTap: () => setState(() {
        unorderedPhraseWords.remove(word);
        orderedAnswer.add(word);
      }),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              offset: const Offset(2.0, 2.0),
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Text(
          word,
          style: TextStyle(fontSize: 20.0, color: Colors.grey[800]),
        ),
      ),
    );
  }

  void _revised() {
    int easeDegree = isCorrect! ? 5 : 0;
    widget.onReviseFinished(widget.card, easeDegree);
  }

  void _checkAnswer() {
    isCorrect = orderedAnswer.toString() == phraseWords.toString();
    setState(() {});
  }
}
