import 'package:flutter/material.dart';
import 'profile_page_content.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, right: 8),
          child: Column(
            children: [
              ProfileCategory(
                title: "Framgång",
                content: [
                  progressBarTitle("Matematik", "70%"),
                  progressBar(),
                  progressBarTitle("Fysik", "32%"),
                  progressBar(),
                  progressBarTitle("Prov medelpoeng (sista 3)", "41/75"),
                  progressBar()
                ],
              ),
              const NotificationProfilePage(
                  text: "1 månad kvar tills anmälan öppnas"),
              ProfileCategory(
                title: "Bokmärken",
                content: [
                  bookmark("Trigonometri", "trigonometry"),
                  bookmark("Trigonometri", "trigonometry")
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
