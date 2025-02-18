import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mafy/auth.dart';

import 'subject_content.dart';
import '../shared_prefrences_handler.dart';

class SubjectHomePage extends StatelessWidget {
  final String baseSubject;
  const SubjectHomePage({super.key, required this.baseSubject});

  @override
  Widget build(BuildContext context) {
    String recent = SharedPreferencesHandler.getRecentSubject(baseSubject);

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('kurser/${baseSubject.toLowerCase()}/områden')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Text("Loading...");

          return FutureBuilder(
              future: Auth().getTotalLessonsCount(baseSubject),
              builder: (context, totalQ) {
                return FutureBuilder(
                    future: Auth().getToatalProgress(baseSubject),
                    builder: (context, progress) {
                      int presentage = 0;

                      if (progress.data != null &&
                          totalQ.data != null &&
                          totalQ.data != 0) {
                        presentage =
                            ((progress.data! / totalQ.data!) * 100).round();
                      }
                      return Column(children: [
                        SubjectBox(
                          title: "Framgång",
                          content: [
                            progressBarTitle("Hela kurs", "$presentage%"),
                            progressBar(context, presentage),
                          ],
                        ),
                        if (recent.isNotEmpty)
                          SubjectBox(title: "Senast använd", content: [
                            lastUsed(
                                recent, "trigonometry", baseSubject, context),
                          ]),
                        SubjectBox(
                          title: "Områden",
                          content: List.generate(
                            snapshot.data!.docs.length,
                            (index) => subject(
                                context,
                                snapshot.data!.docs[index].data()['namn'],
                                "trigonometry",
                                baseSubject),
                          ),
                        ),
                        TestBox(
                          content: Stack(children: [
                            const Positioned(
                              top: 20,
                              left: 40,
                              child: Text(
                                "Kurs prov",
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
                                          const Color.fromRGBO(34, 88, 165, 1)),
                                  onPressed: () {},
                                  child: const Text("Starta"),
                                ),
                              ),
                            ),
                            const Positioned(
                                top: 25,
                                right: 40,
                                child: Text(
                                  "Ta ett prov som\ninehåller allt inom\nkursen. Provet är\nlikt den officiella.",
                                  style: TextStyle(
                                      fontFamily: "regular", fontSize: 14),
                                ))
                          ]),
                        )
                      ]);
                    });
              });
        });
  }
}
