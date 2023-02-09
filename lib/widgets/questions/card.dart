import 'dart:math';

import 'package:flash_card/flash_card.dart';
import 'package:flutter/material.dart';

import '../../models/word_model.dart';
import '../../utils/dimensions.dart';

class MyCard extends StatelessWidget {
  final CardModel card;
  final void Function(CardModel, int) onReviseFinished;
  const MyCard({Key? key, required this.card, required this.onReviseFinished})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool flip = Random().nextBool();
    String front = flip ? card.back : card.front;
    String back = flip ? card.front : card.back;
    return Column(
      children: [
        Center(
          child: FlashCard(
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.6,
              // there is a problem with FlashCard do front is back and back is front
              frontWidget: Center(
                  child: Text(front, style: const TextStyle(fontSize: 30))),
              backWidget: Center(
                  child: Text(back, style: const TextStyle(fontSize: 30)))),
        ),
        SizedBox(
          height: Dimensions.getDVsize(8),
        ),
        const Text("how difficult it was to remember?",
            style: TextStyle(fontSize: 20)),
        SizedBox(
          height: Dimensions.getDVsize(8),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              icon: const Icon(Icons.sentiment_very_dissatisfied),
              onPressed: () {
                onReviseFinished(card, 0);
              },
            ),
            IconButton(
              icon: const Icon(Icons.sentiment_dissatisfied),
              onPressed: () {
                onReviseFinished(card, 1);
              },
            ),
            IconButton(
              icon: const Icon(Icons.sentiment_neutral),
              onPressed: () {
                onReviseFinished(card, 2);
              },
            ),
            IconButton(
              icon: const Icon(Icons.sentiment_satisfied),
              onPressed: () {
                onReviseFinished(card, 3);
              },
            ),
            IconButton(
              icon: const Icon(Icons.sentiment_very_satisfied),
              onPressed: () {
                onReviseFinished(card, 5);
              },
            ),
          ],
        )
      ],
    );
  }
}
