import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

import '../practice/talföljd.dart';
import 'practice_page_content.dart';
import 'ready_page.dart';
import '../practice/tal.dart';
import 'multiple_choice_page.dart';
import 'input_page.dart';

class QuestionPage extends StatefulWidget {
  final String baseSubject;
  final String subject;
  final String subSubject;
  final String page;
  final bool isRandom;
  final int numOfQ;
  final QuerySnapshot<Map<String, dynamic>>? snapshot;

  const QuestionPage({
    super.key,
    required this.baseSubject,
    required this.subject,
    required this.subSubject,
    required this.page,
    required this.isRandom,
    required this.numOfQ,
    required this.snapshot,
  });

  @override
  State<QuestionPage> createState() => _QuestionPage();
}

class _QuestionPage extends State<QuestionPage> {
  int qIndex = 0;
  List<bool?> isCorrectList = [];
  int quetionsCorrect = 0;

  @override
  void initState() {
    super.initState();
    isCorrectList = List.generate(widget.numOfQ, (index) => null);
  }

  @override
  Widget build(BuildContext context) {
    String questionType = "";
    List<CurrentQuestion> curQList = List.generate(widget.numOfQ, (index) {
      if (qIndex == index) {
        return CurrentQuestion(
          isCorrect: isCorrectList[index],
          hasBorder: true,
        );
      }
      return CurrentQuestion(
        isCorrect: isCorrectList[index],
        hasBorder: false,
      );
    });

    List content = List.generate(widget.numOfQ, (index) {
      List content;

      switch (widget.snapshot!.docs[index].data()["content"]) {
        case "definiera_taltyper":
          content = definiera_taltyper();
          break;
        case "complexa_tal_uppgifter":
          content = complexa_tal_uppgifter();
          break;
        case "aritmetisk_talföljd":
          content = aritmetisk_talfoljd();
          break;
        case "aritmetisk_summa":
          content = aritmetisk_summa();
          break;
        case "geometisk_talföljd":
          content = geometisk_talfoljd();
          break;
        case "geometisk_summa":
          content = geometisk_summa();
          break;
        default:
          return const Text("Couldnt find what you are looking for");
      }

      switch (widget.snapshot!.docs[index].data()["typ"]) {
        case "multipleChoice":
          questionType = "multipleChoice";
          return MultipleChoicePage(
            numOfQ: widget.numOfQ,
            qIndex: qIndex,
            correct: content[2],
            choices: List<Choice>.generate(content[1].length, (index) {
              return Choice(
                  index: index, prompt: content[1][index], qIndex: qIndex);
            }),
            content: content[0],
          );
        case "input":
          questionType = "input";
          return InputPage(
            correct: content[2],
            content: content[0],
          );
        default:
          return const Text("Couldnt find what you are looking for");
      }
    });

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          automaticallyImplyLeading: false,
          backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
          title: Row(
              mainAxisAlignment: MainAxisAlignment.center, children: curQList),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.lightbulb,
                  color: Colors.black,
                )),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        bottomNavigationBar: Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color.fromRGBO(208, 208, 208, 1),
                  width: 0.5,
                ),
              ),
            ),
            height: 60,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (qIndex < widget.numOfQ - 1) {
                          if (content[qIndex].isCorrect()) {
                            quetionsCorrect++;
                            isCorrectList[qIndex] = true;
                          } else {
                            isCorrectList[qIndex] = false;
                          }

                          answers.clear();

                          qIndex++;
                        } else {
                          if (content[qIndex].isCorrect()) {
                            quetionsCorrect++;
                            isCorrectList[qIndex] = true;
                          } else {
                            isCorrectList[qIndex] = false;
                          }

                          answers.clear();

                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return DonePage(
                              baseSubject: widget.baseSubject,
                              subject: widget.subject,
                              subSubject: widget.subSubject,
                              page: widget.page,
                              correct: quetionsCorrect,
                              questions: widget.numOfQ,
                            );
                          }));
                        }
                      });
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(34, 88, 165, 1)),
                    child: const SizedBox(
                      width: 100,
                      child: Padding(
                        padding: EdgeInsets.only(left: 28),
                        child: Text("Svara",
                            style: TextStyle(
                                fontFamily: "semibold", fontSize: 16)),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            setState(() {
                              Navigator.of(context).pop();

                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return DonePage(
                                  baseSubject: widget.baseSubject,
                                  subject: widget.subject,
                                  subSubject: widget.subSubject,
                                  page: widget.page,
                                  correct: quetionsCorrect,
                                  questions: widget.numOfQ,
                                );
                              }));
                            });
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              elevation: 0),
                          child: const Row(
                            children: [
                              Text("Börja om",
                                  style: TextStyle(
                                      fontFamily: "regular",
                                      fontSize: 14,
                                      color: Colors.black)),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(Icons.replay,
                                    size: 30, color: Colors.black),
                              )
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            )),
        body: content[qIndex]);
  }
}

class CurrentQuestion extends StatefulWidget {
  final bool hasBorder;
  final bool? isCorrect;
  const CurrentQuestion(
      {super.key, required this.hasBorder, required this.isCorrect});

  @override
  State<CurrentQuestion> createState() => _CurrentQuestionState();
}

class _CurrentQuestionState extends State<CurrentQuestion> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
            color: widget.isCorrect == null
                ? const Color.fromRGBO(208, 208, 208, 1)
                : widget.isCorrect == true
                    ? const Color.fromRGBO(34, 88, 165, 1)
                    : widget.isCorrect == false
                        ? const Color.fromRGBO(121, 121, 121, 1)
                        : null,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            border: widget.hasBorder
                ? Border.all(
                    width: 2,
                    color: const Color.fromRGBO(170, 170, 170, 1),
                    strokeAlign: BorderSide.strokeAlignOutside,
                  )
                : null),
      ),
    );
  }
}
