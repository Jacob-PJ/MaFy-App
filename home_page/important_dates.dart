import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ImportantDates extends StatelessWidget {
  const ImportantDates({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
        title: const Text(
          "Datum",
          style: TextStyle(
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
            return SingleChildScrollView(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Align(
                alignment: Alignment.topCenter,
                child: Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: snapshot.data != null
                        ? Column(
                            children: List.generate(
                                snapshot.data!.docs.length,
                                (index) => DateListItem(
                                      title: snapshot.data!.docs[index]
                                          .data()["titel"],
                                      date: snapshot.data!.docs[index]
                                          .data()["datum"],
                                      status: snapshot.data!.docs[index]
                                          .data()["status"],
                                    )))
                        : const Text("Something went wrong"),
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getData() {
    final future = FirebaseFirestore.instance.collection("datum").get();

    return future;
  }
}

//datum
class DateListItem extends StatelessWidget {
  final String title;
  final Timestamp date;
  final bool status;
  const DateListItem(
      {super.key,
      required this.title,
      required this.date,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 5),
          child: SizedBox(
            height: 125,
            width: 330,
            child: Stack(children: [
              Positioned(
                  width: 90,
                  height: 110,
                  child: status == true
                      ? Column(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(39, 38, 38, 1),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        date.toDate().day.toString(),
                                        style: const TextStyle(
                                            fontSize: 28,
                                            fontFamily: "regular",
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  getMonthName(date.toDate().month),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontFamily: "regular",
                                      color: Colors.white),
                                ),
                              ]),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Text(
                                "${date.toDate().difference(DateTime.now()).inDays} dagar",
                                style: const TextStyle(
                                    fontSize: 10,
                                    fontFamily: "regular",
                                    color: Colors.black),
                              ),
                            ),
                          ],
                        )
                      : Column(children: [
                          Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(39, 38, 38, 1),
                                  borderRadius: BorderRadius.circular(100)),
                              child: const Column(children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 30),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Okännt",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: "regular",
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ]))
                        ])),
              Positioned(
                top: 18,
                left: 125,
                child: SizedBox(
                  width: 150,
                  height: 50,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                            fontSize: 20,
                            fontFamily: "regular",
                            color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              // Positioned(
              //   right: 0,
              //   top: 32,
              //   width: 30,
              //   height: 30,
              //   child: Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(100),
              //         border: Border.all(color: Colors.black, width: 1)),
              //   ),
              // ),
            ]),
          ),
        )
      ],
    );
  }
}

String getMonthName(int num) {
  switch (num) {
    case 1:
      return "JAN";
    case 2:
      return "FEB";
    case 3:
      return "MAR";
    case 4:
      return "APR";
    case 5:
      return "MAJ";
    case 6:
      return "JUN";
    case 7:
      return "JUL";
    case 8:
      return "AUG";
    case 9:
      return "SEP";
    case 10:
      return "OKT";
    case 11:
      return "NOV";
    case 12:
      return "DEC";
    default:
      return "error";
  }
}
