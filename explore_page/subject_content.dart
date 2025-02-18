import 'package:flutter/material.dart';
import '../shared_prefrences_handler.dart';
import 'sub_subject.dart';

import '../auth.dart';

class SubjectBox extends StatelessWidget {
  final String title;
  final List<Widget> content;
  const SubjectBox({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
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
                    padding:
                        const EdgeInsets.only(left: 25, right: 25, bottom: 20),
                    child: Column(
                      children: content,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

progressBarTitle(title, progress) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(title + " ",
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: "regular",
                )),
            Text(progress,
                style: const TextStyle(fontSize: 14, fontFamily: "regular"))
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 32,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(39, 38, 38, 1),
                  borderRadius: BorderRadius.circular(11)),
              // child: TextButton(
              //   onPressed: () {},
              //   child: const Text(
              //     "Detaljer",
              //     style: TextStyle(color: Colors.white, fontFamily: "refular"),
              //   ),
              // ),
            )
          ],
        ),
      ],
    ),
  );
}

//progressbar
progressBar(context, int presentage) {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Column(
      children: [
        Stack(
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
              width:
                  (MediaQuery.of(context).size.width - 65) * presentage / 100,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(34, 88, 165, 1),
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

subject(context, String title, String image, String baseSubject) {
  return InkWell(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return SubSubject(
          subject: title,
          baseSubject: baseSubject,
        );
      }));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 30, left: 0, bottom: 10),
      child: Row(
        children: [
          Column(children: [
            SizedBox(
                height: 20,
                width: 20,
                child: Image(image: AssetImage("assets/images/$image.png"))),
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text(title,
                    style:
                        const TextStyle(fontSize: 16, fontFamily: "regular")),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

lastUsed(String title, String image, String baseSubject, context) {
  return InkWell(
    onTap: () {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (BuildContext context) {
        return SubSubject(subject: title, baseSubject: baseSubject);
      }));
    },
    child: Padding(
      padding: const EdgeInsets.only(top: 15, left: 0, bottom: 0),
      child: Row(
        children: [
          Column(children: [
            SizedBox(
                height: 20,
                width: 20,
                child: Image(image: AssetImage("assets/images/$image.png"))),
          ]),
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                Text(title,
                    style: const TextStyle(fontSize: 16, fontFamily: "regular"))
              ],
            ),
          ),
        ],
      ),
    ),
  );
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
