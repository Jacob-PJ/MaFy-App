import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'text_page.dart';
import 'ready_page.dart';
import '../error_page.dart';
import '../auth.dart';

class Progress extends StatelessWidget {
  final int presentage;
  const Progress({super.key, required this.presentage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(23),
          ),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, right: 10, left: 20),
                  child: Text(
                    "$presentage%",
                    style: const TextStyle(fontFamily: "regular", fontSize: 20),
                  ),
                )
              ],
            ),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 15, bottom: 10, right: 20),
                    child: Stack(
                      children: [
                        Container(
                          height: 8,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(217, 217, 217, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                        ),
                        Container(
                          height: 8,
                          width: (MediaQuery.of(context).size.width - 110) *
                              presentage /
                              100,
                          decoration: const BoxDecoration(
                            color: Color.fromRGBO(34, 88, 165, 1),
                            borderRadius: BorderRadius.all(
                              Radius.circular(100),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SubjectBox extends StatelessWidget {
  final String title;
  final String subject;
  final String baseSubject;
  const SubjectBox(
      {super.key,
      required this.title,
      required this.subject,
      required this.baseSubject});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getLessons(title, subject),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text("something went wrong"));
        } else {
          List subSubjectList = List.generate(
              snapshot.data!.docs.length,
              (subSubjectsIndex) => [
                    snapshot.data!.docs[subSubjectsIndex].data()["rad"],
                    snapshot.data!.docs[subSubjectsIndex].data()["namn"],
                    snapshot.data!.docs[subSubjectsIndex].data()["typ"],
                    snapshot.data!.docs[subSubjectsIndex].data()["random"] ??=
                        false
                  ]);

          List<Widget> widgetList = [];

          for (int i = 0; i < subSubjectList.length; i++) {
            widgetList.add(const SizedBox());
          }

          for (int i = 0; i < subSubjectList.length; i++) {
            if (subSubjectList[i][0] == null) {
              continue;
            }
            widgetList.insert(
                subSubjectList[i][0],
                makeSubSubject(context, subSubjectList[i][2],
                    subSubjectList[i][1], baseSubject, subject, title));
          }
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 20),
                          child: Text(title,
                              style: const TextStyle(
                                  fontFamily: "semibold", fontSize: 16)),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30))),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25, right: 25, bottom: 20),
                          child: Column(children: widgetList),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getLessons(
      String title, String field) {
    final future = FirebaseFirestore.instance
        .collection(
            "kurser/${baseSubject.toLowerCase()}/områden/${field.toLowerCase()}/under_områden/${title.toLowerCase()}/lektioner")
        .get();

    return future;
  }
}

class TestBox extends StatelessWidget {
  final Stack content;
  const TestBox({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
          height: 130,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
          ),
          child: content,
        )),
      ],
    );
  }
}

makeSubSubject(context, String type, String title, String baseSubject,
    String subject, String subSubject) {
  String img = type;
  int progress = 0;
  int numOfQ = 0;
  return FutureBuilder<dynamic>(
      future: type == "text"
          ? Auth().getUserTextLesson(baseSubject, subject, subSubject, title)
          : Auth()
              .getUserQuestionLesson(baseSubject, subject, subSubject, title),
      builder: (context, snapshot) {
        if (type == "text") {
          if (snapshot.data == true) {
            {
              img = "textDone";
            }
          }
        } else {
          if (snapshot.data == null) {
            progress = 0;
          } else {
            progress = snapshot.data;
          }
        }

        return FutureBuilder(
            future: type == "övning"
                ? getNumOfQ(baseSubject, subject, subSubject, title)
                : null,
            builder: (context, snapshot) {
              if (type == "övning") {
                if (snapshot.data == null) {
                  numOfQ = 0;
                } else {
                  numOfQ = snapshot.data!.docs.length;
                }

                if (progress == numOfQ) {
                  img = "övningDone";
                } else {
                  img = "övning";
                }
              }

              return InkWell(
                onTap: () async {
                  if (type == "text") {
                    await Auth().updateUserTextLesson(
                        baseSubject, subject, subSubject, title);
                  }
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    if (type == "text") {
                      return TextPage(
                        page: title,
                        subject: subject,
                        subSubject: subSubject,
                      );
                    } else if (type == "övning") {
                      return ReadyPage(
                        baseSubject: baseSubject,
                        page: title,
                        subject: subject,
                        subSubject: subSubject,
                        isRandom: false,
                      );
                    } else {
                      return const ErrorPage();
                    }
                  }));
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 0, bottom: 5),
                  child: Row(
                    children: [
                      Column(children: [
                        SizedBox(
                            height: 23,
                            width: 23,
                            child: Image(
                              image: AssetImage("assets/images/$img.png"),
                            )),
                        type == "övning"
                            ? Text(
                                "$progress/$numOfQ",
                                style: const TextStyle(fontFamily: "regular"),
                              )
                            : const SizedBox()
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Column(
                          children: [
                            Text(title.replaceAll("_", " "),
                                style: const TextStyle(
                                    fontSize: 16, fontFamily: "regular"))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      });
}

Future<QuerySnapshot<Map<String, dynamic>>> getNumOfQ(
    String baseSubject, String subject, String subSubject, String title) {
  final future = FirebaseFirestore.instance
      .collection(
          "kurser/${baseSubject.toLowerCase()}/områden/${subject.toLowerCase()}/under_områden/${subSubject.toLowerCase()}/lektioner/${title.toLowerCase()}/övningar")
      .get();

  return future;
}
