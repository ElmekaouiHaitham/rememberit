// in this question the user will see the definition and should write the world
// because there can be more than word with the same def the user will be given
// the first and the last letter of the word

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../../constants/constants.dart';
import '../../models/word_model.dart';

class Speaking extends StatefulWidget {
  final CardModel card;
  final void Function(CardModel, int) onReviseFinished;
  const Speaking({Key? key, required this.card, required this.onReviseFinished})
      : super(key: key);

  @override
  State<Speaking> createState() => _SpeakingState();
}

class _SpeakingState extends State<Speaking> {
  bool? isCorrect;
  String text = "please press the key and start recording";
  bool isListening = false;
  late bool available;
  late SpeechToText _speechToText;
  // @override
  // void initState() async {
  //   super.initState();
  //   _speechToText = SpeechToText();
  //   available = await _speechToText.initialize(
  //       onStatus: (status) =>
  //           setState(() => (isListening = _speechToText.isListening)));
  // }

  @override
  void dispose() {
    super.dispose();
    _speechToText.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      FittedBox(
        child: Text(
          "${widget.card.front}\n${widget.card.back.substring(0, 3)}",
          style: kDefaultTextStyle,
        ),
      ),
      IconButton(
        icon: isListening
            ? const Icon(
                Icons.stop,
                size: kDefaultIconSize,
              )
            : const Icon(
                Icons.mic,
                size: kDefaultIconSize,
              ),
        onPressed: () async {
          _speechToText = SpeechToText();
          available = await _speechToText.initialize(onStatus: (status) {
            if (mounted) {
              setState(() => (isListening = _speechToText.isListening));
            }
          });

          if (_speechToText.isListening) {
            _speechToText.stop();
            return;
          }
          if (available) {
            _speechToText.listen(
                onResult: (text) => setState(() {
                      this.text = text.recognizedWords;
                      text.recognizedWords;
                    }));
          }
        },
      ),
      FittedBox(
        child: Text(
          text,
          style: kDefaultTextStyle,
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
    ]);
  }

  void _revised() {
    int easeDegree = isCorrect! ? 5 : 0;
    widget.onReviseFinished(widget.card, easeDegree);
  }

  void _checkAnswer() {
    isCorrect =
        text.toLowerCase() == widget.card.back.substring(3).toLowerCase();
    setState(() {});
  }
}
