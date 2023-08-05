import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../model/my_word.dart';
import '../screen/my_voca/repository/my_word_repository.dart';

Future<int> postExcelData() async {
  FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
    withData: true,
    allowMultiple: false,
  );

  int savedWordNumber = 0;
  int alreadySaveWordNumber = 0;
  if (pickedFile != null) {
    var bytes = pickedFile.files.single.bytes;

    var excel = Excel.decodeBytes(bytes!);

    try {
      for (var table in excel.tables.keys) {
        for (var row in excel.tables[table]!.rows) {
          String word = (row[0] as Data).value.toString();
          String mean = (row[2] as Data).value.toString();

          MyWord newWord = MyWord(
            word: word,
            mean: mean,
            isManuelSave: true,
          );
          newWord.createdAt = DateTime.now();

          if (MyWordRepository.saveMyWord(newWord)) {
            savedWordNumber++;
          } else {
            alreadySaveWordNumber++;
          }
        }
      }
      Get.snackbar(
        '成功',
        '$savedWordNumber個の単語が保存されました。（$alreadySaveWordNumber個の単語が既に保存られています。)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white.withOpacity(0.5),
        duration: const Duration(seconds: 4),
        animationDuration: const Duration(seconds: 4),
      );
    } catch (e) {
      Get.snackbar(
        '成功',
        '$savedWordNumber個の単語が保存されました。（$alreadySaveWordNumber個の単語が既に保存られています。)',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.white.withOpacity(0.5),
        duration: const Duration(seconds: 4),
        animationDuration: const Duration(seconds: 4),
      );
    }
  }
  return savedWordNumber;
}
