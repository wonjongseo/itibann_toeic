import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/common/widget/dimentions.dart';
import 'package:jonggack_toeic_japanese/config/colors.dart';
import 'package:jonggack_toeic_japanese/config/theme.dart';
import 'package:jonggack_toeic_japanese/screen/setting/setting_screen.dart';

class WelcomeWidget extends StatelessWidget {
  const WelcomeWidget({
    super.key,
    this.settingKey,
    required this.scaffoldKey,
  });

  final GlobalKey? settingKey;
  final GlobalKey? scaffoldKey;

  @override
  Widget build(BuildContext context) {
    int dateTime = DateTime.now().hour;
    String aisatuMessage = 'Morning!';

    if (dateTime >= 0 && dateTime <= 9) {
      aisatuMessage = 'Morning!';
    } else if (dateTime >= 10 && dateTime <= 18) {
      aisatuMessage = 'Afternoon!';
    } else if (dateTime > 18 && dateTime <= 24) {
      aisatuMessage = 'Evening!';
    }

    return Container(
      width: double.infinity,
      height: Dimentions.height153,
      padding: EdgeInsets.only(
        top: Dimentions.height14,
        left: Dimentions.width22,
        right: Dimentions.width22,
      ),
      decoration: BoxDecoration(
          color: AppColors.whiteGrey,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(Dimentions.height30),
            bottomRight: Radius.circular(Dimentions.height30),
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 5,
              offset: Offset(0, 5),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good $aisatuMessage',
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.scaffoldBackground,
                      fontWeight: FontWeight.w800,
                      fontSize: Dimentions.width18,
                      fontFamily: AppFonts.japaneseFont,
                    ),
              ),
              SizedBox(height: Dimentions.height10),
              Row(
                children: [
                  Text(
                    'Welcome to　',
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.scaffoldBackground,
                          fontWeight: FontWeight.w800,
                          fontSize: Dimentions.width18,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                  ),
                  Text(
                    'いちばんTOEIC',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: Dimentions.width20,
                          fontFamily: AppFonts.japaneseFont,
                        ),
                  ),
                ],
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                key: settingKey,
                onPressed: () {
                  Get.toNamed(SETTING_PATH);
                },
                icon: Icon(
                  Icons.settings,
                  size: Dimentions.width24,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
