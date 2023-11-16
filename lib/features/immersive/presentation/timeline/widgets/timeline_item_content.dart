import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:nasa_immersive_od/features/immersive/domain/entities/immersive_entity.dart';

class TimelineItemContent extends StatelessWidget {
  const TimelineItemContent(this.immersive, {super.key});
  final ImmersiveEntity immersive;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Image.memory(
                  Uint8List.fromList(immersive.imageBytes ?? []),
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Align(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      textStyle: Theme.of(context).textTheme.headlineSmall,
                      backgroundColor: Colors.black.withAlpha(80)),
                  onPressed: () =>
                      Modular.to.pushNamed('/detail', arguments: immersive),
                  child: const Text('Open Immersive'),
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Text(
            immersive.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
