import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jonggack_toeic_japanese/screen/user/controller/user_controller.dart';
import '../../common/admob/banner_ad/global_banner_admob.dart';
import 'services/setting_controller.dart';
import 'components/setting_button.dart';
import 'components/setting_switch.dart';

const SETTING_PATH = '/setting';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SettingController settingController = Get.find<SettingController>();
    return WillPopScope(
      child: Scaffold(
        appBar: _appBar(settingController),
        body: _body(settingController.userController),
        bottomNavigationBar: const GlobalBannerAdmob(),
      ),
      onWillPop: () async {
        if (settingController.isInitial) {
          Get.dialog(const AlertDialog(
            content: Text(
              'アプリを終了してつけ直してください。',
              style: TextStyle(
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ));
        }
        return true;
      },
    );
  }

  SingleChildScrollView _body(UserController userController) {
    return SingleChildScrollView(
      child: Center(
        child: GetBuilder<SettingController>(
          builder: (settingController) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...[
                  SettingSwitch(
                    isOn: settingController.isAutoSave,
                    onChanged: (value) => settingController.flipAutoSave(),
                    text: '知らん・間違いの単語を自動的に保存',
                  ),
                  SettingSwitch(
                    isOn: settingController.isEnabledEnglishSound,
                    onChanged: (value) =>
                        settingController.flipEnabledJapaneseSound(),
                    text: '自動に発音（英語）音声を聴く',
                  ),
                  const Divider(height: 30),
                  GetBuilder<UserController>(builder: (controller) {
                    return Column(
                      children: [
                        SoundSettingSlider(
                          activeColor: Colors.redAccent,
                          option: '音量',
                          value: userController.volumn,
                          label: '音量： ${userController.volumn}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.VOLUMN, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.VOLUMN, value);
                          },
                        ),
                        SoundSettingSlider(
                          activeColor: Colors.blueAccent,
                          option: 'ピッチ',
                          value: userController.pitch,
                          label: 'ピッチ： ${userController.pitch}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.PITCH, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.PITCH, value);
                          },
                        ),
                        SoundSettingSlider(
                          activeColor: Colors.deepPurpleAccent,
                          option: '速さ',
                          value: userController.rate,
                          label: '速さ：${userController.rate}',
                          onChangeEnd: (value) {
                            userController.updateSoundValues(
                                SOUND_OPTIONS.RATE, value);
                          },
                          onChanged: (value) {
                            userController.onChangedSoundValues(
                                SOUND_OPTIONS.RATE, value);
                          },
                        ),
                      ],
                    );
                  }),
                ],
                ...[
                  const SizedBox(height: 10),
                  SettingButton(
                    onPressed: () => settingController.initJlptWord(),
                    text: '単語を初期化（単語を混ぜる）',
                  ),
                  SettingButton(
                    text: '自分の単語を初期化',
                    onPressed: () => settingController.initMyWords(),
                  ),
                  SettingButton(
                    text: 'アプリの説明を見直す',
                    onPressed: () => settingController.initAppDescription(),
                  ),
                ]
              ],
            );
          },
        ),
      ),
    );
  }

  AppBar _appBar(SettingController settingController) {
    return AppBar(
      title: const Text('設定'),
    );
  }
}

class SoundSettingSlider extends StatelessWidget {
  const SoundSettingSlider({
    super.key,
    required this.value,
    required this.option,
    required this.label,
    required this.activeColor,
    required this.onChangeEnd,
    required this.onChanged,
  });

  final double value;
  final String option;
  final String label;
  final Color activeColor;
  final Function(double) onChangeEnd;
  final Function(double) onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(option),
          Expanded(
            child: Slider(
              value: value,
              onChangeEnd: (v) {
                onChangeEnd(v);
              },
              onChanged: onChanged,
              min: 0.0,
              max: 1.0,
              divisions: 10,
              activeColor: activeColor,
              label: label,
            ),
          )
        ],
      ),
    );
  }
}
