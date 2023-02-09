// in this question the user will see the definition and should write the world
// because there can be more than word with the same def the user will be given
// the first and the last letter of the word

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:remenberit/widgets/questions/writing.dart';

import '../../constants/constants.dart';
import '../../models/word_model.dart';
import '../buttons/next_button.dart';
import '../q_text_field.dart';

class Listening extends StatefulWidget {
  final CardModel card;
  final void Function(CardModel, int) onReviseFinished;
  const Listening(
      {Key? key, required this.card, required this.onReviseFinished})
      : super(key: key);

  @override
  State<Listening> createState() => _ListeningState();
}

class _ListeningState extends State<Listening> with TickerProviderStateMixin {
  TextEditingController defController = TextEditingController();
  TextEditingController spellController = TextEditingController();
  bool? isCorrectSpell;
  bool? isCorrectDef;
  double width = Get.width;
  late AnimationController _iconAnimationController;
  late Animation<double> _iconAnimation;

  @override
  void initState() {
    super.initState();
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _iconAnimation =
        Tween<double>(begin: 0, end: 1).animate(_iconAnimationController);
  }

  @override
  void dispose() {
    _iconAnimationController.dispose();
    super.dispose();
  }

  Future<bool> isLanguageAvailable() async {
    print('hello');
    List languages = await FlutterTts().getLanguages;

    print(languages);
    bool isAvailable = languages
        .any((element) => element.contains(widget.card.front.substring(0, 2)));

    print(isAvailable);

    return isAvailable;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: isLanguageAvailable(),
        builder: (context, data) {
          if (data.hasData) {
            bool isLanguageSupported = data.data as bool;
            if (isLanguageSupported) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.volume_up,
                      size: kDefaultIconSize,
                    ),
                    onPressed: () async {
                      FlutterTts()
                          .setLanguage(widget.card.front.substring(0, 2));
                      FlutterTts().speak(widget.card.front.substring(3));
                    },
                  ),
                  // text field for writing what he hear
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: QuestionTextField(
                      textController: spellController,
                      textDirection: widget.card.front.substring(0, 2) == "ar"
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      textHint: "Enter what you hear",
                    ),
                  ),
                  AnimatedBuilder(
                      animation: _iconAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _iconAnimation.value,
                          child: isCorrectSpell != null
                              ? isCorrectSpell!
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: kDefaultIconSize,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        );
                      }),
                  FittedBox(
                    child: Text(
                      "${widget.card.back.substring(0, 4)}${'*' * (widget.card.back.length - 5)}${widget.card.back[widget.card.back.length - 1]}",
                      style: kDefaultTextStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: QuestionTextField(
                      textController: defController,
                      textDirection: widget.card.back.substring(0, 2) == "ar"
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      textHint: "Enter the translation of what you heard",
                    ),
                  ),
                  AnimatedBuilder(
                      animation: _iconAnimation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _iconAnimation.value,
                          child: isCorrectDef != null
                              ? isCorrectDef!
                                  ? const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                      size: kDefaultIconSize,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                        );
                      }),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: isCorrectDef == null ? _checkAnswer : null,
                          child: const Text("check")),
                      NextButton(
                        disable: isCorrectDef == null,
                        onPressed: _revised,
                      )
                    ],
                  )
                ],
              );
            } else {
              return Writing(
                card: widget.card,
                onReviseFinished: widget.onReviseFinished,
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void _revised() {
    int easeDegree = (isCorrectDef! ? 2 : 0) + (isCorrectSpell! ? 3 : 0);
    widget.onReviseFinished(widget.card, easeDegree);
  }

  void _checkAnswer() {
    setState(() {
      isCorrectDef = defController.text.toLowerCase() ==
          widget.card.back.substring(3).toLowerCase();
      isCorrectSpell = spellController.text.toLowerCase() ==
          widget.card.front.substring(3).toLowerCase();
    });
    _iconAnimationController.reset();
    _iconAnimationController.forward();
  }
}
