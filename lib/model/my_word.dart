import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:jonggack_toeic_japanese/model/hive_type.dart';
import 'package:jonggack_toeic_japanese/model/word.dart';
import 'package:jonggack_toeic_japanese/screen/my_voca/repository/my_word_repository.dart';

part 'my_word.g.dart';

@HiveType(typeId: MyWordTypeId)
class MyWord {
  static String boxKey = 'my_word';
  @HiveField(0)
  late String word;
  @HiveField(1)
  late String mean;

  @HiveField(2)
  bool isKnown = false;

  @HiveField(4)
  late DateTime? createdAt;

  @HiveField(5)
  bool? isManuelSave = false;

  MyWord({
    required this.word,
    required this.mean,
    this.isManuelSave = false,
  }) {
    createdAt = DateTime.now();
  }

  @override
  String toString() {
    return "MyWord{word: $word, mean: $mean,  isKnown: $isKnown, createdAt: $createdAt, isManuelSave: $isManuelSave}";
  }

  MyWord.fromMap(Map<String, dynamic> map) {
    word = map['word'] ?? '';
    mean = map['mean'] ?? '';
    createdAt = map['createdAt'] ?? '';

    isKnown = false;
  }

  static void saveToMyVoca(Word word) {
    MyWord newMyWord = MyWord(
      word: word.word,
      mean: word.mean,
    );

    newMyWord.createdAt = DateTime.now();

    if (!MyWordRepository.saveMyWord(newMyWord)) {
      if (!Get.isSnackbarOpen) {
        Get.snackbar(
          '${word.word}が既に貯蔵されています。',
          '単語帳から確認することができます。',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white.withOpacity(0.5),
          duration: const Duration(milliseconds: 1000),
          animationDuration: const Duration(milliseconds: 1000),
        );
      }
    }
    if (!Get.isSnackbarOpen) {
      Get.snackbar(
        '${word.word}が既に貯蔵されました。',
        '単語帳から確認することができます。',
        backgroundColor: Colors.white.withOpacity(0.5),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1000),
        animationDuration: const Duration(milliseconds: 1000),
      );
    }
  }

  String createdAtString() {
    return createdAt.toString().substring(0, 16);
  }
}