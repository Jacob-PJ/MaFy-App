import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
        title: const Text(
          "Notisar",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              NotificationsCard(
                content: [
                  notification("Trigonometri"),
                  notification("Trigonometri")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class NotificationsCard extends StatelessWidget {
  final List<Widget> content;
  const NotificationsCard({super.key, required this.content});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(30))),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, bottom: 10, top: 10),
                  child: Column(
                    children: content,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

notification(String title) {
  return InkWell(
    onTap: () {},
    child: Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, bottom: 10),
      child: Row(
        children: [
          const Column(children: [
            SizedBox(height: 20, width: 20, child: Icon(Icons.notifications)),
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
