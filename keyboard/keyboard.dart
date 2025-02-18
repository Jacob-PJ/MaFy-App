import 'package:flutter/material.dart';

typedef ToggleKeyboardVisibility = void Function();
typedef ToggleKeyboardButtons = void Function(int index);
typedef PartOfTextChange = void Function(int index);

class CustomKeyboard extends StatelessWidget {
  final TextEditingController controller;
  final bool visible;
  final ToggleKeyboardVisibility toggleKeyboardVisibility;
  final ToggleKeyboardButtons toggleKeyboardButtons;
  final int keyboardIndex;
  final int partOfText;
  final PartOfTextChange partOfTextChange;

  CustomKeyboard(
      {required this.controller,
      required this.visible,
      required this.toggleKeyboardVisibility,
      required this.toggleKeyboardButtons,
      required this.keyboardIndex,
      required this.partOfTextChange,
      required this.partOfText});

  bool isSelected(int index) {
    return keyboardIndex == index;
  }

  @override
  Widget build(BuildContext context) {
    List<Column> ButtonLayouts = [
      Column(
        children: [
          Row(
            children: [
              CloseButton(toggleKeyboardVisibility),
              SmallCustomButton("123", toggleKeyboardButtons, 0, isSelected(0)),
              SmallCustomButton("mer", toggleKeyboardButtons, 1, isSelected(1)),
            ],
          ),
          Row(
            children: [
              CustomButton(
                '*',
                '*',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '/',
                '/',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '(',
                '(',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                ')',
                ')',
                controller,
                partOfTextChange,
                partOfText,
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                '-',
                '-',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '1',
                '1',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '1',
                '2',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '3',
                '3',
                controller,
                partOfTextChange,
                partOfText,
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                '+',
                '+',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '4',
                '4',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '5',
                '5',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '6',
                '6',
                controller,
                partOfTextChange,
                partOfText,
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                '.',
                '.',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '7',
                '7',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '8',
                '8',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '9',
                '9',
                controller,
                partOfTextChange,
                partOfText,
              ),
            ],
          ),
          Row(
            children: [
              GoBackButton(partOfTextChange, partOfText, controller),
              ForwardButton(partOfTextChange, partOfText, controller),
              CustomButton(
                '0',
                '0',
                controller,
                partOfTextChange,
                partOfText,
              ),
              BackButton(controller, partOfTextChange, partOfText),
            ],
          ),
        ],
      ),
      Column(
        children: [
          Row(
            children: [
              CloseButton(toggleKeyboardVisibility),
              SmallCustomButton("123", toggleKeyboardButtons, 0, isSelected(0)),
              SmallCustomButton("mer", toggleKeyboardButtons, 1, isSelected(1)),
            ],
          ),
          Row(
            children: [
              CustomButton(
                'x',
                '*x',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                'y',
                '*y',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                'i',
                '*i',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                'e',
                '*e',
                controller,
                partOfTextChange,
                partOfText,
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                'π',
                '*π',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '|',
                '|',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '°',
                '°',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '!',
                '!',
                controller,
                partOfTextChange,
                partOfText,
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                '^',
                '^',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                '√',
                '√',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                'log',
                'log',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                'ln',
                'ln',
                controller,
                partOfTextChange,
                partOfText,
              ),
            ],
          ),
          Row(
            children: [
              CustomButton(
                'sin',
                'sin',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                'cos',
                'cos',
                controller,
                partOfTextChange,
                partOfText,
              ),
              CustomButton(
                'tan',
                'tan',
                controller,
                partOfTextChange,
                partOfText,
              ),
            ],
          ),
          Row(
            children: [
              GoBackButton(partOfTextChange, partOfText, controller),
              ForwardButton(partOfTextChange, partOfText, controller),
              BackButton(controller, partOfTextChange, partOfText),
            ],
          ),
        ],
      )
    ];

    if (visible == false) {
      return const SizedBox(
        height: 0,
        width: 0,
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
      child: Container(
        color: const Color.fromRGBO(250, 250, 250, 1),
        child: ButtonLayouts[keyboardIndex],
      ),
    );
  }
}

class CustomButton extends StatelessWidget {
  final String label;
  final String text;
  final TextEditingController controller;
  final PartOfTextChange partOfTextChange;
  final int partOfText;

  CustomButton(this.label, this.text, this.controller, this.partOfTextChange,
      this.partOfText);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              if (partOfText >= 0) {
                final text = this.text;
                final selection = controller.selection;
                final textBefore = controller.text.substring(0, partOfText);
                final textAfter = controller.text.substring(partOfText);
                final newText = '$textBefore$text$textAfter';
                final newSelection = selection.copyWith(
                  baseOffset: selection.baseOffset + text.length,
                  extentOffset: selection.baseOffset + text.length,
                );
                controller.value = TextEditingValue(
                  text: newText,
                  selection: newSelection,
                  composing: TextRange.empty,
                );
                partOfTextChange(partOfText + text.length);
              }
            },
            child: SizedBox(
              height: 64,
              child: Center(
                  child: Text(
                label,
                style: const TextStyle(fontSize: 18),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class SmallCustomButton extends StatelessWidget {
  final String text;
  final void Function(int) toggleKeyboardButtons;
  final int index;
  final bool isSelected;

  SmallCustomButton(
      this.text, this.toggleKeyboardButtons, this.index, this.isSelected);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: isSelected
              ? const Color.fromRGBO(201, 201, 201, 1)
              : const Color.fromRGBO(238, 238, 238, 1),
          borderRadius: BorderRadius.circular(10),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              toggleKeyboardButtons(index);
            },
            child: SizedBox(
              height: 35,
              child: Center(
                  child: Text(
                text,
                style: const TextStyle(fontSize: 18),
              )),
            ),
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  final TextEditingController controller;
  final PartOfTextChange partOfTextChange;
  final int partOfText;

  BackButton(this.controller, this.partOfTextChange, this.partOfText);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              if (partOfText > 0) {
                partOfTextChange(partOfText - 1);
              }
              final text = controller.text;
              if (text.isNotEmpty && partOfText > 0) {
                final newText = text.substring(0, partOfText - 1) +
                    text.substring(partOfText);
                controller.value = TextEditingValue(
                  text: newText,
                  selection: TextSelection.collapsed(offset: partOfText - 1),
                );
              }
            },
            child: const SizedBox(height: 64, child: Icon(Icons.backspace)),
          ),
        ),
      ),
    );
  }
}

class CloseButton extends StatelessWidget {
  final VoidCallback toggleKeyboardVisibility;

  CloseButton(this.toggleKeyboardVisibility);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: const Color.fromRGBO(238, 238, 238, 1),
          borderRadius: BorderRadius.circular(10),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              toggleKeyboardVisibility();
            },
            child: const SizedBox(
              height: 35,
              child: Center(
                  child: SizedBox(
                      height: 64,
                      child: Icon(
                        Icons.close,
                      ))),
            ),
          ),
        ),
      ),
    );
  }
}

class ForwardButton extends StatelessWidget {
  final PartOfTextChange partOfTextChange;
  final int partOfText;
  final TextEditingController controller;

  ForwardButton(this.partOfTextChange, this.partOfText, this.controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              if (partOfText < controller.text.length) {
                partOfTextChange(partOfText + 1);
              }
            },
            child: const SizedBox(
              height: 64,
              child: Center(
                  child: SizedBox(
                      height: 64,
                      child: Icon(
                        Icons.arrow_forward,
                      ))),
            ),
          ),
        ),
      ),
    );
  }
}

class GoBackButton extends StatelessWidget {
  final PartOfTextChange partOfTextChange;
  final int partOfText;
  final TextEditingController controller;

  GoBackButton(this.partOfTextChange, this.partOfText, this.controller);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(3),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          borderOnForeground: true,
          child: InkWell(
            onTap: () {
              if (partOfText > 0) {
                partOfTextChange(partOfText - 1);
              }
            },
            child: const SizedBox(
              height: 64,
              child: Center(
                  child: SizedBox(
                      height: 64,
                      child: Icon(
                        Icons.arrow_back,
                      ))),
            ),
          ),
        ),
      ),
    );
  }
}
