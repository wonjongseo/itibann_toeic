import 'package:flutter/material.dart';

class GrammarHomeScreen extends StatefulWidget {
  const GrammarHomeScreen({super.key});

  @override
  State<GrammarHomeScreen> createState() => _GrammarHomeScreenState();
}

class _GrammarHomeScreenState extends State<GrammarHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}

List<String> chapterOfGarmmars = [
  "動詞と5形式",
  "名刺",
  "代名詞",
  "other形容詞",
  "福祉",
  "受動態",
  "自制",
  "動詞",
  "to不定詞",
  "動名刺",
  "分詞",
  "前置詞",
  "名詞節 接続詞",
  "関係代名詞",
];
