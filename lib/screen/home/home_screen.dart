import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/config/colors.dart';
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
      bottomNavigationBar: _bottomNavigationBar(),
    );
  }

  Column _bottomNavigationBar() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GetBuilder<HomeController>(builder: (homeController) {
          return BottomNavigationBar(
            currentIndex: homeController.currentPageIndex,
            onTap: homeController.pageChange,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: homeController.currentPageIndex == 0
                          ? AppColors.primaryColor
                          : AppColors.whiteGrey,
                    ),
                    child: const Text(
                      '500点',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.currentPageIndex == 1
                            ? AppColors.primaryColor
                            : AppColors.whiteGrey),
                    child: const Text(
                      '700点',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.currentPageIndex == 2
                            ? AppColors.primaryColor
                            : AppColors.whiteGrey),
                    child: const Text(
                      '900点',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.currentPageIndex == 3
                            ? AppColors.primaryColor
                            : AppColors.whiteGrey),
                    child: const Text(
                      '初心者',
                      style: TextStyle(
                        color: AppColors.scaffoldBackground,
                      ),
                    ),
                  ),
                  label: ''),
            ],
          );
        }),
        const GlobalBannerAdmob()
      ],
    );
  }

  SafeArea _body(BuildContext context, HomeController homeController) {
    Size size = MediaQuery.of(context).size;
    if (!homeController.isSeenTutorial) {
      homeController.settingFunctions();
    }
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 4,
                    controller: homeController.pageController,
                    itemBuilder: (context, index) {
                      const edgeInsets =
                          EdgeInsets.symmetric(horizontal: 20 * 0.7);
                      if (index == 3) {
                        return GetBuilder<UserController>(
                          builder: (userController) {
                            return Container(
                              padding: EdgeInsets.only(
                                right: 20,
                                left: 20,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GetBuilder<HomeController>(
                                      builder: (homeController2) {
                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: size.height < 700 ? 0 : 10),
                                      child: Stack(
                                        alignment: AlignmentDirectional.center,
                                        children: [
                                          if (homeController2
                                                  .yokuderuTangoPageIndex !=
                                              0)
                                            ZoomIn(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: IconButton(
                                                  onPressed: () {
                                                    homeController2
                                                        .yokuderuTangoPreviousPage();
                                                  },
                                                  icon: const Icon(
                                                    Icons.arrow_back_ios,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          FadeInDown(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                'よく出る単語3000個',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: size.height < 700
                                                      ? 14
                                                      : 20,
                                                  // fontSize: 14,
                                                ),
                                              ),
                                            ),
                                          ),
                                          if (homeController2
                                                  .yokuderuTangoPageIndex !=
                                              3)
                                            ZoomIn(
                                              child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: IconButton(
                                                  onPressed: () {
                                                    homeController2
                                                        .yokuderuTangoNextPage();
                                                  },
                                                  icon: const Icon(
                                                    Icons.arrow_forward_ios,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  }),
                                  Expanded(
                                    child: PageView.builder(
                                      itemCount: 4,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      controller: homeController
                                          .yokuderuTangoPageController,
                                      itemBuilder: (context, pageVeiwindex) {
                                        if (pageVeiwindex == 3) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                              1,
                                              (index2) => PartOfInformation(
                                                goToSutdy: () => homeController
                                                    .goToJlptStudy(aaaaaaaaa[
                                                        index2 +
                                                            pageVeiwindex * 3]),
                                                text:
                                                    '${aaaaaaaaa[index2 + pageVeiwindex * 3]}単語',
                                                currentProgressCount:
                                                    userController.user
                                                            .currentJlptWordScroes[
                                                        index2 +
                                                            6 +
                                                            pageVeiwindex * 3],
                                                totalProgressCount:
                                                    userController.user
                                                            .jlptWordScroes[
                                                        index2 +
                                                            6 +
                                                            pageVeiwindex * 3],
                                                edgeInsets: edgeInsets,
                                              ),
                                            ),
                                          );
                                        }
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: List.generate(
                                            3,
                                            (index2) => PartOfInformation(
                                              goToSutdy: () =>
                                                  homeController.goToJlptStudy(
                                                      aaaaaaaaa[index2 +
                                                          pageVeiwindex * 3]),
                                              text:
                                                  '${aaaaaaaaa[index2 + pageVeiwindex * 3]}単語',
                                              currentProgressCount:
                                                  userController.user
                                                          .currentJlptWordScroes[
                                                      index2 +
                                                          6 +
                                                          pageVeiwindex * 3],
                                              totalProgressCount: userController
                                                      .user.jlptWordScroes[
                                                  index2 +
                                                      6 +
                                                      pageVeiwindex * 3],
                                              edgeInsets: edgeInsets,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                      String forScoreOFToeic = '500';
                      String forScoreOFToeicId = '5000';

                      switch (index) {
                        case 0:
                          forScoreOFToeic = '500';
                          forScoreOFToeicId = '5000';
                          break;

                        case 1:
                          forScoreOFToeic = '700';
                          forScoreOFToeicId = '7000';
                          break;

                        case 2:
                          forScoreOFToeic = '900';
                          forScoreOFToeicId = '9000';
                          break;
                      }
                      return GetBuilder<UserController>(
                        builder: (userController) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                PartOfInformation(
                                  goToSutdy: () => homeController
                                      .goToJlptStudy(forScoreOFToeic),
                                  text: '$forScoreOFToeic点向けの単語',
                                  currentProgressCount: userController
                                      .user.currentJlptWordScroes[index],
                                  totalProgressCount:
                                      userController.user.jlptWordScroes[index],
                                  edgeInsets: edgeInsets,
                                ),
                                PartOfInformation(
                                  goToSutdy: () => homeController
                                      .goToJlptStudy(forScoreOFToeicId),
                                  text: '$forScoreOFToeic点向けの熟語',
                                  currentProgressCount: userController
                                      .user.currentJlptWordScroes[index + 3],
                                  totalProgressCount: userController
                                      .user.jlptWordScroes[index + 3],
                                  edgeInsets: edgeInsets,
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
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
        ],
      ),
    );
  }
}

List<String> aaaaaaaaa = [
  '1~300',
  '301~600',
  '601~900',
  '901~1200',
  '1201~1500',
  '1501~1800',
  '1801~2100',
  '2101~2400',
  '2401~2700',
  '2701~3000',
];

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
