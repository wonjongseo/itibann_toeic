import 'package:flutter/material.dart';

import '../../../config/colors.dart';

class UploadExcelInfomation extends StatelessWidget {
  const UploadExcelInfomation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text.rich(
          style: TextStyle(color: AppColors.scaffoldBackground),
          TextSpan(
            text: '1. ',
            children: [
              TextSpan(text: '拡張子', style: TextStyle(color: Colors.red)),
              TextSpan(text: 'を'),
              TextSpan(text: '.xlsx', style: TextStyle(color: Colors.red)),
              TextSpan(text: 'で用意してください。'),
            ],
          ),
        ),
        ExcelInfoText(
          number: '2. ',
          text1: '1行',
          text2: '単語',
        ),
        ExcelInfoText(
          number: '3. ',
          text1: '2行',
          text2: '意味',
        ),
        // ExcelInfoText(
        //   number: '4. ',
        //   text1: '세번째 열',
        //   text2: '뜻',
        // ),
        Text.rich(
          style: TextStyle(color: AppColors.scaffoldBackground),
          TextSpan(
            text: '4. ',
            children: [
              TextSpan(text: '空き行', style: TextStyle(color: Colors.red)),
              TextSpan(text: 'が'),
              TextSpan(text: 'ないで', style: TextStyle(color: Colors.red)),
              TextSpan(text: '入力してください。'),
            ],
          ),
        )
      ],
    );
  }
}

class ExcelInfoText extends StatelessWidget {
  const ExcelInfoText(
      {super.key,
      required this.text1,
      required this.text2,
      required this.number});

  final String number;
  final String text1;
  final String text2;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: number,
        style: const TextStyle(color: AppColors.scaffoldBackground),
        children: [
          TextSpan(text: text1, style: const TextStyle(color: Colors.red)),
          const TextSpan(text: 'に'),
          TextSpan(text: text2, style: const TextStyle(color: Colors.red)),
          const TextSpan(text: 'を入力してください。'),
        ],
      ),
    );
  }
}
