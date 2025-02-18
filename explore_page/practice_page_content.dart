import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TextUnit extends StatelessWidget {
  final Text text;
  const TextUnit({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: text,
        ),
      ],
    );
  }
}

class ImageUnit extends StatelessWidget {
  final String image;
  const ImageUnit({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          constraints: const BoxConstraints(maxWidth: 350),
          child: Image.asset("assets/images/$image.png"),
        )
      ],
    );
  }
}

class MathUnit extends StatelessWidget {
  final String text;
  const MathUnit({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TeXView(
          renderingEngine: const TeXViewRenderingEngine.katex(),
          child: TeXViewDocument(
            text,
          ),
        ),
      ],
    );
  }
}
