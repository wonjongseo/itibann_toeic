import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/admob/controller/ad_controller.dart';
import 'package:jonggack_toeic_japanese/common/common.dart';
import 'package:jonggack_toeic_japanese/common/widget/dimentions.dart';
import 'package:jonggack_toeic_japanese/model/jlpt_step.dart';
import 'package:jonggack_toeic_japanese/model/my_word.dart';
import 'package:jonggack_toeic_japanese/screen/setting/services/setting_controller.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/jlpt_test/jlpt_test_screen.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/controller/jlpt_step_controller.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/jlpt_study/jlpt_study_sceen.dart';

import '../../../../config/colors.dart';
import '../../../../model/word.dart';
import '../../../../tts_controller.dart';
import '../../../user/controller/user_controller.dart';

class JlptStudyControllerTemp extends GetxController {
  JlptStepController jlptWordController = Get.find<JlptStepController>();
  AdController adController = Get.find<AdController>();
  SettingController settingController = Get.find<SettingController>();
  UserController userController = Get.find<UserController>();

  TtsController ttsController = Get.find<TtsController>();

  late PageController pageController;

  late JlptStep jlptStep;

  int currentIndex = 0;
  int correctCount = 0;

  List<Word> unKnownWords = [];
  List<Word> words = [];

  String transparentMean = '';
  String transparentYomikata = '';

  bool isShownMean = false;
  bool isShownYomikata = false;

  double getCurrentProgressValue() {
    return (currentIndex.toDouble() / words.length.toDouble()) * 100;
  }

  void saveCurrentWord() {
    userController.clickUnKnownButtonCount++;
    Word currentWord = words[currentIndex];
    MyWord.saveToMyVoca(currentWord);
  }

  void showMean() async {
    isShownMean = !isShownMean;
    update();
  }

  Future<void> speakMean() async {
    String mean = words[currentIndex].mean;

    await ttsController.speak(mean, language: 'ko-KR');
  }

  Future<void> speakWord() async {
    await ttsController.speak(words[currentIndex].word);
  }

  @override
  void onClose() {
    pageController.dispose();
    ttsController.stop();
    super.onClose();
  }

  void onPageChanged(int page) {
    currentIndex = page;
  }

  Widget mean() {
    // 또,

    double fontSize = Dimentions.height20;

    String mean = words[currentIndex].mean;

    return ZoomIn(
      animate: isShownMean,
      duration: const Duration(milliseconds: 300),
      child: Text(
        mean,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          color: isShownMean ? Colors.white : Colors.transparent,
        ),
      ),
    );
  }

  bool isAginText = false;

  @override
  void onInit() {
    super.onInit();

    // ttsController = Get.put(TtsController());
    pageController = PageController();
    jlptStep = jlptWordController.getJlptStep();

    if (jlptStep.unKnownWord.isNotEmpty) {
      isAginText = true;
      words = jlptStep.unKnownWord;
    } else {
      words = jlptStep.words;
    }

    // ?? TODO
    if (settingController.isEnabledEnglishSound) {
      ttsController.speak(words[correctCount].word);
    }
  }

  Future<void> nextWord(bool isWordKnwon) async {
    isShownMean = false;
    isShownYomikata = false;

    Word currentWord = words[currentIndex];

    // [知る] 버튼 클릭 시
    if (isWordKnwon) {
      correctCount++;
    }
    // [知らん] 버튼 클릭 시
    else {
      Get.closeCurrentSnackbar();
      unKnownWords.add(currentWord);

      if (settingController.isAutoSave) {
        saveCurrentWord();
      }
    }

    currentIndex++;

    // 単語 학습 중. (남아 있는 単語 존재)
    if (currentIndex < words.length) {
      if (settingController.isEnabledEnglishSound) {
        ttsController.speak(words[currentIndex].word);
      }
      pageController.nextPage(
          duration: const Duration(milliseconds: 300), curve: Curves.linear);
    }
    // 単語 학습 완료. (남아 있는 単語 없음)
    else {
      // 전부 다 [知る] 버튼을 눌렀는 지
      if (unKnownWords.isEmpty) {
        jlptStep.unKnownWord = []; // 남아 있을 모르는 単語 삭제.
        bool result = await askToWatchMovieAndGetHeart(
          title: const Text('点数を記録しましょう！'),
          content: const Text(
            'テストページに渡りますか？',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );
        if (result) {
          bool result2 = await askToWatchMovieAndGetHeart(
              title: const Text('テスト類型を選んでください。'),
              contentStrings: ['主観式', '客観式']);
          await goToTest(isSubjective: result2);
          return;
        } else {
          Get.back();
          return;
        }
      }

      // [知らん] 버튼을 누른 적이 있는지
      else {
        int unKnownWordLength = unKnownWords.length > words.length
            ? words.length
            : unKnownWords.length;

        bool result = await askToWatchMovieAndGetHeart(
          title: Text('$unKnownWordLength個が残っています。'),
          content: const Text(
            // '모르는 単語를 다시 보시겠습니까?',
            '知らん単語をテストし直しますか？',
            style: TextStyle(color: AppColors.scaffoldBackground),
          ),
        );

        // 知らん 単語 다시 학습.
        if (result) {
          unKnownWords.shuffle();

          currentIndex = 0; // 화면 에러 방지
          jlptStep.unKnownWord = unKnownWords;
          Get.offNamed(
            JLPT_STUDY_PATH,
            preventDuplicates: false,
          );
        } else {
          Get.closeAllSnackbars();
          jlptStep.unKnownWord = [];
          Get.back();
          return;
        }
      }
    }
    update();

    return;
  }

  Future<void> goToTest({bool isSubjective = false}) async {
    // 테스트를 본 적이 있으면.
    if (jlptStep.wrongQestion != null && jlptStep.scores != 0) {
      bool result = await askToWatchMovieAndGetHeart(
        title: const Text('前にテストから誤った問題があります。'),
        content: const Text(
          '間違った問題をテストし直しますか？',
          style: TextStyle(
            color: AppColors.scaffoldBackground,
          ),
        ),
      );
      if (result) {
        // 과거에 틀린 문제로만 테스트 보기.
        Get.toNamed(
          JLPT_TEST_PATH,
          arguments: {
            CONTINUTE_JLPT_TEST: jlptStep.wrongQestion,
            'isSubjective': isSubjective,
          },
        );
      }
    }

    // 모든 문제로 테스트 보기.
    Get.toNamed(
      JLPT_TEST_PATH,
      arguments: {
        JLPT_TEST: jlptStep.words,
        'isSubjective': isSubjective,
      },
    );
  }
}
