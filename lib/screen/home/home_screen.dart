import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/screen/home/components/welcome_widget.dart';
import 'package:jonggack_toeic_japanese/screen/home/services/home_controller.dart';
import 'package:jonggack_toeic_japanese/screen/my_voca/my_voca_sceen.dart';
import 'package:jonggack_toeic_japanese/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic_japanese/screen/home/components/users_word_button.dart';

import '../../common/admob/banner_ad/global_banner_admob.dart';
import '../../common/widget/part_of_information.dart';
import '../my_voca/controller/my_voca_controller.dart';

const String HOME_PATH = '/home2';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController());
    return Scaffold(
      key: homeController.scaffoldKey,
      body: _body(context, homeController),
      bottomNavigationBar: const GlobalBannerAdmob(),
    );
  }

  SafeArea _body(BuildContext context, HomeController homeController) {
    if (!homeController.isSeenTutorial) {
      homeController.settingFunctions();
    }
    const edgeInsets = EdgeInsets.symmetric(horizontal: 20 * 0.7);
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: WelcomeWidget(
              scaffoldKey: homeController.scaffoldKey,
            ),
          ),
          Expanded(
            flex: 15,
            child: GetBuilder<UserController>(
              builder: (userController) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        PartOfInformation(
                          goToSutdy: () => homeController.goToJlptStudy('0'),
                          text: '素人向けの単語',
                          currentProgressCount:
                              userController.user.currentJlptWordScroes[0],
                          totalProgressCount:
                              userController.user.jlptWordScroes[0],
                          edgeInsets: edgeInsets,
                        ),
                        PartOfInformation(
                          goToSutdy: () => homeController.goToJlptStudy('500'),
                          text: '500点向けの単語',
                          currentProgressCount:
                              userController.user.currentJlptWordScroes[1],
                          totalProgressCount:
                              userController.user.jlptWordScroes[2],
                          edgeInsets: edgeInsets,
                        ),
                        PartOfInformation(
                          goToSutdy: () => homeController.goToJlptStudy('700'),
                          text: '700点向けの単語',
                          currentProgressCount:
                              userController.user.currentJlptWordScroes[2],
                          totalProgressCount:
                              userController.user.jlptWordScroes[2],
                          edgeInsets: edgeInsets,
                        ),
                        PartOfInformation(
                          goToSutdy: () => homeController.goToJlptStudy('900'),
                          text: '900点向けの単語',
                          currentProgressCount:
                              userController.user.currentJlptWordScroes[3],
                          totalProgressCount:
                              userController.user.jlptWordScroes[3],
                          edgeInsets: edgeInsets,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: UserWordButton(
                      text: '自分の単語帳',
                      onTap: () {
                        Get.toNamed(
                          MY_VOCA_PATH,
                          arguments: {MY_VOCA_TYPE: MyVocaEnum.MY_WORD},
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: UserWordButton(
                      text: 'よく間違う単語帳',
                      onTap: () {
                        Get.toNamed(
                          MY_VOCA_PATH,
                          arguments: {
                            MY_VOCA_TYPE: MyVocaEnum.WRONG_WORD,
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(flex: 1),
          // Expanded(
          //   flex: 1,
          //   child: TextButton(
          //     child: const Row(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         Text(
          //           '일본어 공부하러 가기',
          //           style: TextStyle(
          //             color: AppColors.primaryColor,
          //           ),
          //         ),
          //         SizedBox(width: 10),
          //         Icon(
          //           Icons.arrow_forward,
          //           color: AppColors.primaryColor,
          //         )
          //       ],
          //     ),
          //     onPressed: () {
          //       if (GetPlatform.isIOS) {
          //         launchUrl(
          //             Uri.parse('https://apps.apple.com/app/id6449939963'));
          //       } else if (GetPlatform.isAndroid) {
          //         launchUrl(Uri.parse(
          //             'https://play.google.com/store/apps/details?id=com.wonjongseo.jlpt_jonggack'));
          //       } else {
          //         launchUrl(Uri.parse(
          //             'https://play.google.com/store/apps/details?id=com.wonjongseo.jlpt_jonggack'));
          //       }
          //     },
          //   ),
          // )
        ],
      ),
    );
  }
}

List<String> alpahbets = [
  'a',
  'b',
  'c',
  'd', // 4
  'e',
  'f',
  'g',
  'h', // 4 E~H
  'i',
  'j',
  'k',
  'l', // 4 I~L
  'm',
  'n',
  'o',
  'p', // 4 M~P
  'q',
  'r',
  's',
  't', // 4 T~Z
  'u',
  'v',
  'w',
  'x',
  'y',
  'z'
];
