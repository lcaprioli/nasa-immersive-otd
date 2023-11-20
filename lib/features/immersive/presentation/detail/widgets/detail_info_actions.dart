import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

class DetailInfoActions extends StatelessWidget {
  const DetailInfoActions({
    super.key,
    required this.onToogle,
    required this.isVisible,
  });

  final VoidCallback onToogle;
  final bool isVisible;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          FilledButton(
            onPressed: () {
              SystemChrome.setPreferredOrientations([
                DeviceOrientation.portraitUp,
              ]);
              Modular.to.pop();
            },
            child: const Text('< Back'),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 100,
            child: FilledButton(
              onPressed: onToogle,
              child: Text('${isVisible ? 'Hide' : 'Show'} info'),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          FilledButton(
            onPressed: onToogle,
            child: const Text('-'),
          ),
          FilledButton(
            onPressed: onToogle,
            child: const Text('+'),
          ),
          FilledButton(
            onPressed: onToogle,
            child: const Text('L'),
          ),
          FilledButton(
            onPressed: onToogle,
            child: const Text('T'),
          ),
          FilledButton(
            onPressed: onToogle,
            child: const Text('B'),
          ),
          FilledButton(
            onPressed: onToogle,
            child: const Text('R'),
          ),
        ],
      ),
    );
  }
}
