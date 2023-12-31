import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/app_function_description.dart';
import 'package:jonggack_toeic_japanese/common/repository/local_repository.dart';
import 'package:jonggack_toeic_japanese/common/widget/dimentions.dart';
import 'package:jonggack_toeic_japanese/model/user.dart';
import 'package:jonggack_toeic_japanese/screen/user/repository/user_repository.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../common/app_constant.dart';
import '../../../config/colors.dart';

// ignore: constant_identifier_names

enum TotalProgressType { JLPT }

enum SOUND_OPTIONS { VOLUMN, PITCH, RATE }

class UserController extends GetxController {
  UserRepository userRepository = UserRepository();
  late User user;

  late double volumn;
  late double pitch;
  late double rate;

  int clickUnKnownButtonCount = 0;

  UserController() {
    user = userRepository.getUser();
    volumn = LocalReposotiry.getVolumn();
    pitch = LocalReposotiry.getPitch();
    rate = LocalReposotiry.getRate();
  }

  void updateSoundValues(SOUND_OPTIONS command, double newValue) {
    if (newValue >= 1 && newValue <= 0) return;

    switch (command) {
      case SOUND_OPTIONS.VOLUMN:
        LocalReposotiry.updateVolumn(newValue);
        volumn = newValue;
        break;
      case SOUND_OPTIONS.PITCH:
        LocalReposotiry.updatePitch(newValue);
        pitch = newValue;
        break;
      case SOUND_OPTIONS.RATE:
        LocalReposotiry.updateRate(newValue);
        rate = newValue;
        break;
    }
    update();
  }

  void onChangedSoundValues(SOUND_OPTIONS command, double newValue) {
    switch (command) {
      case SOUND_OPTIONS.VOLUMN:
        volumn = newValue;
        break;
      case SOUND_OPTIONS.PITCH:
        pitch = newValue;
        break;
      case SOUND_OPTIONS.RATE:
        rate = newValue;
        break;
    }
    update();
  }

  bool isUserPremieum() {
    return user.isPremieum;
  }

  void plusHeart({int plusHeartCount = AppConstant.HERAT_COUNT_DEFAULT}) {
    if (user.heartCount + plusHeartCount > AppConstant.HERAT_COUNT_MAX) return;
    user.heartCount += plusHeartCount;
    userRepository.updateUser(user);
    update();
  }

  Future<bool> useHeart() async {
    if (isUserPremieum()) {
      return true;
    }

    if (user.heartCount <= 0) {
      return false;
    }
    user.heartCount--;
    update();
    userRepository.updateUser(user);

    return true;
  }

  void initializeProgress(TotalProgressType totalProgressType) {
    switch (totalProgressType) {
      case TotalProgressType.JLPT:
        for (int i = 0; i < user.currentJlptWordScroes.length; i++) {
          user.currentJlptWordScroes[i] = 0;
        }
        break;
    }
    userRepository.updateUser(user);
  }

  void updateCurrentProgress(
      TotalProgressType totalProgressType, String nLevel, int addScore) {
    int index = 0;
    switch (totalProgressType) {
      case TotalProgressType.JLPT:
        switch (nLevel) {
          case '500':
            index = 0;
            break;
          case '700':
            index = 1;
            break;
          case '900':
            index = 2;
            break;
          case '5000':
            index = 3;
            break;
          case '7000':
            index = 4;
            break;
          case '9000':
            index = 5;
            break;

          case '1~300':
            index = 6;
            break;
          case '301~600':
            index = 7;
            break;
          case '601~900':
            index = 8;
            break;
          case '901~1200':
            index = 9;
            break;
          case '1201~1500':
            index = 10;
            break;
          case '1501~1800':
            index = 11;
            break;
          case '1801~2100':
            index = 12;
            break;
          case '2101~2400':
            index = 13;
            break;
          case '2401~2700':
            index = 14;
            break;
          case '2701~3000':
            index = 15;
            break;
        }

        if (user.currentJlptWordScroes[index] + addScore >= 0) {
          if (user.currentJlptWordScroes[index] + addScore >
              user.jlptWordScroes[index]) {
            user.currentJlptWordScroes[index] = user.jlptWordScroes[index];
          } else {
            user.currentJlptWordScroes[index] += addScore;
          }
        }

        break;
    }
    userRepository.updateUser(user);
    update();
  }

  void openPremiumDialog(String functionName, {List<String>? messages}) {
    Get.dialog(AlertDialog(
      title: Text.rich(
        TextSpan(
          style: const TextStyle(
            color: Colors.deepPurpleAccent,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          text: functionName,
          children: const [
            TextSpan(
              text: ' 기능은 ',
              style: TextStyle(
                color: AppColors.scaffoldBackground,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: 'Plus 버전'),
            TextSpan(
              text: '에서 사용할 수 있습니다.',
              style: TextStyle(
                color: AppColors.scaffoldBackground,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(
            premiumBenefitText.length,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                '기능${index + 1}. ${premiumBenefitText[index]}',
                style: const TextStyle(
                  color: AppColors.scaffoldBackground,
                  fontSize: 15,
                ),
              ),
            ),
          ),
          if (messages != null)
            ...List.generate(
              messages.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  '기능${index + premiumBenefitText.length + 1}. ${messages[index]}',
                  style: const TextStyle(
                    color: Colors.redAccent,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: Dimentions.height60,
            child: ElevatedButton(
                onPressed: () {
                  if (GetPlatform.isIOS) {
                    launchUrl(
                        Uri.parse('https://apps.apple.com/app/id6450434849'));
                  } else if (GetPlatform.isAndroid) {
                    launchUrl(Uri.parse(
                        'https://play.google.com/store/apps/details?id=com.wonjongseo.jlpt_jonggack_plus'));
                  } else {
                    launchUrl(
                        Uri.parse('https://apps.apple.com/app/id6450434849'));
                  }
                },
                child: Text(
                  'Plus 버전 다운로드 하러 가기',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimentions.width16),
                )),
          )
        ],
      ),
    ));
  }
}
