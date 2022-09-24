import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remenberit/controllers/auth_controller.dart';
import 'package:remenberit/constants/colors.dart';
import 'package:remenberit/view/translate_page.dart';
import 'review_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
   
  final _destinations = <AdaptiveScaffoldDestination>[
    const AdaptiveScaffoldDestination(title: 'translate', icon: Icons.translate),
    const AdaptiveScaffoldDestination(title: 'revise', icon: Icons.receipt),
  ];

  final _pages = <Widget>[
    const TranslatePage(),
    const ReviewPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigationScaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        // app bar with a CircleAvatar for profile picture and IconButton for logOut
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app, color: AppColors.iconColor),
            onPressed: () {
              Get.find<AuthController>().signOut();
            },
          ),
        ],
        title: Text(Get.find<AuthController>().user!.email!)
      ),
      body: _pages[_selectedIndex],
      selectedIndex: _selectedIndex,
      destinations: _destinations,
      onDestinationSelected: (int index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }
}
