import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:get/get.dart';
import 'package:remenberit/models/word_model.dart';

import '../constants/constants.dart';
import '../constants/open_glosbe.dart';
import '../controllers/main_controller.dart';
import '../constants/colors.dart';
import '../utils/dimensions.dart';

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
    if (snapshot.hasData) {
      var cards = snapshot.data!;
      return Column(children: [
        // progress bar
        Container(
          margin: EdgeInsets.symmetric(
              vertical: Dimensions.getDVsize(20),
              horizontal: Dimensions.getDHsize(20)),
          child: FAProgressBar(
            currentValue: (_currentPage + 1) / (cards.length + 1) * 100,
            displayText: '%',
            backgroundColor: Colors.grey,
            progressColor: AppColors.progressBarColor,
            size: Dimensions.getDVsize(20),
          ),
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
          child: PageView.builder(
            physics: const NeverScrollableScrollPhysics(),
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
                  child: Text('You have nothing to revise'),
                );
              }
              // to show the back as front sometimes and vise versa for better memo
              return _generateQuestion(cards[index]);
            },
          ),
        ),
        // how difficult it was
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
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  Widget _generateQuestion(card) {
    return kQuestionsMaker[Random().nextInt(kQuestionsMaker.length)](
        card, _revised);
  }
}
