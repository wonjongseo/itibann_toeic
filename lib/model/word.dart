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

    for (int i = 0; i < selectedJlptLevelJson.length; i++) {
      List<Word> temp = [];
      print('i: ${i}');
      print(
          'selectedJlptLevelJson[i].length: ${selectedJlptLevelJson[i].length}');
      for (int j = 0; j < selectedJlptLevelJson[i].length; j++) {
        Word word = Word.fromMap(selectedJlptLevelJson[i][j]);

        temp.add(word);
      }

      words.add(temp);
    }
    return words;
  }
}
