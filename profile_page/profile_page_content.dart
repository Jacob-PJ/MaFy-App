import 'package:flutter/material.dart';

import 'notifications_page.dart';

//Profile category
class ProfileCategory extends StatelessWidget {
  final String title;
  final List<Widget> content;
  const ProfileCategory(
      {super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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

//progressbar title
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
              height: 33,
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
progressBar() {
  return Padding(
    padding: const EdgeInsets.only(top: 15),
    child: Row(
      children: [
        Expanded(
          child: Container(
            height: 8,
            decoration: const BoxDecoration(
              color: Color.fromRGBO(217, 217, 217, 1),
              borderRadius: BorderRadius.all(
                Radius.circular(100),
              ),
            ),
          ),
        )
      ],
    ),
  );
}

//bookmark
bookmark(String title, image) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
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
          Padding(
            padding: const EdgeInsets.only(left: 160),
            child: Column(
              children: [
                Container(
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: Colors.black)),
                  child: IconButton(
                    icon: const Icon(Icons.remove),
                    iconSize: 20,
                    onPressed: () {},
                    padding: const EdgeInsets.only(left: 0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

//notification
class NotificationProfilePage extends StatelessWidget {
  final String text;
  const NotificationProfilePage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
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
                    padding:
                        const EdgeInsets.only(top: 15, left: 25, right: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Column(
                          children: [
                            Text("Notisar",
                                style: TextStyle(
                                    fontFamily: "semibold", fontSize: 16)),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              height: 32,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(34, 88, 165, 1),
                                  borderRadius: BorderRadius.circular(10)),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (BuildContext context) {
                                    return const NotificationsPage();
                                  }));
                                },
                                child: const Text(
                                  "Visa alla",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "refular"),
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
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
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 25, left: 10),
                          child: Row(
                            children: [
                              const Column(children: [
                                SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: Icon(Icons.notifications)),
                              ]),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Text(text,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            fontFamily: "regular"))
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 160),
                                child: Column(
                                  children: [
                                    Container(
                                      height: 22,
                                      width: 22,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border:
                                              Border.all(color: Colors.black)),
                                      child: IconButton(
                                        icon: const Icon(Icons.remove),
                                        iconSize: 20,
                                        onPressed: () {},
                                        padding: const EdgeInsets.only(left: 0),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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

class ProfileCard extends StatelessWidget {
  final String title;
  const ProfileCard({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20))),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 25, top: 10, bottom: 10),
                    child: Text(title,
                        style: const TextStyle(
                            fontFamily: "semibold", fontSize: 16)),
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
