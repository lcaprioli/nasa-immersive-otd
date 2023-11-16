import 'package:flutter/material.dart';

class DetailInfoExplanation extends StatelessWidget {
  const DetailInfoExplanation(this.explanation, {super.key});

  final String explanation;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ColoredBox(
        color: Colors.white.withOpacity(.9),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Text(
              explanation,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
    );
  }
}
