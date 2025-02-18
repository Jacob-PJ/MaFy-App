import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'important_dates.dart';

import '../explore_page/sub_subject.dart';

//Big card
class BigCard extends StatelessWidget {
  final Stack content;
  const BigCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
          child: Container(
            height: 230,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: content,
          ),
        )),
      ],
    );
  }
}

//Big card
class ListCard extends StatelessWidget {
  final String title;
  final List<List<String>> content;

  const ListCard({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(top: 10, left: 8, right: 8),
            child: Container(
                height: 50 * content.length.toDouble() + 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25, top: 15),
                          child: Row(children: [
                            Text(title,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: "semibold",
                                    fontSize: 16)),
                          ]),
                        ),
                      ),
                      for (final item in content)
                        ListCardItem(
                            name: item[0],
                            image: "trigonometry",
                            baseSubject: item[1]),
                    ],
                  ),
                )),
          )),
        ],
      ),
    );
  }
}

//ListCardItem
class ListCardItem extends StatelessWidget {
  final String name, image, baseSubject;

  const ListCardItem(
      {Key? key,
      required this.name,
      required this.image,
      required this.baseSubject})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: InkWell(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (BuildContext context) {
            return SubSubject(
                subject: name.toLowerCase(), baseSubject: baseSubject);
          }));
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 35),
          child: Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/$image.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  name,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: "regular", fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Uppcomming
List<Positioned> homeUppcomming(
    context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>?> snapshot) {
  if (snapshot.data != null) {
    if (snapshot.data!["status"] == true) {
      return [
        const Positioned(
          top: 25,
          left: 30,
          child: Text(
            "Kommande",
            style: TextStyle(fontSize: 20, fontFamily: "semibold"),
          ),
        ),
        Positioned(
          top: 75,
          left: 30,
          width: 110,
          height: 110,
          child: Container(
            decoration: BoxDecoration(
                color: const Color.fromRGBO(39, 38, 38, 1),
                borderRadius: BorderRadius.circular(100)),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      snapshot.data!["datum"].toDate().day.toString(),
                      style: const TextStyle(
                          fontSize: 30,
                          fontFamily: "regular",
                          color: Colors.white),
                    ),
                  ),
                  Text(
                    getMonthName(snapshot.data!["datum"].toDate().month),
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: "regular",
                        color: Colors.white),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      "${snapshot.data!["datum"].toDate().difference(DateTime.now()).inDays} dagar",
                      style: const TextStyle(
                          fontSize: 13,
                          fontFamily: "regular",
                          color: Colors.black),
                    ),
                  ),
                ]),
          ),
        ),
        Positioned(
          top: 70,
          left: 190,
          child: SizedBox(
            width: 150,
            height: 50,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.data!["titel"],
                  style: const TextStyle(
                      fontSize: 30, fontFamily: "regular", color: Colors.black),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 155,
          right: 95,
          width: 90,
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const ImportantDates();
              }));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromRGBO(34, 88, 165, 1),
            ),
            child: const Text("More",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "semibold",
                )),
          ),
        ),
      ];
    }
    return [
      const Positioned(
        top: 25,
        left: 30,
        child: Text(
          "Kommande",
          style: TextStyle(fontSize: 20, fontFamily: "semibold"),
        ),
      ),
      Positioned(
          top: 75,
          left: 30,
          width: 110,
          height: 110,
          child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(39, 38, 38, 1),
                  borderRadius: BorderRadius.circular(100)),
              child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Okännt\ndatum",
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: "regular",
                            color: Colors.white))
                  ]))),
      Positioned(
        top: 70,
        left: 190,
        child: SizedBox(
          width: 150,
          height: 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                snapshot.data!["titel"],
                style: const TextStyle(
                    fontSize: 30, fontFamily: "regular", color: Colors.black),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 155,
        right: 95,
        width: 90,
        height: 30,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (BuildContext context) {
              return const ImportantDates();
            }));
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(34, 88, 165, 1),
          ),
          child: const Text("More",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "semibold",
              )),
        ),
      ),
    ];
  }
  return [];
}

//Old Papers
final homeOldPapers = [
  Positioned(
    top: 0,
    right: 0,
    width: 205,
    height: 230,
    child: Container(
      decoration: const BoxDecoration(
          image:
              DecorationImage(image: AssetImage("assets/images/testimg.png")),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(30), bottomRight: Radius.circular(30))),
    ),
  ),
  Positioned(
    top: 0,
    left: 0,
    width: 190,
    height: 230,
    child: Container(
      decoration: const BoxDecoration(
          color: Color.fromRGBO(34, 88, 165, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), bottomLeft: Radius.circular(30))),
    ),
  ),
  const Positioned(
    top: 20,
    left: 25,
    child: Text(
      "Tidigare prov",
      style:
          TextStyle(fontSize: 23, fontFamily: "regular", color: Colors.white),
    ),
  ),
  const Positioned(
    top: 60,
    left: 25,
    child: Text(
      "Ta tidigare prov\nför att få en idee\nvart du ligger.",
      style:
          TextStyle(fontSize: 16, fontFamily: "regular", color: Colors.white),
    ),
  ),
  Positioned(
    bottom: 25,
    left: 25,
    width: 90,
    height: 30,
    child: ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
      ),
      child: const Text("Öva",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "semibold",
          )),
    ),
  ),
];

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
