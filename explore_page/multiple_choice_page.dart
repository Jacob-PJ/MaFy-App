import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import 'practice_page_content.dart';
import 'ready_page.dart';
import '../practice/tal.dart';

List answers = [];

class MultipleChoicePage extends StatefulWidget {
  final int numOfQ;
  final int qIndex;
  final List<Choice> choices;
  final List<Widget> content;
  final List correct;
  const MultipleChoicePage(
      {super.key,
      required this.numOfQ,
      required this.qIndex,
      required this.choices,
      required this.content,
      required this.correct});

  @override
  State<MultipleChoicePage> createState() => _MultipleChoicePageState();

  bool isCorrect() {
    int check = 0;

    for (int i = 0; i < answers.length; i++) {
      if (!correct.contains(answers[i])) {
        break;
      } else {
        check++;
      }
    }

    if (check == correct.length) {
      return true;
    } else {
      return false;
    }
  }
}

class _MultipleChoicePageState extends State<MultipleChoicePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.content,
                )
              ]),
            ),
          ),
        ),
        Column(
          children: widget.choices,
        )
      ],
    ));
  }
}

class Choice extends StatefulWidget {
  final int index;
  final String prompt;
  final int qIndex;
  const Choice({
    super.key,
    required this.index,
    required this.prompt,
    required this.qIndex,
  });

  @override
  State<Choice> createState() => _ChoiceState();
}

class _ChoiceState extends State<Choice> {
  Color circleColor = Colors.white;
  Color borderColor = Colors.black;
  Color textColor = Colors.black;
  bool selectState = false;

  @override
  void didUpdateWidget(covariant Choice oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.qIndex != widget.qIndex) {
      // Reset the select state when qIndex changes
      setState(() {
        selectState = false;
        circleColor = Colors.white;
        borderColor = Colors.black;
        textColor = Colors.black;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, left: 25, right: 25),
      child: SizedBox(
        height: 55,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
              side: const BorderSide(color: Colors.black, width: 1.0),
            ),
          ),
          onPressed: () {
            setState(() {
              if (selectState == false) {
                circleColor = const Color.fromRGBO(34, 88, 165, 1);
                borderColor = const Color.fromRGBO(88, 157, 255, 1);
                textColor = Colors.white;
                selectState = true;
                answers.add(widget.prompt);
              } else {
                circleColor = Colors.white;
                borderColor = Colors.black;
                textColor = Colors.black;
                selectState = false;
                answers.remove(widget.prompt);
              }
            });
          },
          child: Row(
            children: [
              Container(
                height: 33,
                width: 33,
                decoration: BoxDecoration(
                    color: circleColor,
                    border: Border.all(color: borderColor, width: 1.5),
                    borderRadius: BorderRadius.circular(100)),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 1),
                    child: Text(
                      String.fromCharCode(widget.index + 65),
                      style: TextStyle(
                          color: textColor,
                          fontFamily: "semibold",
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  widget.prompt,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "regular", fontSize: 18),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
