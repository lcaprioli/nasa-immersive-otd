import 'package:flutter/material.dart';

class TimelinePageNavigation extends StatelessWidget {
  const TimelinePageNavigation({
    super.key,
    required this.page,
    required this.prev,
    required this.next,
  });

  final int page;
  final VoidCallback prev;
  final VoidCallback next;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.grey,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: FilledButton(
                onPressed: prev,
                child: const Text('< Previous'),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: FilledButton(
                onPressed: page > 0 ? next : null,
                child: const Text('Next >'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
