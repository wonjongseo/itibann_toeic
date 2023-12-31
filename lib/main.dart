import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/admob/controller/ad_controller.dart';
import 'package:jonggack_toeic_japanese/routes.dart';
import 'package:jonggack_toeic_japanese/screen/home/home_screen.dart';
import 'package:jonggack_toeic_japanese/common/admob/banner_ad/test_banner_ad_controller.dart';
import 'package:jonggack_toeic_japanese/config/theme.dart';
import 'package:jonggack_toeic_japanese/model/user.dart';
import 'package:jonggack_toeic_japanese/screen/jlpt/jlpt/repository/jlpt_step_repository.dart';
import 'package:jonggack_toeic_japanese/common/repository/local_repository.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jonggack_toeic_japanese/screen/user/controller/user_controller.dart';
import 'package:jonggack_toeic_japanese/screen/user/repository/user_repository.dart';

import 'common/app_constant.dart';
import 'screen/setting/services/setting_controller.dart';

/**
 いちばんTOEICスースコード

 com.wonjongseo.itiban_toeic
 */

// Hive - flutter pub run build_runner build --delete-conflicting-outputs
// Android Command - flutter build appbundle
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  MobileAds.instance.initialize();
  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (context, snapshat) {
        if (snapshat.hasData == true) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppThemings.dartTheme,
            initialRoute: HOME_PATH,
            getPages: AppRoutes.getPages,
            // home: GraphicImage(),
          );
        } else if (snapshat.hasError) {
          return errorMaterialApp(snapshat);
        } else {
          return loadingMaterialApp(context);
        }
      },
    );
  }

  Future<bool> loadData() async {
    List<int> jlptWordScroes = [];
    try {
      await LocalReposotiry.init();

      if (await JlptStepRepositroy.isExistData() == false) {
        jlptWordScroes.add(await JlptStepRepositroy.init('500'));
        jlptWordScroes.add(await JlptStepRepositroy.init('700'));
        jlptWordScroes.add(await JlptStepRepositroy.init('900'));
        // 熟語
        jlptWordScroes.add(await JlptStepRepositroy.init('5000'));
        jlptWordScroes.add(await JlptStepRepositroy.init('7000'));
        jlptWordScroes.add(await JlptStepRepositroy.init('9000'));

        for (int i = 0; i < aaaaaaaaa.length; i++) {
          jlptWordScroes.add(await JlptStepRepositroy.init(aaaaaaaaa[i]));
        }
        //
      } else {
        //　よく出る3000個単語
        List<int> words = [538, 935, 1648];
        jlptWordScroes.addAll(words);

        List<int> idiom = [196, 301, 507];

        jlptWordScroes.addAll(idiom);

        List<int> yokuderuWord = List.generate(10, (index) => 300);

        jlptWordScroes.addAll(yokuderuWord);
      }

      late User user;
      if (await UserRepository.isExistData() == false) {
        List<int> currentJlptWordScroes =
            List.generate(jlptWordScroes.length, (index) => 0);

        user = User(
          heartCount: AppConstant.HERAT_COUNT_MAX,
          jlptWordScroes: jlptWordScroes,
          currentJlptWordScroes: currentJlptWordScroes,
        );

        user = await UserRepository.init(user);
      }
      Get.put(UserController());
      Get.put(AdController());
      Get.put(TestBannerAdController());
      Get.put(SettingController());
    } catch (e) {
      rethrow;
    }
    return true;
  }

  MaterialApp loadingMaterialApp(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'データをロディングしています。',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12),
              TweenAnimationBuilder(
                curve: Curves.fastOutSlowIn,
                tween: Tween<double>(begin: 0, end: 1),
                duration: const Duration(seconds: 25),
                builder: (context, value, child) {
                  return Column(
                    children: [
                      SizedBox(
                        width: 250,
                        child: LinearProgressIndicator(
                          backgroundColor: const Color(0xFF191923),
                          value: value,
                          color: const Color(0xFFFFC107),
                        ),
                      ),
                      const SizedBox(height: 16 / 2),
                      Text('${(value * 100).toInt()}%')
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  MaterialApp errorMaterialApp(AsyncSnapshot<bool> snapshat) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                snapshat.error.toString(),
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      await LocalReposotiry.init();
                      JlptStepRepositroy.deleteAllWord();
                    },
                    child: const Text('초기화'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
