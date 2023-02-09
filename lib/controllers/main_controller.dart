import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remenberit/pages/auth/controller/auth_controller.dart';
import 'package:remenberit/models/word_model.dart';
import 'package:spaced_repetition/main.dart';

import '../repositories/main_repo.dart';

class MainController extends GetxController {
  final MainRepo _repo;

  MainController(this._repo);

  Future<void> addCard(String front, String back) async {
    // show dialog that says "adding..."
    Get.dialog(
      barrierDismissible: false,
      const AlertDialog(
        title: Text("Adding..."),
        content: Text("Please wait..."),
      ),
    );
    final sm = Sm();
    SmResponse smResponse = sm.calc(
        quality: 0,
        repetitions: 0,
        previousInterval: 0,
        previousEaseFactor: 2.5);
    var card = CardModel(
        userEmail: Get.find<AuthController>().user!.email!,
        front: front,
        back: back,
        interval: smResponse.interval,
        repetitions: smResponse.repetitions,
        previous_ease: smResponse.easeFactor,
        revisionDate:
            DateTime.now().add(Duration(days: smResponse.interval.toInt())));
    await _repo.addCard(card);
    Get.back();
  }

  Future<List<CardModel>> getCards() async {
    var t = await _repo.getCards();
    return t.docs.map((doc) => doc.data()).toList();
  }

  void updateCard(CardModel card, {required int difficulty}) {
    card.revise(difficulty);
    _repo.updateCard(card);
  }
}
