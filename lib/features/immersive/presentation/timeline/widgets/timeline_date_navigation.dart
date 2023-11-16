import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimelineDateNavigation extends StatelessWidget {
  const TimelineDateNavigation({
    super.key,
    required this.dates,
    required this.onPressed,
    required this.current,
  });

  final Set<DateTime> dates;
  final void Function(int) onPressed;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          dates.length,
          (index) => Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: FilledButton(
                style: index == current
                    ? FilledButton.styleFrom(
                        backgroundColor: Colors.deepOrangeAccent)
                    : null,
                onPressed: () => onPressed(index),
                child: Text(DateFormat.MMMd().format(dates.elementAt(index))),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
