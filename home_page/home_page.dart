import 'package:flutter/material.dart';
import 'home_page_content.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../shared_prefrences_handler.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<List<String>> content;
  @override
  void initState() {
    super.initState();
    content = SharedPreferencesHandler.getRecentMixed();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getDocumentWithClosestDate(DateTime.now()),
        builder: (context, snapshot) {
          return SingleChildScrollView(
            child: Center(
              child: SizedBox(
                width: 390,
                child: Column(
                  children: [
                    BigCard(
                        content:
                            Stack(children: homeUppcomming(context, snapshot))),
                    ListCard(
                      title: "Nyligen",
                      content: content,
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.only(bottom: 10),
                    //   child: ListCard(
                    //     title: "Rekomenderat",
                    //     top: "Trigonometri",
                    //     middle: "Algebrea",
                    //     bottom: "Andragradsekvationer",
                    //     imageTop: "trigonometry",
                    //     imageMiddle: "trigonometry",
                    //     imageBottom: "trigonometry",
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>?> getDocumentWithClosestDate(
      DateTime targetDate) async {
    CollectionReference<Map<String, dynamic>> collectionRef =
        FirebaseFirestore.instance.collection('datum');

    QuerySnapshot<Map<String, dynamic>> querySnapshot =
        await collectionRef.orderBy('datum').limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first;
    } else {
      return null;
    }
  }
}
