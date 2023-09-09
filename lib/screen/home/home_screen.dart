import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/config/colors.dart';
import 'package:jonggack_toeic_japanese/screen/grammar/grammar_home_sceen.dart';
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
              BottomNavigationBarItem(
                  icon: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: homeController.currentPageIndex == 4
                            ? AppColors.primaryColor
                            : AppColors.whiteGrey),
                    child: const Text(
                      '文法',
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
                    itemCount: 5,
                    controller: homeController.pageController,
                    itemBuilder: (context, index) {
                      print('index: ${index}');
                      const edgeInsets =
                          EdgeInsets.symmetric(horizontal: 20 * 0.7);
                      //
                      if (index == 4) {
                        return HomeGrammarBody();
                      }

                      if (index == 3) {
                        return GetBuilder<UserController>(
                          builder: (userController) {
                            return Container(
                              padding: const EdgeInsets.only(
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

class HomeGrammarBody extends StatefulWidget {
  const HomeGrammarBody({super.key});

  @override
  State<HomeGrammarBody> createState() => _HomeGrammarBodyState();
}

class _HomeGrammarBodyState extends State<HomeGrammarBody> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: SingleChildScrollView(
        child: Wrap(
          runSpacing: 10,
          spacing: 20,
          children: List.generate(
            chapterOfGarmmars.length,
            (index) => SizedBox(
              width: size.width * 0.4,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(() => VerbAnd5Form());
                },
                child: Text(chapterOfGarmmars[index]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class VerbAnd5Form extends StatefulWidget {
  const VerbAnd5Form({super.key});

  @override
  State<VerbAnd5Form> createState() => _VerbAnd5FormState();
}

class _VerbAnd5FormState extends State<VerbAnd5Form> {
  String formDropDownButtonValue = '名刺';
  // String verbDropDrownButtonValue = '1形式';
  int verbDropDrownButtonValue = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('품사と5形式')),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('品詞：'),
                      const SizedBox(width: 10),
                      DropdownButton(
                          dropdownColor: AppColors.scaffoldBackground,
                          value: formDropDownButtonValue,
                          items: const [
                            DropdownMenuItem(
                              value: '名刺',
                              child: Text(
                                '名刺',
                              ),
                            ),
                            DropdownMenuItem(
                              value: '動詞',
                              child: Text(
                                '動詞',
                              ),
                            ),
                          ],
                          onChanged: (v) {
                            formDropDownButtonValue = v!;
                            setState(() {});
                          })
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (formDropDownButtonValue == '名刺') ...[
                            Text('명사의 역활 : '),
                            Text('명사의 종류 - 단순명사, 대명사, 동명사, To부정사, 명사절 접속사 '),
                          ] else ...[
                            const Text('동사 '),
                            Row(
                              children: [
                                const Text("形式："),
                                const SizedBox(width: 10),
                                DropdownButton(
                                  dropdownColor: AppColors.scaffoldBackground,
                                  value: verbDropDrownButtonValue,
                                  items: List.generate(
                                    5,
                                    (index) => DropdownMenuItem(
                                      value: index + 1,
                                      child: Text('${index + 1}形式'),
                                    ),
                                  ),
                                  onChanged: (v) {
                                    verbDropDrownButtonValue = v!;
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ]
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (formDropDownButtonValue == '動詞')
                Expanded(
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          verbsByForm[verbDropDrownButtonValue].length,
                          (index) {
                            return VerbRowCard(
                              word: verbsByForm[verbDropDrownButtonValue]
                                  [index],
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class VerbRowCard extends StatefulWidget {
  const VerbRowCard({
    super.key,
    required this.word,
  });

  final Map<String, String> word;

  @override
  State<VerbRowCard> createState() => _VerbRowCardState();
}

class _VerbRowCardState extends State<VerbRowCard> {
  bool isClicked = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('isClicked: ${isClicked}');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${widget.word['word']!}',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
          ),
        ),
        if (isClicked)
          InkWell(
            onTap: () {
              isClicked = true;
              setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: const BoxDecoration(
                  color: Colors.purpleAccent,
                  borderRadius: BorderRadius.all(Radius.circular(6))),
              child: const Text(
                '의미',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          )
        else
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${widget.word['mean']!}',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
            ),
          ),
        // ElevatedButton(
        //     onPressed: () {}, child: Text('意味'))
      ],
    );
  }
}

List<List<Map<String, String>>> verbsByForm = [
  [],
  [
    {
      'word': 'work',
      'mean': '',
    },
    {
      'word': 'rise',
      'mean': '배달되다, 도착하다',
    },
    {
      'word': 'arrive',
      'mean': '배달되다, 도착하다',
    },
    {
      'word': 'live',
      'mean': '살다, 거주하다',
    },
    {
      'word': 'speak',
      'mean': '말하다',
    },
    {
      'word': 'arise',
      'mean': '생기다, 발생하다, 유발하다',
    },
    {
      'word': 'travel',
      'mean': '여행하ㅏㄷ',
    },
    {
      'word': 'happen',
      'mean': '일어나다',
    },
    {
      'word': 'occur',
      'mean': '발생하다',
    },
    {
      'word': 'emerge',
      'mean': '',
    },
    {
      'word': 'take place',
      'mean': '',
    },
    {
      'word': 'commute',
      'mean': '',
    },
    {
      'word': 'function',
      'mean': '',
    },
    {
      'word': 'exist',
      'mean': '',
    },
    {
      'word': 'disappear',
      'mean': '',
    },
    {
      'word': 'convene',
      'mean': '',
    },
    {
      'word': 'expire',
      'mean': '',
    },
    {
      'word': 'vary',
      'mean': '',
    },
    {
      'word': 'proceed',
      'mean': '',
    },
    {
      'word': 'come',
      'mean': '',
    },
    {
      'word': 'go',
      'mean': '',
    },
    {
      'word': 'differ',
      'mean': '',
    },
    {
      'word': 'expire',
      'mean': '',
    },
    {
      'word': 'fall',
      'mean': '',
    },
    {
      'word': 'appear',
      'mean': '',
    },
    {
      'word': 'conclude',
      'mean': '',
    },
  ],
  [
    {'word': 'be', 'mean': '이다, 있다'},
    {'word': 'become', 'mean': '되다'},
    {'word': 'remain', 'mean': '계속 ~ 이다'},
    {'word': 'seem', 'mean': '~처럼 보이다'},
    {'word': 'look', 'mean': '~처럼 보이다'},
    {'word': 'feel', 'mean': '느끼다'},
    {'word': 'stay', 'mean': '~한 생태를 유지하다'},
    {'word': 'appear', 'mean': '나타나다'},
  ],
  [],
  [
    {'word': 'give', 'mean': '주다'},
    {'word': 'offer', 'mean': '제안하다, 권하다'},
    {'word': 'send', 'mean': '보내다, 발송하다'},
    {'word': 'lend', 'mean': '빌려주다'},
    {'word': 'show', 'mean': '보여주다'},
    {'word': 'bring', 'mean': '가져오다, 데려오다, 가져다 주다'},
    {'word': 'award', 'mean': '수여하다'},
    {'word': 'grant', 'mean': '승인하다, 허락하다'},
    {'word': 'win', 'mean': '얻어주다'},
    {'word': 'assign', 'mean': '맡기다, 배정하다, 할당하다'},
    {'word': 'issue', 'mean': '발생하다'},
  ],
  [
    {'word': 'make', 'mean': '하게하다'},
    {'word': 'find', 'mean': '찾다'},
    {'word': 'keep', 'mean': '유지하다'},
    {'word': 'consider', 'mean': '사려하다, 여기다'},
    {'word': 'think', 'mean': '생각하다'},
    {'word': 'deem', 'mean': '여기다'},
    {'word': 'leave', 'mean': '떠나다'},
    {'word': 'request', 'mean': '요청하다'},
    {'word': 'require', 'mean': '필요로 하다'},
    {'word': 'allow', 'mean': '허락하다'},
    {'word': 'urge', 'mean': '충고하다, 권고하다'},
    {'word': 'encourage', 'mean': '격려하다'},
    {'word': 'expect', 'mean': '기대하다'},
    {'word': 'advise', 'mean': '조언하다'},
    {'word': 'permit', 'mean': '허락하다'},
    {'word': 'persuade', 'mean': '설득하다'},
    {'word': 'ask', 'mean': '요청하다'},
    {'word': 'invite', 'mean': '초대하다'},
    {'word': 'enable', 'mean': '할 수 있게 하다'},
  ]
];

var a = [
  {
    'word': 'make',
    'mean': '하게하다',
  },
  {
    'word': 'find',
    'mean': '찾다',
  },
  {
    'word': 'keep',
    'mean': '유지하다',
  },
  {
    'word': 'consider',
    'mean': '사려하다, 여기다',
  },
  {
    'word': 'think',
    'mean': '생각하다',
  },
  {
    'word': 'deem',
    'mean': '여기다',
  },
  {
    'word': 'leave',
    'mean': '떠나다',
  },
];
