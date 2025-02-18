import 'package:flutter/material.dart';
import 'subject.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  int exploreIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: exploreIndex == 0
                                  ? const Color.fromRGBO(208, 208, 208, 1)
                                  : Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100))),
                          onPressed: () {
                            setState(() {
                              exploreIndex = 0;
                            });
                          },
                          child: const Row(
                            children: [
                              Text(
                                "Matematik",
                                style: TextStyle(
                                  fontFamily: "regular",
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Icon(
                                  Icons.plus_one,
                                  size: 22,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          )),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: exploreIndex == 1
                                    ? const Color.fromRGBO(208, 208, 208, 1)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onPressed: () {
                              setState(() {
                                exploreIndex = 1;
                              });
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Fysik",
                                  style: TextStyle(
                                    fontFamily: "regular",
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.apple,
                                    size: 19,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: exploreIndex == 2
                                    ? const Color.fromRGBO(208, 208, 208, 1)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100))),
                            onPressed: () {
                              setState(() {
                                exploreIndex = 2;
                              });
                            },
                            child: const Row(
                              children: [
                                Text(
                                  "Prov",
                                  style: TextStyle(
                                    fontFamily: "regular",
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Icon(
                                    Icons.menu_book_rounded,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                )
                              ],
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              IndexedStack(
                index: exploreIndex,
                children: const <Widget>[
                  SubjectHomePage(baseSubject: "Matematik"),
                  SubjectHomePage(baseSubject: "Fysik"),
                  SubjectHomePage(
                    baseSubject: "Prov",
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
