import 'package:flutter/material.dart';

class DetailInfoTitle extends StatelessWidget {
  const DetailInfoTitle(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(.8),
      padding: const EdgeInsets.all(20),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
