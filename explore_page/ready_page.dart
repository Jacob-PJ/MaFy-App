import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'question_page.dart';

import '../auth.dart';

class ReadyPage extends StatelessWidget {
  final String baseSubject;
  final String page;
  final String subject;
  final String subSubject;
  final bool isRandom;
  const ReadyPage(
      {super.key,
      required this.baseSubject,
      required this.page,
      required this.subject,
      required this.subSubject,
      required this.isRandom});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          page.replaceAll("_", " "),
          style: const TextStyle(
              color: Colors.black,
              fontFamily: "semibold",
              overflow: TextOverflow.clip),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
      ),
      body: FutureBuilder(
          future: getQuetionAmount(page, subject, subSubject),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text("something went wrong"));
            } else {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 75),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Redo att öva?",
                                style: TextStyle(
                                    fontFamily: "regular", fontSize: 25),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "${snapshot.data!.docs.length.toString()} frågor",
                                style: const TextStyle(
                                    fontFamily: "regular", fontSize: 17),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromRGBO(34, 88, 165, 1),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              child: const Text(
                                "Start",
                                style: TextStyle(
                                    fontFamily: "semibold", fontSize: 25),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) {
                                  return QuestionPage(
                                    baseSubject: baseSubject,
                                    subject: subject,
                                    subSubject: subSubject,
                                    page: page,
                                    isRandom: isRandom,
                                    numOfQ: snapshot.data!.docs.length,
                                    snapshot: snapshot.data,
                                  );
                                }));
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getQuetionAmount(
      String page, String subject, String field) {
    final future = FirebaseFirestore.instance
        .collection(
            "kurser/matematik/områden/${subject.toLowerCase()}/under_områden/${field.toLowerCase()}/lektioner/${page.toLowerCase()}/övningar")
        .get();
    return future;
  }
}

class DonePage extends StatelessWidget {
  final String baseSubject;
  final String subject;
  final String subSubject;
  final String page;
  final int correct;
  final int questions;

  const DonePage(
      {super.key,
      required this.baseSubject,
      required this.subject,
      required this.subSubject,
      required this.page,
      required this.correct,
      required this.questions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Text(
          page.replaceAll("_", " "),
          style: const TextStyle(
              color: Colors.black,
              fontFamily: "semibold",
              overflow: TextOverflow.clip),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: Auth()
              .getUserQuestionLesson(baseSubject, subject, subSubject, page),
          builder: (context, snapshot) {
            bool complete = false;

            if (correct >= questions) {
              complete = true;
            }

            if (snapshot.data != null) {
              if (snapshot.data! < correct) {
                Auth().updateUserQuestionLesson(
                    baseSubject, subject, subSubject, page, correct, complete);
              }
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 75),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Bra jobbat!",
                              style: TextStyle(
                                  fontFamily: "regular", fontSize: 25),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "$correct / $questions",
                              style: const TextStyle(
                                  fontFamily: "regular", fontSize: 20),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromRGBO(34, 88, 165, 1),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8))),
                            child: const Text(
                              "Klar",
                              style: TextStyle(
                                  fontFamily: "semibold", fontSize: 25),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
