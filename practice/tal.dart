import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_expressions/math_expressions.dart';

import '../explore_page/practice_page_content.dart';

Parser p = Parser();

// ignore: non_constant_identifier_names
definiera_taltyper() {
  var random = Random();

  List answers = ["Naturligt tal", "Heltal", "Rationellt tal", "Reelt tal"];
  answers.shuffle();

  String questionType = answers[random.nextInt(answers.length)];

  var question;

  List<String> correct = [];

  if (questionType == "Naturligt tal") {
    question = random.nextInt(1000) + 1;
    question =
        r"""$$ %question $$""".replaceAll('%question', question.toString());
    correct.add("Naturligt tal");
    correct.add("Heltal");
    correct.add("Rationellt tal");
    correct.add("Reelt tal");
  } else if (questionType == "Heltal") {
    question = random.nextInt(2001) - 1000;
    correct.add("Heltal");
    correct.add("Rationellt tal");
    correct.add("Reelt tal");

    if (question > 0) {
      correct.add("Naturligt tal");
    }
    question =
        r"""$$ %question $$""".replaceAll('%question', question.toString());
  } else if (questionType == "Rationellt tal") {
    String rationalType = ["Bråk", "Decimal"][random.nextInt(2)];
    if (rationalType == "Bråk") {
      int numerator = random.nextInt(100) + 1;
      int denomemator = random.nextInt(100) + 1;
      String sign = ["-", ""][random.nextInt(2)];
      if (numerator % denomemator == 0 && numerator >= denomemator) {
        correct.add("Heltal");

        if (sign != "-") {
          correct.add("Naturligt tal");
        }
      }

      question = r"""$$ %sign \frac{ %numerator }{ %denomemator }$$"""
          .replaceAll('%sign', sign)
          .replaceAll('%numerator', numerator.toString())
          .replaceAll('%denomemator', denomemator.toString());
    } else if (rationalType == "Decimal") {
      double num = (random.nextDouble() * 200) - 100;
      question = num;

      if (num % 1 == 0) {
        correct.add("Heltal");
        if (num > 0) {
          correct.add("Naturligt tal");
        }
      }

      question = double.parse(question.toStringAsFixed(1));
      question =
          r"""$$ %question $$""".replaceAll('%question', question.toString());
    }
    correct.add("Rationellt tal");
    correct.add("Reelt tal");
  } else if (questionType == "Reelt tal") {
    String sign = ["-", ""][random.nextInt(2)];
    question = [
      r"""π""",
      r"""e""",
      r"""π""",
      r"""e""",
      r"""π""",
      r"""e""",
      r"""|\sqrt{1}|""",
      r"""|\sqrt{2}|""",
      r"""|\sqrt{3}|""",
      r"""|\sqrt{4}|""",
      r"""|\sqrt{5}|""",
      r"""|\sqrt{10}|""",
      r"""|\sqrt{20}|""",
      r"""|\sqrt{25}|""",
      r"""|\sqrt{100}|""",
      r"""|\sqrt{\frac{4}{2}}|""",
      r"""|\sqrt{\frac{18}{6}}|""",
    ][random.nextInt(15)];

    if (question == r"""|\sqrt{1}|""" ||
        question == r"""|\sqrt{4}|""" ||
        question == r"""|\sqrt{25}|""" ||
        question == r"""|\sqrt{100}|""") {
      correct.add("Rationellt tal");
      correct.add("Heltal");

      if (sign != "-") {
        correct.add("Naturligt tal");
      }
    }

    question = r"""$$ %sign %question $$"""
        .replaceAll('%sign', sign)
        .replaceAll('%question', question);
    correct.add("Reelt tal");
  }

  List<Widget> content = [
    const Center(
      child: TextUnit(
        text: Text(
          "Vilka alternativ beskriver:\n",
          style: TextStyle(fontFamily: "semibold", fontSize: 20),
        ),
      ),
    ),
    Center(
      child: MathUnit(text: question.toString()),
    )
  ];
  return [content, answers, correct];
}

// ignore: non_constant_identifier_names
complexa_tal_uppgifter() {
  var random = Random();
  Expression? solution;

  List answers = [];
  answers.shuffle();

  List<Expression?> correct = [];

  int num1, i1, num2, i2, sum, isum;

  num1 = random.nextInt(31) - 15;
  i1 = random.nextInt(31) - 15;
  num2 = random.nextInt(31) - 15;
  i2 = random.nextInt(31) - 15;

  String question = "", question1, question2;

  String questionType =
      ["addition", "addition", "multiplikation", "division"][random.nextInt(4)];

  if (questionType == "addition") {
    sum = num1 + num2;
    isum = i1 + i2;

    solution = p.parse("$sum + ${isum}*i").simplify();

    if (i1 > 0) {
      question1 = "$num1 + ${i1}i";
    } else {
      question1 = "$num1 ${i1}i";
    }

    if (i2 > 0) {
      question2 = "$num2 + ${i2}i";
    } else {
      question2 = "$num2 ${i2}i";
    }

    question = r"""$$ %question $$"""
        .replaceAll("%question", "($question1) + ($question2)");
  } else if (questionType == "multiplikation") {
    int sum1 = num1 * num2;
    int isum = -i1 * i2;
    int sum = sum1 + isum;
    int sum2 = num1 * i2 + num2 * i1;

    solution = p.parse("$sum*${sum2}*i").simplify();

    if (i1 >= 0) {
      question1 = "$num1 + ${i1}i";
    } else {
      question1 = "$num1 ${i1}i";
    }

    if (i2 >= 0) {
      question2 = "$num2 + ${i2}i";
    } else {
      question2 = "$num2 ${i2}i";
    }

    question = r"""$$ %question $$"""
        .replaceAll("%question", "($question1) * ($question2)");
  } else if (questionType == "division") {
    int numSum1 = num1 * num2;
    int numIsum = i1 * -i2;
    int numSum2 = num1 * -i2 + num2 * i1;

    int numSum = numSum1 + numIsum;

    int denSum1 = num2 * num2;
    int denIsum = i2 * i2;

    int denSum = denSum1 + denIsum;

    solution = p.parse("($numSum + ${numSum2}*i)/$denSum").simplify();

    int smallest = numSum.abs();

    if (numSum2.abs() < smallest) {
      smallest = numSum2.abs();
    }
    if (denSum.abs() < smallest) {
      smallest = denSum.abs();
    }

    int sgf = 1;

    for (int i = 1; i < smallest; i++) {
      if (numSum % i == 0 && numSum2 % i == 0 && denSum % i == 0) {
        if (i > sgf) {
          sgf = i;
          numSum = numSum ~/ sgf;
          numSum2 = numSum2 ~/ sgf;
          denSum = denSum ~/ sgf;
        }
      }
    }

    if (numSum2 >= 0) {
      question1 = "$numSum+$numSum2";
    }

    if (i1 >= 0) {
      question1 = "$num1 + ${i1}i";
    } else {
      question1 = "$num1 ${i1}i";
    }

    if (i2 >= 0) {
      question2 = "$num2 + ${i2}i";
    } else {
      question2 = "$num2 ${i2}i";
    }
    question = r"""$$ %question $$""".replaceAll("%question",
        r"\frac{" + question1.toString() + "}{" + question2.toString() + "}");
  }

  correct.add(solution);
  List<Widget> content = [
    const Center(
      child: TextUnit(
          text: Text(
        "Beräkna:",
        style: TextStyle(fontFamily: "semibold", fontSize: 20),
      )),
    ),
    const Center(
      child: TextUnit(
          text: Text(
        "Kom ihåg att föränkla\n",
        style: TextStyle(fontFamily: "regular", fontSize: 14),
      )),
    ),
    Center(
      child: MathUnit(
        text: question,
      ),
    )
  ];

  return [content, answers, correct];
}
