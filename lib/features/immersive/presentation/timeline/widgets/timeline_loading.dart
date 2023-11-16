import 'package:flutter/material.dart';
import 'package:nasa_immersive_od/features/immersive/presentation/timeline/widgets/timeline_logo.dart';

class TimelineLoading extends StatelessWidget {
  const TimelineLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const TimelineLogo(),
        SizedBox(
            width: 220,
            height: 220,
            child: CircularProgressIndicator(
                strokeWidth: 8, color: Theme.of(context).primaryColorDark)),
        SizedBox(
            width: 260,
            height: 260,
            child: CircularProgressIndicator(
                strokeWidth: 4, color: Theme.of(context).primaryColor)),
        SizedBox(
            width: 300,
            height: 300,
            child: CircularProgressIndicator(
              strokeWidth: 1,
              color: Theme.of(context).primaryColorLight,
            )),
      ],
    );
  }
}
