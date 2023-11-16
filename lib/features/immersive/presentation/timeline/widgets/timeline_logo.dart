import 'package:flutter/material.dart';

class TimelineLogo extends StatelessWidget {
  const TimelineLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 150,
        height: 150,
        child: ClipOval(
          child: Container(
            color: Theme.of(context).primaryColorDark,
            padding: const EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'I',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  'O',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                Text(
                  'D',
                  style: Theme.of(context).textTheme.displaySmall,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
