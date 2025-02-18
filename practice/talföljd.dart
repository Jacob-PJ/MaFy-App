import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_expressions/math_expressions.dart';

import '../explore_page/practice_page_content.dart';

Parser p = Parser();

aritmetisk_talfoljd() {
  var random = Random();

  List<String> correct = [];

  int differense = random.nextInt(25) + 1;

  int number = random.nextInt(5) + 6;

  int startValue = random.nextInt(25) + 1;

  correct.add("${startValue + differense * (number - 1)}");

  int mod1, mod2, mod3;

  do {
    mod1 = random.nextInt(5) - 2;
  } while (mod1 == 1);
  do {
    mod2 = random.nextInt(5) - 2;
  } while (mod2 == 1 || mod2 == mod1);
  do {
    mod3 = random.nextInt(5) - 2;
  } while (mod3 == 1 || mod3 == mod2 || mod3 == mod1);

  List answers = [
    correct[0],
    (startValue + differense * (number - mod1)).toString(),
    (startValue + differense * (number - mod2)).toString(),
    (startValue + differense * (number - mod3)).toString(),
  ];
  answers.shuffle();

  var question;

  question = r"""$$ q% $$""".replaceFirst("q%",
      "$startValue, ${startValue + differense}, ${startValue + differense * 2}, ${startValue + differense * 3}, ${startValue + differense * 4}...");

  List<Widget> content = [
    Center(
      child: TextUnit(
        text: Text(
          "Vilket värde har det $number:te talet i följden:\n",
          style: const TextStyle(fontFamily: "semibold", fontSize: 20),
        ),
      ),
    ),
    Center(
      child: MathUnit(text: question),
    )
  ];

  return [content, answers, correct];
}

aritmetisk_summa() {
  var random = Random();

  List<String> correct = [];

  int differense = random.nextInt(25) + 1;

  int number = random.nextInt(5) + 6;

  int startValue = random.nextInt(25) + 1;

  correct.add(
      "${number * (startValue + startValue + differense * (number - 1)) / 2}");

  int mod1, mod2, mod3;

  do {
    mod1 = random.nextInt(5) - 2;
  } while (mod1 == 1);
  do {
    mod2 = random.nextInt(5) - 2;
  } while (mod2 == 1 || mod2 == mod1);
  do {
    mod3 = random.nextInt(5) - 2;
  } while (mod3 == 1 || mod3 == mod2 || mod3 == mod1);

  List answers = [
    correct[0],
    "${number * (startValue + startValue + differense * (mod1 - 1)) / 2}",
    "${number * (startValue + startValue + differense * (mod2 - 1)) / 2}",
    "${number * (startValue + startValue + differense * (mod3 - 1)) / 2}",
  ];
  answers.shuffle();

  var question;

  question = r"""$$ q% $$""".replaceFirst("q%",
      "$startValue, ${startValue + differense}, ${startValue + differense * 2}, ${startValue + differense * 3}, ${startValue + differense * 4}...");

  List<Widget> content = [
    Center(
      child: TextUnit(
        text: Text(
          "Vad är summan av talföljden mellan första och $number:te talet:\n",
          style: const TextStyle(fontFamily: "semibold", fontSize: 20),
        ),
      ),
    ),
    Center(
      child: MathUnit(text: question),
    )
  ];

  return [content, answers, correct];
}

geometisk_talfoljd() {
  var random = Random();

  List<String> correct = [];

  int factor = random.nextInt(6) + 2;

  int number = random.nextInt(5) + 3;

  int startValue = random.nextInt(10) + 1;

  correct.add("${startValue * pow(factor, number - 1)}");

  int mod1, mod2, mod3;

  do {
    mod1 = random.nextInt(6) - 2;
  } while (mod1 == 1 || mod1 == 0);
  do {
    mod2 = random.nextInt(20) - 10;
  } while (mod2 == 1 || mod2 == mod1 || mod2 == 0);
  do {
    mod3 = random.nextInt(4) - 2;
  } while (mod3 == 0 || mod3 == factor);

  List answers = [
    correct[0],
    "${startValue * pow(factor, number - mod1)}",
    "${startValue * pow(factor, number - 1) + mod2}",
    "${startValue * pow(factor + mod3, number - 1)}"
  ];
  answers.shuffle();

  var question;

  question = r"""$$ q% $$""".replaceFirst("q%",
      "${startValue}, ${startValue * factor}, ${startValue * pow(factor, 2)}...");

  List<Widget> content = [
    Center(
      child: TextUnit(
        text: Text(
          "Vad är summan av talföljden mellan första och $number:te talet:\n",
          style: const TextStyle(fontFamily: "semibold", fontSize: 20),
        ),
      ),
    ),
    Center(
      child: MathUnit(text: question),
    )
  ];

  return [content, answers, correct];
}

geometisk_summa() {
  var random = Random();

  List<String> correct = [];

  int differense = random.nextInt(25) + 1;

  int number = random.nextInt(5) + 6;

  int startValue = random.nextInt(25) + 1;

  correct.add(
      "${number * (startValue + startValue + differense * (number - 1)) / 2}");

  int mod1, mod2, mod3;

  do {
    mod1 = random.nextInt(5) - 2;
  } while (mod1 == 1);
  do {
    mod2 = random.nextInt(5) - 2;
  } while (mod2 == 1 || mod2 == mod1);
  do {
    mod3 = random.nextInt(5) - 2;
  } while (mod3 == 1 || mod3 == mod2 || mod3 == mod1);

  List answers = [
    correct[0],
  ];
  answers.shuffle();

  var question;

  question = r"""$$ q% $$""".replaceFirst("q%", "");

  List<Widget> content = [
    Center(
      child: TextUnit(
        text: Text(
          "Vad är summan av talföljden mellan första och $number:te talet:\n",
          style: const TextStyle(fontFamily: "semibold", fontSize: 20),
        ),
      ),
    ),
    Center(
      child: MathUnit(text: question),
    )
  ];

  return [content, answers, correct];
}
