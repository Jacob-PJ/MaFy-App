import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:math_expressions/math_expressions.dart';

import '../keyboard/keyboard.dart';

Expression? answer;
String answerS = "";
List<String> oldAnswer = [];
int partOfText = 0;

final contextModel = ContextModel();

Parser p = Parser();

class InputPage extends StatelessWidget {
  final List<Widget> content;
  final List correct;
  const InputPage({super.key, required this.content, required this.correct});
  bool isCorrect() {
    if (answerS.isEmpty) {
      return false;
    }
    try {
      answer = p.parse(answerS.replaceFirst("_", ""));
    } catch (e) {
      return false;
    }

    contextModel.bindVariable(Variable('i'), p.parse("3.337129"));

    if (answer!.evaluate(EvaluationType.REAL, contextModel) ==
        correct[0].evaluate(EvaluationType.REAL, contextModel)) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: content,
                )
              ]),
            ),
          ),
        ),
        const Column(
          children: [Input()],
        )
      ],
    ));
  }
}

class Input extends StatefulWidget {
  const Input({super.key});

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  final TextEditingController _controller = TextEditingController();
  String _formattedText = '';
  String _unFormattedText = '';
  bool _keyboardVsisible = false;
  int keyboardIndex = 0;
  final FocusNode _focusNode = FocusNode();

  void requestTextFieldFocus() {
    _focusNode.requestFocus();
  }

  void clearInput() {
    setState(() {
      _controller.clear();
      _controller.text = "";
      _formattedText = '';
      keyboardIndex = 0;
      partOfText = 0;
    });
  }

  void toggleKeyboardVisability() {
    setState(() {
      _keyboardVsisible = !_keyboardVsisible;
    });
  }

  void toggleKeyboardButtons(int index) {
    setState(() {
      keyboardIndex = index;
    });
  }

  void partOfTextChange(int index) {
    setState(() {
      partOfText = index;
      answerS = _controller.text;
      answerS =
          "${answerS.substring(0, partOfText)}_${answerS.substring(partOfText, answerS.length)}";
    });
  }

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      setState(() {
        answerS = _controller.text;
        answerS =
            "${answerS.substring(0, partOfText)}_${answerS.substring(partOfText, answerS.length)}";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Opacity(
              opacity: 0,
              child: TextField(
                focusNode: _focusNode,
                decoration: const InputDecoration(
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),
                controller: _controller,
                keyboardType: TextInputType.none,
                onChanged: (value) {
                  //_unFormattedText = inputCheck(value.replaceAll("^", "ˆ"));
                  setState(() {
                    answerS = value;
                  });

                  //_formattedText = r"$$" + _unFormattedText + r"$$";
                },
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            width: double.infinity,
            height: 60,
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(10)),
              child: TextButton(
                  onPressed: () {
                    requestTextFieldFocus();
                    setState(() {
                      toggleKeyboardVisability();
                    });
                  },
                  child: Text(
                    answerS,
                    style: TextStyle(color: Colors.black),
                  )),
            ),
          ),
        ),
        CustomKeyboard(
          toggleKeyboardButtons: toggleKeyboardButtons,
          keyboardIndex: keyboardIndex,
          controller: _controller,
          visible: _keyboardVsisible,
          toggleKeyboardVisibility: toggleKeyboardVisability,
          partOfTextChange: partOfTextChange,
          partOfText: partOfText,
        ),
      ],
    );
  }
}


// List toExpression(List<String> splitFormat) {
//   String exp = "";
//   int i = 0;
//   while (i < splitFormat.length - 1) {
//     switch (splitFormat[i]) {
//       case r"\":
//         if (splitFormat.getRange(i + 1, i + 5).join() == "frac") {
//           int op = 0;
//           int cl = 0;
//           int check = 2;
//           String forS = "";

//           for (int j = i + 6; j < splitFormat.length - 1; j++) {
//             if (splitFormat[j] == "{") {
//               forS = "$forS(";
//               op++;
//             } else if (splitFormat[j] == "}") {
//               forS = "$forS(";
//               cl--;
//             } else {
//               forS = "$forS$splitFormat[j]";
//             }

//             if (op == cl) {
//               check--;
//               if (check == 1) {
//                 forS = "$forS/";
//               } else if (check == 0) {
//                 j--;
//                 exp = "$exp$forS";
//                 splitFormat.replaceRange(i, j, exp.split(""));
//                 splitFormat.removeWhere((element) =>
//                     element == "" || element == "," || element == " ");

//                 break;
//               }
//             }
//           }
//         }
//         break;
//       default:
//     }
//     i++;
//   }
//   splitFormat.removeWhere(
//       (element) => element == "" || element == "," || element == " ");
//   return splitFormat;
// }

// String inputCheck(String value) {
//   for (int i = 0; i < value.length - 1; i++) {
//     switch (value[i]) {
//       case "√":
//         break;
//       case "ˆ":
//         String pow = "";
//         int j = i + 1;
//         int startAt = 0;
//         int endAt = 0;
//         if (i < value.length - 1) {
//           if (value[j] == "(") {
//             int closing = 0;
//             int opening = 0;

//             for (j; j < value.length - 1; j++) {
//               if (value[j] == "(") {
//                 opening++;
//               } else if (value[j] == ")") {
//                 closing++;
//               }
//               if (opening == closing) {
//                 if (j == value.length - 1) {
//                   j--;
//                   break;
//                 }
//                 if (value[j] == " ") {
//                   break;
//                 }
//               }
//             }
//             endAt = j + 1;
//             pow = value.substring(i + 1, j + 1);
//           } else {
//             for (j; j < value.length - 1; j++) {
//               if (value[j] == " ") {
//                 break;
//               }
//             }

//             if (value[j] == " ") {
//               endAt = j;
//               pow = value.substring(i + 1, j);
//             } else {
//               endAt = j + 1;
//               pow = value.substring(i + 1, j + 1);
//             }
//           }

//           value = value.replaceRange(i, endAt, r'^{' + " " + pow + '}');
//         }

//         break;
//       case '/':
//         int starFrom = 0;
//         int endAt = 0;
//         if (i < value.length - 1) {
//           int j = i - 1;
//           int k = i + 1;
//           String numerator = "";
//           String denomenator = "";
//           if (i != 0 && value[j] == ")") {
//             int closing = 0;
//             int opening = 0;
//             for (j; j >= 0; j--) {
//               if (value[j] == ")") {
//                 closing++;
//               }
//               if (value[j] == "(") {
//                 opening++;
//               }
//               numerator = value.substring(j, i);
//               if (opening == closing) {
//                 if (j == 0) {
//                   break;
//                 }
//                 if (value[j - 1] == " ") {
//                   if (numerator.trim().isEmpty == false) {
//                     break;
//                   }
//                 }
//               }
//             }
//             starFrom = j;
//           } else {
//             if (i != 0) {
//               for (j; j > 0; j--) {
//                 if (value[j] == " ") {
//                   if (numerator.trim().isEmpty == false) {
//                     break;
//                   }
//                 }
//                 if (value[j - 1] == "^") {
//                   break;
//                 }
//               }
//               if (double.tryParse(value[j]) != null) {
//                 numerator = value.substring(j, i);
//                 starFrom = j;
//               } else {
//                 numerator = value.substring(j + 1, i);
//                 starFrom = j + 1;
//               }
//             }
//           }

//           if (value[k] == "(") {
//             int closing = 0;
//             int opening = 0;

//             while (k < value.length) {
//               if (value[k] == "(") {
//                 opening++;
//               }
//               if (value[k] == ")") {
//                 closing++;
//               }
//               endAt = k + 1;
//               denomenator = value.substring(i + 1, k + 1);
//               if (opening == closing) {
//                 if (k == value.length - 1) {
//                   break;
//                 }
//                 if (value[k + 1] == " ") {
//                   break;
//                 }
//               }
//               k++;
//             }
//           } else {
//             for (k; k < value.length - 1; k++) {
//               if (value[k] == " ") {
//                 break;
//               }
//             }

//             if (value[k] == " ") {
//               endAt = k;
//               denomenator = value.substring(i + 1, k);
//             } else {
//               endAt = k + 1;
//               denomenator = value.substring(i + 1, k + 1);
//             }
//           }

//           value = value.replaceRange(starFrom, endAt,
//               r'\frac{' + numerator + '}{' + denomenator + '}');
//         }
//         break;
//     }
//   }
//   return value;
// }
