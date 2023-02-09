import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:remenberit/models/word_model.dart';

import '../../constants/constants.dart';
import '../../constants/open_glosbe.dart';
import '../../controllers/main_controller.dart';
import '../../constants/colors.dart';
import '../../utils/dimensions.dart';

class ReviewPage extends StatefulWidget {
  const ReviewPage({Key? key}) : super(key: key);

  @override
  State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  // page controller
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final query = Get.find<MainController>().getCards();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: FutureBuilder(future: query, builder: _build));
  }

  Widget _build(BuildContext context, AsyncSnapshot<List<CardModel>> snapshot) {
    double width = Get.width;
    if (snapshot.hasData) {
      var cards = snapshot.data!;
      return Column(children: [
        // progress bar
        Row(
          children: [
            Container(
              width: width * 0.8,
              margin: EdgeInsets.symmetric(
                  vertical: Dimensions.getDVsize(8),
                  horizontal: Dimensions.getDHsize(20)),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / (cards.length + 1),
                backgroundColor: Colors.grey[200],
                valueColor:
                    const AlwaysStoppedAnimation(AppColors.progressBarColor),
              ),
            ),
            const Text(
              '50',
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 16.0,
                color: Colors.white,
              ),
            ),
            const Icon(Icons.star, color: Colors.yellow),
          ],
        ),
        TextButton(
          onPressed: () {
            openGlosbe(
              cards[_currentPage].front.substring(0, 2),
              cards[_currentPage].back.substring(0, 2),
              cards[_currentPage].front.substring(3),
            );
          },
          child: const Text("see more"),
        ),
        // page view
        Expanded(
          child: Container(
            margin: EdgeInsets.only(
                bottom: 50, left: width * 0.09, right: width * 0.09),
            decoration: BoxDecoration(
              color: AppColors.secondColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 10),
                  blurRadius: 20,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: PageView.builder(
                // physics: const NeverScrollableScrollPhysics(),
                itemCount: cards.length + 1,
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  if (index == cards.length) {
                    return const Center(
                      child: Text(
                          'You have nothing to revise, you will get a notification\nonce it is time to revise'),
                    );
                  }
                  // to show the back as front sometimes and vise versa for better memo
                  return _generateQuestion(cards[index]);
                },
              ),
            ),
          ),
        ),
      ]);
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  void _revised(CardModel card, int easeDegree) {
    Get.find<MainController>().updateCard(card, difficulty: easeDegree);
    setState(() {
      _currentPage++;
      _pageController.animateToPage(_currentPage,
          duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    });
  }

  Widget _generateQuestion(card) {
    return kQuestionsMaker[Random().nextInt(kQuestionsMaker.length)](
        card, _revised);
  }
}
