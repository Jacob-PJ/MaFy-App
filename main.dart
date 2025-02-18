import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_page/home_page.dart';
import 'explore_page/explore_page.dart';
import 'profile_page/profile_page.dart';
import 'shared_prefrences_handler.dart';
import 'package:mafy/profile_page/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter is initialized
  await Firebase.initializeApp(); // Initialize Firebase
  await SharedPreferencesHandler.initialize();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _fbApp = Firebase.initializeApp();
  late SharedPreferences _prefs;

  Future<void> setupSharedPrefrences() async {
    _prefs = await SharedPreferences.getInstance();
  }

  int _currentIndex = 0;

  List<Widget> body = const [
    HomePage(), ExplorePage()
    //, ProfilePage()
  ];

  @override
  void initState() {
    super.initState();
    setupSharedPrefrences();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: FutureBuilder(
          future: _fbApp,
          builder: ((context, snapshot) {
            {
              return Scaffold(
                body: StreamBuilder<User?>(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Scaffold(
                        appBar: AppBar(
                          toolbarHeight: 0,
                          elevation: 0,
                          backgroundColor:
                              const Color.fromRGBO(237, 237, 237, 1),
                          title: const Text(
                            "MaFy",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                          centerTitle: true,
                          //leading: const Icon(Icons.all_inclusive_sharp),
                          // actions: [
                          //   IconButton(
                          //     color: Colors.white,
                          //     onPressed: () {},
                          //     icon: const Icon(Icons.settings),
                          //   ),
                          // ],
                        ),
                        backgroundColor: const Color.fromRGBO(237, 237, 237, 1),
                        body: body[_currentIndex],
                        bottomNavigationBar: BottomNavigationBar(
                          elevation: 0,
                          currentIndex: _currentIndex,
                          backgroundColor: const Color.fromRGBO(34, 88, 165, 1),
                          unselectedItemColor: Colors.white,
                          items: const [
                            BottomNavigationBarItem(
                                icon: Icon(Icons.home), label: "Hem"),
                            BottomNavigationBarItem(
                                icon: Icon(Icons.menu_book_sharp),
                                label: "Ämnen"),
                            // BottomNavigationBarItem(
                            //     icon: Icon(Icons.person), label: "Profil"),
                          ],
                          onTap: (int newIndex) {
                            setState(() {
                              _currentIndex = newIndex;
                            });
                          },
                        ),
                      );
                    } else {
                      return const SignUpPage();
                    }
                  },
                ),
              );
            }
          }),
        ));
  }
}
