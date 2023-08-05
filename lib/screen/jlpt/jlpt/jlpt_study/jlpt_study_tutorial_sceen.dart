import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/app_constant.dart';
import 'package:jonggack_toeic_japanese/common/widget/dimentions.dart';
import 'package:jonggack_toeic_japanese/common/widget/tutorial_text.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/jlpt_study/jlpt_study_sceen.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

import '../../../../common/widget/app_bar_progress_bar.dart';
import '../../../../config/colors.dart';

class JlptStudyTutorialSceen extends StatefulWidget {
  const JlptStudyTutorialSceen({super.key});

  @override
  State<JlptStudyTutorialSceen> createState() => _JlptStudyTutorialSceenState();
}

class _JlptStudyTutorialSceenState extends State<JlptStudyTutorialSceen> {
  List<TargetFocus> targets = [];
  GlobalKey? meanKey = GlobalKey();
  GlobalKey? unKnownKey = GlobalKey();
  GlobalKey? knownKey = GlobalKey();
  GlobalKey? kangiKey = GlobalKey();
  GlobalKey? testKey = GlobalKey();
  GlobalKey? saveKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    initTutorial();
  }

  bool isShownYomikata = false;
  bool isShownMean = false;

  void showTutorial() {
    TutorialCoachMark(
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
      targets: targets,
      onClickTarget: (target) {
        if (target.identify == 'kangi') {}
      },
      onSkip: () {
        meanKey = null;
        unKnownKey = null;
        knownKey = null;
        kangiKey = null;
        testKey = null;
        saveKey = null;

        Get.offAndToNamed(JLPT_STUDY_PATH);
      },
      onFinish: () {
        meanKey = null;
        unKnownKey = null;
        knownKey = null;
        kangiKey = null;
        testKey = null;
        saveKey = null;
        Get.offAndToNamed(JLPT_STUDY_PATH);
      },
    ).show(context: context);
  }

  void initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "kangi",
          keyTarget: kangiKey,
          contents: [
            TargetContent(
                align: ContentAlign.top,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '発音を聴く',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(text: '画面をクリックして'),
                          TextSpan(
                              text: '発音',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: 'を聴けます。'),
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),

        // 知らん
        TargetFocus(
          identify: "unKnown",
          keyTarget: unKnownKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '単語をもう一度見る',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 15.0),
                      children: [
                        TextSpan(
                            text: '知らん',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'ボタンを押して、該当の単語を'),
                        TextSpan(
                            text: 'もう一度',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: '確認することができます。')
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

        // 知る
        TargetFocus(
          identify: "known",
          keyTarget: knownKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '次の単語に渡る',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '知る',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: 'ボタンを押して、次の単語に渡れます。')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),

        // 意味
        TargetFocus(
          identify: "mean",
          keyTarget: meanKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '意味を見る',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '意味',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: 'ボタンを押して、意味を確認することができます。')
                        ],
                      ),
                    ),
                  ],
                ))
          ],
        ),

        TargetFocus(
          identify: "test",
          keyTarget: testKey,
          contents: [
            TargetContent(
                align: ContentAlign.bottom,
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '単語をテストする',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 22.0),
                    ),
                    Text.rich(
                      TextSpan(
                        text: "テストのボタンをクリックすると",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 15.0),
                        children: [
                          TextSpan(
                              text: '主観式',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: 'あるいは'),
                          TextSpan(
                              text: '客観式',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              )),
                          TextSpan(text: 'でテストを勧められます。')
                        ],
                      ),
                    ),
                  ],
                )),
          ],
        ),
        TargetFocus(
          identify: "save",
          keyTarget: saveKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const TutorialText(
                  title: '[よく間違う単語帳]', subTitles: ['に単語が保存されます。']),
            )
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double buttonWidth = threeWordButtonWidth;
    double buttonHeight = 55;
    showTutorial();
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
          title: AppBarProgressBar(
            size: size,
            currentValue: 40,
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: OutlinedButton(
                        onPressed: () {},
                        child: Text(
                          '保存',
                          key: saveKey,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteGrey,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: OutlinedButton(
                        onPressed: () async {},
                        child: Text(
                          'テスト',
                          key: testKey,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: AppColors.whiteGrey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Wrap(
                      children: [
                        Text(
                          'English',
                          key: kangiKey,
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall
                              ?.copyWith(
                                fontSize: 50,
                                color: Colors.white,
                              ),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                        child: Text('英語',
                            style: TextStyle(
                                fontSize: 23,
                                fontWeight: FontWeight.w700,
                                color: isShownMean
                                    ? Colors.white
                                    : Colors.transparent))),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            key: unKnownKey,
                            '知らん',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimentions.width15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimentions.width10),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            key: meanKey,
                            '意味',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: Dimentions.width15,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: Dimentions.width10),
                      SizedBox(
                        width: buttonWidth,
                        height: buttonHeight,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            key: knownKey,
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
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
