import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'text_page_content.dart';

class TextPage extends StatelessWidget {
  final String page;
  final String subject;
  final String subSubject;
  const TextPage(
      {super.key,
      required this.page,
      required this.subject,
      required this.subSubject});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: FutureBuilder(
            future: getText(page, subject, subSubject),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(child: Text("something went wrong"));
              } else {
                final docs = snapshot.data!.docs;
                return Column(
                    children:
                        List.generate(snapshot.data!.docs.length, (index) {
                  if (docs[index].data()["typ"] == "text") {
                    return TextUnit(
                        text: Text(docs[index].data()["content"],
                            style: const TextStyle(
                                fontFamily: "regular", fontSize: 18)));
                  } else if (docs[index].data()["typ"] == "bold") {
                    return TextUnit(
                        text: Text(docs[index].data()["content"] + "\n",
                            style: const TextStyle(
                                fontFamily: "semibold", fontSize: 18)));
                  } else if (docs[index].data()["typ"] == "bild") {
                    return ImageUnit(
                      image: docs[index].data()["content"],
                    );
                  } else if (docs[index].data()["typ"] == "matte") {
                    return MathUnit(text: docs[index].data()["content"]);
                  } else {
                    return const TextUnit(text: Text(""));
                  }
                }));
              }
            },
          ),
        ),
      ),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getText(
      String page, String subject, String field) {
    final future = FirebaseFirestore.instance
        .collection(
            "kurser/matematik/områden/${subject.toLowerCase()}/under_områden/${field.toLowerCase()}/lektioner/${page.toLowerCase()}/text")
        .get();
    return future;
  }
}
