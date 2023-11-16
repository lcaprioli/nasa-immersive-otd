import 'package:flutter/material.dart';

class TimelineError extends StatelessWidget {
  const TimelineError(this.onRefresh, {super.key});

  final VoidCallback onRefresh;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.crisis_alert,
          size: 95,
          color: Colors.amber,
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          'An error has occured, try again.',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.amber,
              ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 20,
        ),
        FilledButton(
          onPressed: onRefresh,
          child: const Text('Retry'),
        )
      ],
    );
  }
}
