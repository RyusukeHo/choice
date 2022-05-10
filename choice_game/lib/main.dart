import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const ChoiceGame());
}

class ChoiceGame extends StatelessWidget {
  const ChoiceGame({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '選択だゲーム',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const Game(title: '選択だゲーム'),
    );
  }
}

class Game extends StatefulWidget {
  const Game({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var questions = [
    [
      "朝起きた。",
      "何をする？",
      "二度寝する。",
      "朝ご飯を食べる。",
      "二度寝しよ～っと。わっ！飛行機が僕の部屋に突っ込んできた。",
      "す～ぴ～ぐっすり眠った。",
      "いっただっきまーす。あっち！！お椀を落とした。",
      "おいしい。鮭ご飯だ。"
    ],
    [
      "外に出よう",
      "どこに行く？",
      "公園に行く。",
      "ジャガイモ畑に行く。",
      "わっ！犬にかまれた！",
      "噴水の水が気持ちいい。",
      "ジャガイモが実ってる。よっこらっしょ。あ、モグラが出てきた！！",
      "こんなところにダイヤモンドが！"
    ],
    [
      "おなかがすいた。",
      "どこで昼食をとる？",
      "「もほもほうどん」に行く。",
      "家に帰る。",
      "あれ？今日店やってないの？！",
      "ずるずる～うんおいしい！",
      "あ、食材切らしてるんだった。",
      "今日はカレーにするか！よいしょ。トントントン。"
    ],
    [
      "おなかもいっぱいになった。",
      "午後は何しようかな？",
      "昼寝をする。",
      "運動をする。",
      "また寝るんかい？！",
      "うーん。昼寝の幸せ",
      "あ、アキレス腱が切れた。痛い",
      "外での運動は、気持ちがいいね。"
    ]
  ];
  int score = 0;
  int level = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            Text(
              "SCORE:" + score.toString(),
              style: TextStyle(fontSize: 30),
            )
          ],
        ),
        body: Center(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  questions[level][0],
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30),
                child: Text(
                  questions[level][1],
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Container(
                  width: 300,
                  height: 60,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: ChoiceA, child: Text(questions[level][2]))),
              Container(
                  width: 300,
                  height: 60,
                  padding: EdgeInsets.all(10),
                  child: ElevatedButton(
                      onPressed: ChoiceB, child: Text(questions[level][3])))
            ],
          ),
        ));
  }

  void ChoiceA() {
    if (Random().nextInt(2) == 0) {
      setState(() {
        score += 10;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(questions[level][5]),
        ));
        if (questions.length > level + 1) {
          level++;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(questions[level][4]),
      ));
      reset();
    }
  }

  void ChoiceB() {
    if (Random().nextInt(2) == 0) {
      setState(() {
        score += 10;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(questions[level][7]),
        ));
        if (questions.length > level + 1) {
          level++;
        }
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(questions[level][6]),
      ));
      reset();
    }
  }

  void reset() {
    showDialog(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text("ゲームオーバー"),
          content: Text("SCORE:" + score.toString()),
          actions: <Widget>[
            // ボタン領域

            TextButton(
              child: Text("OK"),
              onPressed: () => Navigator.pop(context, ""),
            ),
          ],
        );
      },
    ).then((value) => resetAll());
  }

  void resetAll() {
    setState(() {
      score = 0;
      level = 0;
    });
  }

  @override
  void initState() {
    super.initState();
  }
}
