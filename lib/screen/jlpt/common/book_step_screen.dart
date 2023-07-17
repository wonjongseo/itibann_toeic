import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/widget/book_card.dart';
import 'package:jonggack_toeic_japanese/model/jlpt_step.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/controller/jlpt_step_controller.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/common/calendar_step_sceen.dart';
import 'package:jonggack_toeic_japanese/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic_japanese/tts_controller.dart';

import '../../../common/admob/banner_ad/global_banner_admob.dart';
import '../../../common/admob/native_ad/native_ad_widget.dart';
import '../../../common/app_constant.dart';
import '../jlpt/repository/jlpt_step_repository.dart';

final String BOOK_STEP_PATH = '/book-step';

// ignore: must_be_immutable
class BookStepScreen extends StatelessWidget {
  late JlptStepController jlptWordController;
  JlptStepRepositroy jlptStepRepositroy = JlptStepRepositroy();
  UserController userController = Get.find<UserController>();

  final String level;

  BookStepScreen({super.key, required this.level}) {
    jlptWordController = Get.put(JlptStepController(level: level));
  }

  void goTo(int index, String chapter) {
    Get.toNamed(JLPT_CALENDAR_STEP_PATH,
        arguments: {'chapter': index.toString()});
  }

  @override
  Widget build(BuildContext context) {
    Get.put(TtsController());

    String title = '';
    if (level.contains('~')) {
      title = level;
    } else {
      title =
          '${int.parse(level) < 1000 ? level : (int.parse(level) / 10).ceil()}向けの${int.parse(level) < 1000 ? '単語' : '熟語'}';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        // actions: const [HeartCount()],
      ),
      body: GetBuilder<JlptStepController>(builder: (context) {
        return ListView.separated(
          itemCount: jlptWordController.headTitleCount,
          separatorBuilder: (context, index) {
            if (index % AppConstant.PER_COUNT_NATIVE_ND == 2) {
              return NativeAdWidget();
            }
            return Container();
          },
          itemBuilder: (context, index) {
            bool isAllFinished = true;
            List<JlptStep> jlptSteps = jlptWordController.allJlptSteps[index];

            for (JlptStep jlptStep in jlptSteps) {
              if (jlptStep.isFinished! == false) {
                isAllFinished = false;
                break;
              }
            }

            String chapter = '$index';

            return FadeInLeft(
              delay: Duration(milliseconds: 200 * index),
              child: BookCard(
                  level: index,
                  isAllFinished: isAllFinished,
                  onTap: () => goTo(index, chapter)),
            );
          },
        );
      }),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }
}
