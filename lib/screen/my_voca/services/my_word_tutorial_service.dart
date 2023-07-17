import 'package:flutter/material.dart';
import 'package:jonggack_toeic_japanese/common/widget/dimentions.dart';
import 'package:jonggack_toeic_japanese/common/widget/tutorial_text.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class MyVocaTutorialService {
  GlobalKey? inputIconKey = GlobalKey(debugLabel: 'inputIconKey');
  GlobalKey? calendarTextKey = GlobalKey(debugLabel: 'calendarTextKey');
  GlobalKey? myVocaTouchKey = GlobalKey(debugLabel: 'myVocaTouchKey');
  GlobalKey? flipKey = GlobalKey(debugLabel: 'flipKey');
  GlobalKey? excelMyVocaKey = GlobalKey(debugLabel: 'flipKey');

  List<TargetFocus> targets = [];

  initTutorial() {
    targets.addAll(
      [
        TargetFocus(
          identify: "calendarTextKey",
          keyTarget: calendarTextKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'カレンダー開き・TODO',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '自分の単語',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'をクリックして '),
                        TextSpan(
                            text: 'カレンダー',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'を表紙・未表紙で選べます。'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "inputIconKey",
          keyTarget: inputIconKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '自分の単語を貯蔵',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '単語と意味',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'を入力して自分の単語を貯蔵ができます。')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "myVocaTouchKey",
          keyTarget: myVocaTouchKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '自分の単語',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  const Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      text: '1. ',
                      children: [
                        TextSpan(
                            text: '右側にスライド',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'して'),
                        TextSpan(
                            text: '暗記',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'または'),
                        TextSpan(
                            text: '未暗記',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'で設定ができます。')
                      ],
                    ),
                  ),
                  SizedBox(height: Dimentions.height10),
                  const Text.rich(
                    TextSpan(
                      text: '2. ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: '左側スライド',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'して'),
                        TextSpan(
                            text: '削除',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'ができます。')
                      ],
                    ),
                  ),
                  SizedBox(height: Dimentions.height10),
                  const Text.rich(
                    TextSpan(
                      text: '3. ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'クリック',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'して自分の単語の情報を確認することができます。')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "flipKey",
          keyTarget: flipKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const TutorialText(
                title: '플립 기능',
                subTitles: [
                  '暗記の単語だけ見る',
                  '未暗記単語だけ見る',
                  '全ての単語를を見る見る',
                  '単語と意味を逆にして見る',
                ],
              ),
            ),
          ],
        ),
        TargetFocus(
          identify: "excelMyVocaKey",
          keyTarget: excelMyVocaKey,
          contents: [
            TargetContent(
              align: ContentAlign.bottom,
              child: const Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Excelファイルデータを自分の単語帳へ貯蔵',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 22.0),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: 'Excelファイル',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'の単語を'),
                        TextSpan(
                            text: '貯蔵',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            )),
                        TextSpan(text: 'して学習することができます。')
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showTutorial(BuildContext context, Function() onFlish) {
    TutorialCoachMark(
      onFinish: () {
        inputIconKey = null;
        calendarTextKey = null;
        myVocaTouchKey = null;
        flipKey = null;
        excelMyVocaKey = null;
        onFlish();
      },
      onSkip: () {
        inputIconKey = null;
        calendarTextKey = null;
        myVocaTouchKey = null;
        flipKey = null;
        excelMyVocaKey = null;
        onFlish();
      },
      alignSkip: Alignment.topLeft,
      textStyleSkip: const TextStyle(
          color: Colors.redAccent, fontSize: 20, fontWeight: FontWeight.bold),
      targets: targets,
    ).show(context: context);
  }
}
