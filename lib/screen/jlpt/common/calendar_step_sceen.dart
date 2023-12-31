import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/admob/banner_ad/global_banner_admob.dart';
import 'package:jonggack_toeic_japanese/common/widget/calendar_card.dart';
import 'package:jonggack_toeic_japanese/config/colors.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/controller/jlpt_step_controller.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/jlpt_study/jlpt_study_tutorial_sceen.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/jlpt_study/jlpt_study_sceen.dart';
import 'package:jonggack_toeic_japanese/screen/user/controller/user_controller.dart';

import '../../../common/widget/heart_count.dart';
import '../../../common/repository/local_repository.dart';
import '../../listen_page.dart';

const String JLPT_CALENDAR_STEP_PATH = '/jlpt-calendar-step';

// ignore: must_be_immutable
class CalendarStepSceen extends StatelessWidget {
  late JlptStepController jlptWordController;
  late String chapter;

  late bool isSeenTutorial;
  UserController userController = Get.find<UserController>();

  CalendarStepSceen({super.key}) {
    jlptWordController = Get.find<JlptStepController>();

    chapter = Get.arguments['chapter'];
    jlptWordController.setJlptSteps(chapter);
    isSeenTutorial = LocalReposotiry.isSeenWordStudyTutorialTutorial();
  }

  @override
  Widget build(BuildContext context) {
    String title = '';
    if (jlptWordController.level.contains('~')) {
      title = jlptWordController.level;
    } else {
      title =
          '${int.parse(jlptWordController.level) < 1000 ? jlptWordController.level : (int.parse(jlptWordController.level) / 10).ceil()}${int.parse(jlptWordController.level) < 1000 ? '単語' : '熟語'} - チャプター${int.parse(chapter) + 1}';
    }

    return Scaffold(
      bottomNavigationBar: const GlobalBannerAdmob(),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: OutlinedButton(
                onPressed: () {
                  Get.to(() => WordListenScreen(chapter: chapter));
                },
                child: Text(
                  'チャプター${int.parse(chapter) + 1} 自動に聴く',
                  style: const TextStyle(
                    color: AppColors.whiteGrey,
                  ),
                )),
          ),
          Expanded(
            child: GetBuilder<JlptStepController>(builder: (controller) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: controller.jlptSteps.length,
                itemBuilder: (context, subStep) {
                  if (subStep == 0) {
                    return CalendarCard(
                      isAabled: true,
                      jlptStep: controller.jlptSteps[subStep],
                      onTap: () {
                        controller.setStep(subStep);
                        if (!isSeenTutorial) {
                          isSeenTutorial = true;
                          Get.to(
                            () => const JlptStudyTutorialSceen(),
                            transition: Transition.circularReveal,
                          );
                        } else {
                          Get.toNamed(JLPT_STUDY_PATH);
                        }
                      },
                    );
                  }

                  return CalendarCard(
                    isAabled:
                        (controller.jlptSteps[subStep - 1].isFinished ?? false),
                    jlptStep: controller.jlptSteps[subStep],
                    onTap: () {
                      // 무료버전일 경우.
                      controller.goToStudyPage(subStep, isSeenTutorial);
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
