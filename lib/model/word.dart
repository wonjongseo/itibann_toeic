import 'package:hive/hive.dart';
import 'package:jonggack_toeic_japanese/data/jlpt_word_n2345_data.dart';
import 'package:jonggack_toeic_japanese/model/hive_type.dart';

part 'word.g.dart';

@HiveType(typeId: WordTypeId)
class Word extends HiveObject {
  static final String boxKey = 'word';

  @HiveField(2)
  late String word;

  @HiveField(4)
  late String mean;

  Word({
    // this.id,
    required this.word,
    required this.mean,
  });

  @override
  String toString() {
    return "Word( word: $word, mean: $mean)";
  }

  Word.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    mean = map['mean'] ?? '';
  }

  static List<List<Word>> jsonToObject(String nLevel) {
    List<List<Word>> words = [];

    List<List<Map<String, dynamic>>> selectedJlptLevelJson = [];
    if (nLevel == '0') {
      selectedJlptLevelJson = toeicWordFor0;
    } else if (nLevel == '500') {
      selectedJlptLevelJson = toeicWordFor500;
    } else if (nLevel == '700') {
      selectedJlptLevelJson = toeicWordFor700;
    } else if (nLevel == '900') {
      selectedJlptLevelJson = toeicWordFor900;
    }
    // 숙어
    else if (nLevel == '5000') {
      selectedJlptLevelJson = toeicWordFor500Idiom;
    } else if (nLevel == '7000') {
      selectedJlptLevelJson = toeicWordFor700Idiom;
    } else if (nLevel == '9000') {
      selectedJlptLevelJson = toeicWordFor900Idiom;
      // aaa
    } else if (nLevel == '1~300') {
      selectedJlptLevelJson = toeicWordFor1To300;
    } else if (nLevel == '301~600') {
      selectedJlptLevelJson = toeicWordFor301To600;
    } else if (nLevel == '601~900') {
      selectedJlptLevelJson = toeicWordFor601To900;
    } else if (nLevel == '901~1200') {
      selectedJlptLevelJson = toeicWordFor901To1200;
    } else if (nLevel == '1201~1500') {
      selectedJlptLevelJson = toeicWordFor1201To1500;
    } else if (nLevel == '1501~1800') {
      selectedJlptLevelJson = toeicWordFor1501To1800;
    } else if (nLevel == '1801~2100') {
      selectedJlptLevelJson = toeicWordFor1801To2100;
    } else if (nLevel == '2101~2400') {
      selectedJlptLevelJson = toeicWordFor2101To2400;
    } else if (nLevel == '2401~2700') {
      selectedJlptLevelJson = toeicWordFor2401To2700;
    } else if (nLevel == '2701~3000') {
      selectedJlptLevelJson = toeicWordFor2701To3000;
    }

    for (int i = 0; i < selectedJlptLevelJson.length; i++) {
      List<Word> temp = [];

      for (int j = 0; j < selectedJlptLevelJson[i].length; j++) {
        Word word = Word.fromMap(selectedJlptLevelJson[i][j]);

        temp.add(word);
      }

      words.add(temp);
    }
    return words;
  }
}
