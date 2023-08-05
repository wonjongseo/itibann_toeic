// ignore_for_file: constant_identifier_names

class AppConstant {
  // ネイティブ広告周期
  static const int PER_COUNT_NATIVE_ND = 4;

// チャプターにつき単語の数
  static const int MINIMUM_STEP_COUNT = 10;

//　間違った問題でテストやり直した場合、広告なしに進められる場合の数
  static const int PROBABILITY_PASS_AD = 3;

  // 자주 틀리는 문제로 유도하는 [모르는 버튼] 누른 숫자 MIN = 15 AND MAX = 10
  // よく間違う単語帳ページにて誘導するために、「知らん」ボタンを押した回　MIN = 15 AND MAX = 10
  static const int INDUCE_USUALLY_WRONG_VOCA_PAGE_COUNT_MIN = 15;
  static const int INDUCE_USUALLY_WRONG_VOCA_PAGE_COUNT_MAX = 15;

  static const int HERAT_COUNT_MAX = 30;

//　広告につきハート数
  static const int HERAT_COUNT_AD = 3;

//　ハート増加デフォルト
  static const int HERAT_COUNT_DEFAULT = 1;

  static const String msgNoSaveScoreOfText = 'テストの途中に出たら点数が記録できません。';
}

double threeWordButtonWidth = 99.36;
