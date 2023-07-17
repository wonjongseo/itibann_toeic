import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/app_constant.dart';
import 'package:jonggack_toeic_japanese/common/widget/dimentions.dart';
import 'package:jonggack_toeic_japanese/tts_controller.dart';

import '../jlpt_study_controller_temp.dart';

class JlptStudyButtonsTemp extends StatelessWidget {
  const JlptStudyButtonsTemp({
    Key? key,
    required this.wordController,
  }) : super(key: key);

  final JlptStudyControllerTemp wordController;
  @override
  Widget build(BuildContext context) {
    double buttonWidth = threeWordButtonWidth;
    double buttonHeight = 55;
    return GetBuilder<TtsController>(builder: (ttsController) {
      return Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: ttsController.disalbe
                      ? null
                      : () async {
                          await wordController.nextWord(false);
                        },
                  child: Text(
                    '知らん',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimentions.width15,
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimentions.width10),
              ZoomOut(
                animate: wordController.isShownMean,
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  width: buttonWidth,
                  height: buttonHeight,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!wordController.isShownMean) {
                        wordController.showMean();
                      }
                    },
                    child: Text(
                      '意味',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: Dimentions.width15,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: Dimentions.width10),
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: ttsController.disalbe
                      ? null
                      : () async {
                          await wordController.nextWord(true);
                        },
                  child: Text(
                    '知る',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: Dimentions.width15,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      );
    });
  }
}
