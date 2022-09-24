import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:remenberit/controllers/auth_controller.dart';
import 'package:remenberit/models/word_model.dart';

class MainRepo extends GetxService {
  var cardsCollection = FirebaseFirestore.instance
      .collection("cards")
      .withConverter(
        fromFirestore: (data, conversion) => CardModel.fromJson(data.data()!),
        toFirestore: (card, _) => card.toJson(),
      );
  Future<void> addCard(CardModel card) async {
    DocumentReference docRef = cardsCollection.doc();
    String id = docRef.id;
    card.cardId = id;
    await docRef.set(card);
  }

  Future<QuerySnapshot<CardModel>> getCards() async {
    return cardsCollection
        .where("userEmail", isEqualTo: Get.find<AuthController>().user!.email)
        .where("revisionDate",
            isLessThanOrEqualTo: Timestamp.fromDate(DateTime.now()))
        .get();
  }

  void updateCard(CardModel card) {
    cardsCollection.doc(card.cardId).update(card.toJson());
  }
}
