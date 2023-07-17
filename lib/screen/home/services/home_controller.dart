import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/common.dart';
import 'package:jonggack_toeic_japanese/config/colors.dart';
import 'package:jonggack_toeic_japanese/screen/setting/services/setting_controller.dart';

import '../../../common/admob/controller/ad_controller.dart';
import '../../user/controller/user_controller.dart';
import '../../../common/repository/local_repository.dart';
import '../../jlpt/common/book_step_screen.dart';

class HomeController extends GetxController {
  late PageController pageController;

  late AdController? adController;
  UserController userController = Get.find<UserController>();
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SettingController settingController = Get.find<SettingController>();
  late int currentPageIndex;
  late bool isSeenTutorial;

  Future settingFunctions() async {
    await Future.delayed(const Duration(milliseconds: 500));

    bool isJapaneseSoundActive2 = await alertSetting(
        title: '自動的に知らない単語を貯蔵しますか？',
        content: '活性化したら、学習ページで「知らん」ボタンを押すと、自動的に「よく間違う単語帳」に貯蔵されます。');

    if (isJapaneseSoundActive2) {
      if (!settingController.isAutoSave) {
        settingController.flipAutoSave();
      }
    } else {
      if (settingController.isAutoSave) {
        settingController.flipAutoSave();
      }
    }

    bool isJapaneseSoundActive = await alertSetting(
        title: '自動的に発音「英語」の音声を聴く機能を活性化しますか？',
        content: '活性化したら、学習ページで自動的に英語の発音が再生されます。');

    if (isJapaneseSoundActive) {
      if (!settingController.isEnabledEnglishSound) {
        settingController.flipEnabledJapaneseSound();
      }
    } else {
      if (settingController.isEnabledEnglishSound) {
        settingController.flipEnabledJapaneseSound();
      }
    }

    Get.closeAllSnackbars();
    Get.snackbar(
      '初期の設定が完了になりました。',
      '該当の設定は「設定パージ」から再設定することができます。',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
      duration: const Duration(seconds: 4),
      animationDuration: const Duration(seconds: 2),
    );
  }

  @override
  void onInit() {
    super.onInit();
    currentPageIndex = LocalReposotiry.getUserJlptLevel();
    pageController = PageController(initialPage: currentPageIndex);
    isSeenTutorial = LocalReposotiry.isSeenHomeTutorial();
  }

  void openDrawer() {
    if (scaffoldKey.currentState!.isEndDrawerOpen) {
      scaffoldKey.currentState!.closeEndDrawer();
      update();
    } else {
      scaffoldKey.currentState!.openEndDrawer();
      update();
    }
  }

  void pageChange(int page) async {
    currentPageIndex = page;

    pageController.jumpToPage(currentPageIndex);
    update();
    await LocalReposotiry.updateUserJlptLevel(page);
  }

  void goToJlptStudy(String index) {
    Get.to(
      () => BookStepScreen(
        level: index,
      ),
      duration: const Duration(milliseconds: 300),
    );
  }
}

/**
 var a = [
  [],
  [{},{},],
  []
 ];

 */