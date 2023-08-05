import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/app_constant.dart';
import 'package:jonggack_toeic_japanese/common/widget/dimentions.dart';

import 'package:jonggack_toeic_japanese/config/colors.dart';

bool isKangi(String word) {
  return word.compareTo('一') >= 0 && word.compareTo('龥') <= 0;
}

bool isKatakana(String word) {
  return word.compareTo('\u30A0') >= 0 && word.compareTo('\u30FF') <= 0;
}

void getBacks(int count) {
  for (int i = 0; i < count; i++) {
    Get.back();
  }
}

Future<bool> alertSetting(
    {required String title, required String content}) async {
  return await Get.dialog(
    barrierDismissible: false,
    AlertDialog(
      title: Text(
        title,
        style: const TextStyle(
          color: AppColors.scaffoldBackground,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(
        content,
        style: const TextStyle(color: AppColors.scaffoldBackground),
      ),
      actions: [
        OutlinedButton(
            onPressed: () => Get.back(result: true), child: const Text('はい')),
        OutlinedButton(
            onPressed: () => Get.back(result: false), child: const Text('いいえ'))
      ],
    ),
  );
}

Future<bool> askToWatchMovieAndGetHeart(
    {Text? title,
    Text? content,
    List<String>? contentStrings = const ['はい', 'いいえ']}) async {
  bool result = await Get.dialog(
    AlertDialog(
      title: title,
      titleTextStyle: TextStyle(
          fontSize: Dimentions.width18, color: AppColors.scaffoldBackground),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (content != null) content,
          SizedBox(height: Dimentions.height10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: threeWordButtonWidth,
                child: ElevatedButton(
                    onPressed: () => Get.back(result: true),
                    child: Text(contentStrings![0])),
              ),
              SizedBox(
                width: threeWordButtonWidth,
                child: ElevatedButton(
                    onPressed: () => Get.back(result: false),
                    child: Text(contentStrings[1])),
              ),
            ],
          )
        ],
      ),
    ),
    barrierDismissible: false,
  );

  return result;
}

Future<bool> reallyQuitText() async {
  bool result = await askToWatchMovieAndGetHeart(
      title: const Text('テストを辞めますか？'),
      content: const Text(
        AppConstant.msgNoSaveScoreOfText,
        style: TextStyle(color: AppColors.scaffoldBackground),
      ));

  return result;
}

void copyWord(String text) {
  Clipboard.setData(ClipboardData(text: text));

  if (!Get.isSnackbarOpen) {
    Get.closeAllSnackbars();
    Get.snackbar(
      'Copied',
      '$textがコピー(Ctrl + C)されました。',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
      duration: const Duration(seconds: 2),
      animationDuration: const Duration(seconds: 2),
    );
  }
}
