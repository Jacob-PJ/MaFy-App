import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mafy/auth.dart';

import 'sub_subject_content.dart';
import '../shared_prefrences_handler.dart';

class SubSubject extends StatelessWidget {
  final String subject;
  final String baseSubject;
  const SubSubject(
      {super.key, required this.subject, required this.baseSubject});
  @override
  Widget build(BuildContext context) {
    SharedPreferencesHandler.updateRecentMixed(subject, baseSubject);
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
        title: Text(
          subject[0].toUpperCase() + subject.substring(1).toLowerCase(),
          style: const TextStyle(
            color: Colors.black,
            fontFamily: "semibold",
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.question_mark_rounded,
                color: Colors.black,
              )),
        ],
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
        future: getData(),
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
                      snapshot.data!.docs[subSubjectsIndex].data()["namn"]
                    ]);

            List<Widget> widgetList = [];

            List progressList = [];

            for (int i = 0; i < subSubjectList.length; i++) {
              widgetList.add(const SizedBox());
            }

            for (int i = 0; i < subSubjectList.length; i++) {
              if (subSubjectList[i][0] == null) {
                continue;
              }
              widgetList.insert(
                  subSubjectList[i][0],
                  SubjectBox(
                    title: subSubjectList[i][1],
                    subject: subject,
                    baseSubject: baseSubject,
                  ));
            }

            int presentage = 0;

            return FutureBuilder(
                future: Auth().getSubjectProgress(baseSubject, subject),
                builder: (context, progress) {
                  return FutureBuilder(
                      future: Auth()
                          .getTotalSubSubjectLessonsCount(baseSubject, subject),
                      builder: (context, totalQ) {
                        if (progress.data != null &&
                            totalQ.data != null &&
                            totalQ.data != 0) {
                          presentage =
                              ((progress.data! / totalQ.data!) * 100).round();
                        } else {
                          presentage = 0;
                        }

                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: Column(children: [
                              Progress(presentage: presentage),
                              Column(children: widgetList),
                              TestBox(
                                content: Stack(children: [
                                  const Positioned(
                                    top: 20,
                                    left: 40,
                                    child: Text(
                                      "Områdes prov",
                                      style: TextStyle(
                                          fontFamily: "regular", fontSize: 22),
                                    ),
                                  ),
                                  Positioned(
                                    top: 60,
                                    left: 40,
                                    child: SizedBox(
                                      height: 35,
                                      width: 100,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                const Color.fromRGBO(
                                                    34, 88, 165, 1)),
                                        onPressed: () {},
                                        child: const Text("Starta"),
                                      ),
                                    ),
                                  ),
                                  const Positioned(
                                      top: 25,
                                      right: 40,
                                      child: Text(
                                        "Ta ett prov som\ninehåller allt inom\nområdet så du vet\nvar du ligger.",
                                        style: TextStyle(
                                            fontFamily: "regular",
                                            fontSize: 14),
                                      ))
                                ]),
                              )
                            ]),
                          ),
                        );
                      });
                });
          }
        },
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() {
    final future = FirebaseFirestore.instance
        .collection(
            "kurser/${baseSubject.toLowerCase()}/områden/${subject.toLowerCase()}/under_områden")
        .get();

    return future;
  }
}
