// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spaced_repetition/main.dart';

class CardModel {
  String? cardId;
  String front;
  String back;
  int interval;
  int repetitions;
  double previous_ease;
  // the date of revisionDate
  DateTime revisionDate;
  String userEmail;
  // constructor
  CardModel({
    this.cardId,
    required this.front,
    required this.back,
    required this.interval,
    required this.repetitions,
    required this.previous_ease,
    required this.revisionDate,
    required this.userEmail,
  });
  // fromJson ,toJson
  factory CardModel.fromJson(Map<String, dynamic> json) => CardModel(
        userEmail: json["userEmail"],
        cardId: json["cardId"],
        front: json["front"],
        back: json["back"],
        interval: json["interval"],
        repetitions: json["repetitions"],
        previous_ease: json["previous_ease"].toDouble(),
        revisionDate: DateTime.parse(json["revisionDate"].toDate().toString()),
      );
  Map<String, dynamic> toJson() => {
        "userEmail": userEmail,
        "cardId": cardId,
        "front": front,
        "back": back,
        "interval": interval,
        "repetitions": repetitions,
        "previous_ease": previous_ease,
        "revisionDate": Timestamp.fromDate(revisionDate),
      };

  void revise(int difficulty) {
    final sm = Sm();
    SmResponse smResponse = sm.calc(
        quality: difficulty,
        repetitions: repetitions,
        previousInterval: interval,
        previousEaseFactor: previous_ease);
    interval = smResponse.interval;
    repetitions = smResponse.repetitions;
    previous_ease = smResponse.easeFactor;
    revisionDate =
        DateTime.now().add(Duration(days: smResponse.interval.toInt()));
  }
}
