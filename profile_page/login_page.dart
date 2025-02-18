import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../auth.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final bool _isLogIn = false;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() => _loading = true);

    if (_isLogIn) {
      await Auth().signInWithEmailAndPassword(email, password);
    } else {
      await Auth().registerWithEmailAndPassword(email, password);
    }

    setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return (Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(
              height: 150,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Register",
                    style: TextStyle(fontFamily: "semibold", fontSize: 30),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 20),
              child: TextFormField(
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                    hintText: "email",
                    prefixIcon: Icon(
                      Icons.mail_outline,
                      color: Colors.black,
                    )),
              ),
            ),
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter a valid password';
                }
                return null;
              },
              decoration: const InputDecoration(
                  hintText: "password",
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    color: Colors.black,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, bottom: 25),
              child: Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () => handleSubmit(),
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  100), // Set the desired radius value
                            ),
                            backgroundColor:
                                const Color.fromRGBO(34, 88, 165, 1)),
                        child: _loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                _isLogIn ? 'Login' : 'Register',
                                style: const TextStyle(
                                    fontFamily: "semibold", fontSize: 20),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                "Already have an account?",
                style: TextStyle(fontFamily: "regular"),
              )
            ]),
            TextButton(
              onPressed: () {},
              child: Text("LOGIN", style: TextStyle(color: Colors.black)),
            )
          ],
        ),
      ),
    ));
  }
}

// class Login extends StatelessWidget {
//   final VoidCallback changeState;
//   const Login({super.key, required this.changeState});

//   @override
//   Widget build(BuildContext context) {
//     final TextEditingController _emailController = TextEditingController();
//     final TextEditingController _passwordController = TextEditingController();

//     return Padding(
//       padding: EdgeInsets.all(20),
//       child: Form(
//         child: Column(
//           children: [
//             const SizedBox(
//               height: 150,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "Login",
//                     style: TextStyle(fontFamily: "semibold", fontSize: 30),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 40, bottom: 20),
//               child: TextFormField(
//                 controller: _emailController,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Enter a valid email';
//                   }
//                   return null;
//                 },
//                 decoration: const InputDecoration(
//                     hintText: "email",
//                     prefixIcon: Icon(
//                       Icons.mail_outline,
//                       color: Colors.black,
//                     )),
//               ),
//             ),
//             TextFormField(
//               controller: _passwordController,
//               obscureText: true,
//               validator: (value) {
//                 if (value == null || value.isEmpty) {
//                   return 'Enter a valid password';
//                 }
//                 return null;
//               },
//               decoration: const InputDecoration(
//                   hintText: "password",
//                   prefixIcon: Icon(
//                     Icons.lock_outline,
//                     color: Colors.black,
//                   )),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 50, bottom: 25),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(
//                                   100), // Set the desired radius value
//                             ),
//                             backgroundColor:
//                                 const Color.fromRGBO(34, 88, 165, 1)),
//                         child: const Text(
//                           "Login",
//                           style:
//                               TextStyle(fontFamily: "semibold", fontSize: 20),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//               Text(
//                 "Dont have an account yet?",
//                 style: TextStyle(fontFamily: "regular"),
//               )
//             ]),
//             TextButton(
//               onPressed: () {
//                 changeState();
//               },
//               child: Text("REGISTER", style: TextStyle(color: Colors.black)),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
