import 'package:cuberino/components/bottom_app_bar.dart';
import 'package:cuberino/model/tutorial_card_model.dart';
import 'package:cuberino/model/tutorial_repository.dart';
import 'package:flutter/material.dart';

import '../app_settings.dart';
import '../components/tutorialcard.dart';

class TutorialSection extends StatelessWidget {
  TutorialSection({super.key});
  final _appSettings = AppSettings();
  

  @override
  Widget build(BuildContext context) {
    final List<TutorialCardModel> tutorials = TutorialRepository.loadDataParent(context);
    return Scaffold(
      backgroundColor: _appSettings.background_color,
      bottomNavigationBar: BottomMenu(true, true, false, true),
      body: Container(
        child: GridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            children: tutorials.map((tutorial) {
              return TutorialCard(
                  pathToImage: tutorial.pathToImage,
                  captionText: tutorial.captionText,
                  subsectionText: tutorial.subsectionText,
                  id: tutorial.id,
                  parentId: tutorial.parentId);
            }).toList()),
      ),
    );
  }
}
