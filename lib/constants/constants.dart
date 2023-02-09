import 'package:flutter/material.dart';

import '../models/word_model.dart';
import '../widgets/questions/card.dart';
import '../widgets/questions/listening.dart';
import '../widgets/questions/phrase_ordering.dart';
import '../widgets/questions/speaking.dart';
import '../widgets/questions/word_ordering.dart';
import '../widgets/questions/writing.dart';

const kDefaultDuration = Duration(seconds: 2);

const kDefaultIconSize = 40.0;

List<Widget Function(CardModel, void Function(CardModel, int), List<CardModel>)>
    kQuestionsMaker = [
  // (card, onReviseFinished, _) => Writing(
  //       card: card,
  //       onReviseFinished: onReviseFinished,
  //     ),
  // (card, onReviseFinished, _) => MyCard(
  //       card: card,
  //       onReviseFinished: onReviseFinished,
  //     ),
  // (card, onReviseFinished, _) => Listening(
  //       card: card,
  //       onReviseFinished: onReviseFinished,
  //     ),
  // (card, onReviseFinished, _) => Speaking(
  //       card: card,
  //       onReviseFinished: onReviseFinished,
  //     ),
  (card, onReviseFinished, _) => PhraseOrdering(
        card: card,
        onReviseFinished: onReviseFinished,
      ),
  (card, onReviseFinished, _) => WordOrdering(
        card: card,
        onReviseFinished: onReviseFinished,
      ),
];

const kDefaultTextStyle = TextStyle(fontSize: 25);
