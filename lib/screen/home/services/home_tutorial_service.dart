// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:jonggack_toeic_japanese/common/common.dart';
// import 'package:jonggack_toeic_japanese/common/widget/dimentions.dart';
// import 'package:jonggack_toeic_japanese/config/colors.dart';
// import 'package:jonggack_toeic_japanese/screen/setting/services/setting_controller.dart';
// import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

// class HomeTutorialService {
//   SettingController settingController = Get.find<SettingController>();
//   GlobalKey wrongWordKey = GlobalKey(debugLabel: 'wrongWordKey');
//   GlobalKey myVocaKey = GlobalKey(debugLabel: 'myVocaKey');
//   // GlobalKey welcomeKey = GlobalKey(debugLabel: 'welcomeKey');
//   GlobalKey bottomNavigationBarKey =
//       GlobalKey(debugLabel: 'bottomNavigationBarKey');
//   GlobalKey settingKey = GlobalKey(debugLabel: 'settingKey');

//   List<TargetFocus> targets = [];

//   Future settingFunctions() async {
//     bool isJapaneseSoundActive = await alertSetting(
//         title: '자동으로 발음 (英語) 음성 듣기 활성화 하시겠습니까?',
//         content: '활성화 시 학습 페이지에서 [발음] 버튼을 누르면 자동적으로 英語 발음이 재생 됩니다.');

//     if (isJapaneseSoundActive) {
//       if (!settingController.isEnabledEnglishSound) {
//         settingController.flipEnabledJapaneseSound();
//       }
//     } else {
//       if (settingController.isEnabledEnglishSound) {
//         settingController.flipEnabledJapaneseSound();
//       }
//     }

//     Get.closeAllSnackbars();
//     Get.snackbar(
//       '초기 설정이 완료 되었습니다.',
//       '해당 설정들은 설정 페이지에서 재설정 할 수 있습니다.',
//       snackPosition: SnackPosition.BOTTOM,
//       backgroundColor: AppColors.whiteGrey.withOpacity(0.5),
//       duration: const Duration(seconds: 4),
//       animationDuration: const Duration(seconds: 2),
//     );
//   }

//   initTutorial() {
//     targets.addAll([
//       TargetFocus(
//         identify: "myVocaKey",
//         keyTarget: myVocaKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   '自分の単語帳',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 const Text.rich(
//                   TextSpan(
//                     text: '1. ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     children: [
//                       TextSpan(
//                           text: '직접',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 일본어 単語를 '),
//                       TextSpan(
//                           text: '저장',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '하여 학습 할 수 있습니다.')
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text.rich(
//                   TextSpan(
//                     text: '2. ',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     children: [
//                       TextSpan(
//                           text: 'Excel 파일',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '을 이용해 自分の単語를 관리 및 학습 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Dimentions.height20),
//               ],
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "wrongWordKey",
//         keyTarget: wrongWordKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   'よく間違う単語帳',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 const Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                     children: [
//                       TextSpan(
//                           text: 'TOEIC 単語',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 혹은 '),
//                       TextSpan(
//                           text: 'JLPT 한자',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '를 학습하면서 '),
//                       TextSpan(
//                           text: '저장 버튼',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: '을 통해 저장한 単語들을 확인 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Dimentions.height60),
//               ],
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "bottomNavigationBarKey",
//         keyTarget: bottomNavigationBarKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.top,
//             child: const Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'JLPT 레벨 선택',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     children: [
//                       TextSpan(
//                           text: 'JLPT N1급 ~ ',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(
//                           text: 'N5급',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 을 선택 할 수 있습니다.')
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//       TargetFocus(
//         identify: "settingKey",
//         keyTarget: settingKey,
//         contents: [
//           TargetContent(
//             align: ContentAlign.bottom,
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   '설정 기능',
//                   style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       fontSize: 22.0),
//                 ),
//                 const Text.rich(
//                   TextSpan(
//                     text: '1. ',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     children: [
//                       TextSpan(text: '単語, 문법, 한자, 自分の単語를 '),
//                       TextSpan(
//                           text: '초기화 (순서 섞기)',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 를 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Dimentions.height10),
//                 const Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     text: '2. ',
//                     children: [
//                       TextSpan(
//                           text: '知らん',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 버튼 클릭 시'),
//                       TextSpan(
//                           text: '[자동 저장] 기능',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 을 [ON / OFF] 할 수 있습니다.'),
//                       TextSpan(
//                           text: '\n[Plus 기능에 한함]',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 14)),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Dimentions.height10),
//                 const Text.rich(
//                   TextSpan(
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     text: '3. ',
//                     children: [
//                       TextSpan(
//                           text: '사운드 설정',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 및 '),
//                       TextSpan(
//                           text: '학습 시 자동 재생',
//                           style: TextStyle(
//                               color: Colors.red,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 17)),
//                       TextSpan(text: ' 을 [ON / OFF] 할 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: Dimentions.height10),
//                 const Text.rich(
//                   TextSpan(
//                     text: '4. ',
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: Colors.white,
//                         fontSize: 15.0),
//                     children: [
//                       TextSpan(text: ' 전반적인 앱 사용법을 볼 수 있습니다.'),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     ]);
//   }

//   void showTutorial(BuildContext context) {
//     TutorialCoachMark(
//       alignSkip: Alignment.topLeft,
//       onFinish: () => settingFunctions(),
//       onSkip: () => settingFunctions(),
//       textStyleSkip: const TextStyle(
//           color: Colors.redAccent, fontSize: 22, fontWeight: FontWeight.bold),
//       targets: targets, // List<TargetFocus>
//     ).show(context: context);
//   }
// }
